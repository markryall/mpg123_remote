class Mpg123Remote::Console
  LENGTH=50

  def change s
    print "\b" * LENGTH unless @first
    @first = false
    print s.rjust LENGTH
  end

  def write s
    puts unless @first
    @first = true
    puts s
  end
end
