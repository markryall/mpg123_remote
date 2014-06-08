class Mpg123Remote::Player
  def initialize path='/tmp/mpg123in'
    @path = path
  end

  def somafm station
    station ||= 'secretagent'
    execute 'loadlist', 0, "http://somafm.com/startstream=#{station}.pls"
  end

  def play path
    execute "LOAD #{Dir.pwd}/#{path}"
  end

  def execute *args
    File.open(@path, 'w') do |f|
      f.puts args.join ' '
    end
  end
end
