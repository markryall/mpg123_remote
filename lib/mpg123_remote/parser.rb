require 'redis'

class Mpg123Remote::Parser
  attr_reader :console, :announcer, :in_path, :redis

  def initialize console, announcer, in_path='/tmp/mpg123out'
    @console, @announcer, @in_path, @out_path = console, announcer, in_path
    @redis = Redis.new
  end

  def parse
    File.open(in_path) do |in_file|
      while line=in_file.gets
        parse_line line
      end
    end
  end

  def parse_line line
    File.open('debug.log', 'w+') {|d| d.puts line } if ENV['DEBUG']
    case line
    when /^@F (\d+) (\d+) ([\d\.]+) ([\d\.]+)$/
      frames, frames_left, seconds, seconds_left = $1, $2, $3, $4
      console.change "#{seconds} seconds (#{seconds_left} remaining)"
    when /@I ICY-META: StreamTitle='(.*) - (.*)';StreamUrl='http:\/\/SomaFM.com\/(.*)\/';/
      artist, track, station = $1, $2, $3
      console.write "#{track} by #{artist} (#{station} on somafm)"
      announcer.announce "#{track} by #{artist}"
    when /@P (\d)/
      File.open('/tmp/mpg123state', 'w') {|s| s.puts $1 }
      publish_state $1
    else
      File.open('debug.log', 'w+') {|d| d.puts "<unprocessed>" } if ENV['DEBUG']
    end
  end

  def publish_state state
    begin
      redis.publish 'music', "STATE #{state}"
    rescue Redis::CannotConnectError
      File.open('debug.log', 'w+') {|d| d.puts "skipping redis notification" } if ENV['DEBUG']
    end
  end
end
