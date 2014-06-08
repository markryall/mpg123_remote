require 'mpg123_remote/version'

class Mpg123Remote::Player
  def initialize path='/tmp/mpg123in'
    @path = path
  end

  def pause
    execute 'PAUSE'
  end

  def play path
    execute "LOAD #{path}"
  end

private

  def execute command
    File.open(@path, 'w') do |f|
      f.puts command
    end
  end
end
