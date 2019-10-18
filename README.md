# clock
> demo for learn eDeliver

## background
[Philipp Schmieder \- From Zero to Elixir Deployment \- ElixirConf EU 2019 \- YouTube](https://www.youtube.com/watch?v=Noawmmd6yxM)

- is great show, so try follow it leanning deployment in Elixer
- of course, not need docker ;-)

## try
> env:

local as `$ screenfetch`

```
                 -/+:.          zoomq@ZQ160626rMBP
                :++++.          OS: 64bit Mac OS X 10.12.6 16G2136
               /+++/.           Kernel: x86_64 Darwin 16.7.0
       .:-::- .+/:-``.::-       Uptime: 13d 13h 1m
    .:/++++++/::::/++++++/:`    Packages: 238
  .:///////////////////////:`   Shell: bash
  ////////////////////////`     Resolution: 2560x1600
 -+++++++++++++++++++++++`      DE: Aqua
 /++++++++++++++++++++++/       WM: Quartz Compositor
 /sssssssssssssssssssssss.      WM Theme: Blue
 :ssssssssssssssssssssssss-     CPU: Intel Core i7-5557U @ 3.10GHz
  osssssssssssssssssssssssso/`  GPU: Intel Iris Graphics 6100
  `syyyyyyyyyyyyyyyyyyyyyyyy+`  RAM: 9220MiB / 16384MiB
   `ossssssssssssssssssssss/
     :ooooooooooooooooooo+.
      `:+oo+/:-..-:/+o+/-
```

server as `$ screenfetch`

```
                          ./+o+-       zoomq@i3SPAM
                  yyyyy- -yyyyyy+      OS: Ubuntu 18.04 bionic
               ://+//////-yyyyyyo      Kernel: x86_64 Linux 4.15.0-65-generic
           .++ .:/++++++/-.+sss/`      Uptime: 10m
         .:++o:  /++++++++/:--:/-      Packages: 2199
        o:+o+:++.`..```.-/oo+++++/     Shell: bash 4.4.20
       .:+o:+o/.          `+sssoo+/    CPU: Intel Core i3-7100U @ 4x 2.4GHz [27.8°C]
  .++/+:+oo+o:`             /sssooo.   GPU: intel
 /+++//+:`oo+o               /::--:.   RAM: 1406MiB / 7848MiB
 \+/+o+++`o++o               ++////.
  .++.o+++oo+:`             /dddhhh.
       .+.o+oo:.          `oddhhhh+
        \+.++o+o``-````.:ohdhhhhh+
         `:o+++ `ohhhhhhhhyo++os:
           .o:`.syhhhhhhh/.oo++o`
               /osyyyyyyo++ooo+++/
                   ````` +oo+++o\:
                          `oo++.
```


### init. Clock

    $ mix new clock

got fresh empty Elixir app.

follow video creat clock lib, and improvement by logger_file_backend

- cread `config/config.exs` , define all need:
    + `config :clock` init `interval:` for `Clock.Server.init`
    + `config :logger` define the backend, export logging ->
        * `/opt/log/exs/clock_error.log`
        * `/opt/log/exs/clock_debug.log`

debug local base `iex -S mix`

    $ iex -S mix
    Erlang/OTP 21 [erts-10.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

    Compiling 3 files (.ex)
    Generated clock app
    Interactive Elixir (1.9.1) - press Ctrl+C to exit (type h() ENTER for help)
    iex(1)>

in another terminal auto check the export:

    $ tail -f clock_debug.log
    07:56:25.100 [info] Init. with 1000 ms interval ;-)
    07:56:25.105 [info] Clock srv. ~> [0.1.0]: 2019-10-17T23:56:25.103805Z
    07:56:26.105 [info] Clock srv. ~> [0.1.0]: 2019-10-17T23:56:26.105398Z
    07:56:27.106 [info] Clock srv. ~> [0.1.0]: 2019-10-17T23:56:27.106454Z
    ....

> Clock is working

### try eDeliver


## questions

## logging

- 191017 creat github for ask elixirforum.com
- 191015 eDeliver not real upgrade?
- 191009 eDeliver start
- 190927 init. local

