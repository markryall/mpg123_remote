require 'redis'
require 'pathname'

class Mpg123Remote::Notifier
  attr_reader :redis

  def initialize
    @redis = Redis.new
  end

  def enqueue path
    Pathname.new(path).find do |p|
      push p if audio?(p)
    end
  end

  private

  def push p
    begin
      redis.publish 'music', "QUEUE #{p}"
    rescue Redis::CannotConnectError
      puts "Cannot connect to redis - is it running?"
      exit 1
    end
  end

  def audio? p
    p.file? && p.extname == '.mp3'
  end
end
