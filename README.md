# Mpg123Remote

This is a set of console commands to simplify remote interaction with mpg123.

## Preparation

This requires that mpg123 is installed and some fifo pipes have been created.

On mac os x using homebrew, run:

    brew install mpg123
    mkfifo /tmp/mpg123in
    mkfifo /tmp/mpg123out   

## Usage

In one console:

    (mpg123 --remote --fifo /tmp/mpg123in 2> /dev/null > /tmp/mpg123out &) && mpg123_parse

This console will now show the current player status, current track, seconds remaining, etc.

The player can now be controller from any other console with the following commands:

    mpg123_remote load track01.mp3
    mpg123_remote pause
    mpg123_remote stop
    mpg123_remote pitch +0.20
    mpg123_remote pitch -0.20
    mpg123_remote volume 20
    mpg123_remote volume 80
    mpg123_somafm secretagent

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mpg123_remote/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
