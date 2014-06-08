# Mpg123Remote

This is a set of console commands to simplify remote interaction with mpg123.

## Usage

In one console:

    mkfifo /tmp/mpg123in
    mkfifo /tmp/mpg123out
    mpg123 --remote --fifo /tmp/mpg123in 2> /dev/null > /tmp/mpg123out &
    mpg123parse &

In another:

    mpg123play track01.mp3
    mpg123playstream 'http://somafm.com/startstream=secretagent.pls'
    mpg123stop
    mpg123pause
    mpg123speed +20
    mpg123speed -20
    mpg123volume +50
    mpg123volume -50

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mpg123_remote/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
