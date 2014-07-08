class Mpg123Remote::Announcer
  def announce message
    return if `which terminal-notifier` == ''
    `terminal-notifier -message "#{message}" -title somafm`
  end
end
