class Mpg123Remote::Parser
  attr_reader :console

  def initialize console, path='/tmp/mpg123out'
    @console, @path = console, path
  end

  def parse
    File.open(@path) do |f|
      while line=f.gets
        parse_line line
      end
    end
  end

  def parse_line line
    case line
    when /^@F (\d+) (\d+) ([\d\.]+) ([\d\.]+)$/
      frames, frames_left, seconds, seconds_left = $1, $2, $3, $4
      console.change "#{seconds} seconds (#{seconds_left} remaining)"
    when /@I ICY-META: StreamTitle='(.*) - (.*)';StreamUrl='http:\/\/SomaFM.com\/(.*)\/';/
      artist, track, station = $1, $2, $3
      console.write "#{track} by #{artist} (#{station} on somafm)"
    when /@P (\d)/
      File.open('/tmp/mpg123state', 'w') {|s| s.puts $1 }
    else
      File.open('debug.log', 'w+') {|d| d.puts line } if ENV['DEBUG']
    end
  end
end