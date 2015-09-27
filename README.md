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

### Play a track in current directory

    mpg123_play track01.mp3

### pause or unpause player

    mpg123_remote pause

### stop the player

    mpg123_remote stop

### change volume

    mpg123_remote volume 0
    mpg123_remote volume 20
    mpg123_remote volume 80
    mpg123_remote volume 100

### control pitch (speed)

    mpg123_remote pitch +0.20
    mpg123_remote pitch -0.20

### control equaliser

mpg123 has a 32 band equaliser for each channel (left and right)

The eq command takes parameters:

* <channel> 1 (left), 2 (right) or 3 (both)
* <band> 0-31
* <value> 1

    mpg123_remote eq 3 0 1.5
    mpg123_remote eq 3 31 0.5

### stream soma.fm channel

    mpg123_somafm secretagent

### queue manager

To queue music, you first need to run redis and the queue daemon:

    brew install redis
    redis-server /usr/local/etc/redis.conf
    bin/mpg123_queue_daemon

Now you can enqueue any number of files or directories containing music:

    bin/mpg123_queue ~/Music ~/Downloads/Music

The `mpg123_parse` application sends notifications to the queue daemon process when the player is started and paused.  When a track finishes and there is music in the queue, the queue daemon process will automatically start the next track.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mpg123_remote/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
