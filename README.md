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
> init.

append dep in mix.exs:

    defp deps do
        [
        {:logger_file_backend, "~> 0.0.10"},
        {:distillery, "~> 2.0", warn_missing: false},
        {:edeliver, ">= 1.6.0"},
        ]
    end

install them:

    $ mix do deps.clean --unlock --unused, deps.get, deps.compile
    Resolving Hex dependencies...
    Dependency resolution completed:
    Unchanged:
    logger_file_backend 0.0.11
    New:
    artificery 0.4.2
    distillery 2.1.1
    edeliver 1.7.0
    * Getting distillery (Hex package)
    * Getting edeliver (Hex package)
    * Getting artificery (Hex package)
    ==> artificery
    Compiling 10 files (.ex)
    Generated artificery app
    ==> distillery
    Compiling 33 files (.ex)
    Generated distillery app
    ==> edeliver
    Compiling 32 files (.ex)
    Generated edeliver app

distillery at first:

    $ mix distillery.init
    Compiling 3 files (.ex)
    Generated clock app

    An example config file has been placed in rel/config.exs, review it,
    make edits as needed/desired, and then run `mix distillery.release` to build the release

distillery built release:

    $ mix distillery.release
    ==> Assembling release..
    ==> Building release clock:0.1.0 using environment dev
    ==> You have set dev_mode to true, skipping archival phase
    Release successfully built!
    To start the release you have built, you can use one of the following tasks:

        # start a shell, like 'iex -S mix'
        > _build/dev/rel/clock/bin/clock console

        # start in the foreground, like 'mix run --no-halt'
        > _build/dev/rel/clock/bin/clock foreground

        # start in the background, must be stopped with the 'stop' command
        > _build/dev/rel/clock/bin/clock start

    If you started a release elsewhere, and wish to connect to it:

        # connects a local shell to the running node
        > _build/dev/rel/clock/bin/clock remote_console

        # connects directly to the running node's console
        > _build/dev/rel/clock/bin/clock attach

    For a complete listing of commands and their use:

        > _build/dev/rel/clock/bin/clock help

try the release:

    $ _build/dev/rel/clock/bin/clock start
    ...
    $ _build/dev/rel/clock/bin/clock stop

not any error/export, but the `$ tail -f clock_debug.log` is echo immediately:

    07:56:35.114 [info] Clock srv. ~> [0.1.0]: 2019-10-17T23:56:35.114648Z
    07:56:36.115 [info] Clock srv. ~> [0.1.0]: 2019-10-17T23:56:36.115465Z
    07:56:37.116 [info] Clock srv. ~> [0.1.0]: 2019-10-17T23:56:37.116398Z
    08:22:54.373 [info] Init. with 1000 ms interval ;-)
    08:22:54.373 [info] Clock srv. ~> [0.1.0]: 2019-10-18T00:22:54.373308Z
    08:22:55.374 [info] Clock srv. ~> [0.1.0]: 2019-10-18T00:22:55.374295Z
    08:22:56.375 [info] Clock srv. ~> [0.1.0]: 2019-10-18T00:22:56.375415Z

> try update release by  distillery

update version in mix.exs:

    ...
    version: "0.1.1",

usage `$ mix distillery.release`, and re-try:

    ༄  _build/dev/rel/clock/bin/clock start
    init terminating in do_boot ({undef,[{Elixir.Distillery.Releases.Config.Provider,init,[[_]],[]},{init,eval_script,2,[]},{init,do_boot,3,[]}]})

    Crash dump is being written to: erl_crash.dump...done
    =CRASH REPORT==== 18-Oct-2019::08:26:44.167237 ===
    
    ...

    {"init terminating in do_boot",{undef,[{'Elixir.Distillery.Releases.Config.Provider',init,[[]],[]},{init,eval_script,2,[]},{init,do_boot,3,[]}]}}
    Unable to configure release!

Hummm? than try: `$ MIX_ENV=prod mix distillery.release` :

    ==> logger_file_backend
    Compiling 1 file (.ex)
    Generated logger_file_backend app
    ==> artificery
    Compiling 10 files (.ex)
    Generated artificery app
    ==> distillery
    Compiling 33 files (.ex)
    Generated distillery app
    ==> edeliver
    Compiling 32 files (.ex)
    Generated edeliver app
    ==> clock
    Compiling 3 files (.ex)
    Generated clock app
    ==> Assembling release..
    ==> Building release clock:0.1.1 using environment prod
    ==> Including ERTS 10.2 from /Users/zoomq/.asdf/installs/erlang/21.2/erts-10.2
    ==> Packaging release..
    Release successfully built!
    To start the release you have built, you can use one of the following tasks:

        # start a shell, like 'iex -S mix'
        > _build/prod/rel/clock/bin/clock console

        # start in the foreground, like 'mix run --no-halt'
        > _build/prod/rel/clock/bin/clock foreground

        # start in the background, must be stopped with the 'stop' command
        > _build/prod/rel/clock/bin/clock start

    If you started a release elsewhere, and wish to connect to it:

        # connects a local shell to the running node
        > _build/prod/rel/clock/bin/clock remote_console

        # connects directly to the running node's console
        > _build/prod/rel/clock/bin/clock attach

    For a complete listing of commands and their use:

        > _build/prod/rel/clock/bin/clock help

re-try the release:

    $ _build/prod/rel/clock/bin/clock start
    ...
    $ _build/prod/rel/clock/bin/clock stop

not error, and log is flush:

    ...
    08:23:04.383 [info] Clock srv. ~> [0.1.0]: 2019-10-18T00:23:04.383374Z
    08:23:05.384 [info] Clock srv. ~> [0.1.0]: 2019-10-18T00:23:05.384356Z
    08:31:36.600 [info] Init. with 1000 ms interval ;-)
    08:31:36.600 [info] Clock srv. ~> [0.1.1]: 2019-10-18T00:31:36.600809Z
    08:31:37.601 [info] Clock srv. ~> [0.1.1]: 2019-10-18T00:31:37.601634Z
    08:31:38.602 [info] Clock srv. ~> [0.1.1]: 2019-10-18T00:31:38.602405Z

double confirm the release flow:

- update version in mix.exs
- debug in iex
- re-build by `$ MIX_ENV=prod mix distillery.release`
- test by run `_build/prod/rel/clock/bin/clock`

...logging:


    $ iex -S mix
    Erlang/OTP 21 [erts-10.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

    Compiling 3 files (.ex)
    Generated clock app
    Interactive Elixir (1.9.1) - press Ctrl+C to exit (type h() ENTER for help)
    iex(1)>

    ...
    # ...clock_debug.log
    ...
    08:42:06.389 [info] Init. with 1000 ms interval ;-)
    08:42:06.394 [info] Clock srv... [0.1.3]: 2019-10-18T00:42:06.392745Z
    08:42:07.395 [info] Clock srv... [0.1.3]: 2019-10-18T00:42:07.395154Z

    $ MIX_ENV=prod mix distillery.release
    Generated clock app
    ==> Assembling release..
    ==> Building release clock:0.1.3 using environment prod
    ==> Including ERTS 10.2 from /Users/zoomq/.asdf/installs/erlang/21.2/erts-10.2
    ==> Packaging release..
    Release successfully built!
    To start the release you have built, you can use one of the following tasks:

        # start a shell, like 'iex -S mix'
        > _build/prod/rel/clock/bin/clock console
    ...

look like is all right, BUT:

    $ _build/prod/rel/clock/bin/clock start
    ...
    $ _build/prod/rel/clock/bin/clock stop

not error, and log is flush:

    ...
    08:42:10.398 [info] Clock srv... [0.1.3]: 2019-10-18T00:42:10.397919Z
    08:42:11.398 [info] Clock srv... [0.1.3]: 2019-10-18T00:42:11.398862Z
    08:44:54.119 [info] Init. with 1000 ms interval ;-)
    08:44:54.119 [info] Clock srv. ~> [0.1.1]: 2019-10-18T00:44:54.119757Z
    08:44:55.120 [info] Clock srv. ~> [0.1.1]: 2019-10-18T00:44:55.120457Z
    08:44:56.121 [info] Clock srv. ~> [0.1.1]: 2019-10-18T00:44:56.121594Z

>> Hummm?

but `$ _build/prod/rel/clock/bin/clock describe` report:

    ==> Gathering release description..
    clock-0.1.3
    System Info ===========================
    OS:     Darwin 16.7.0
    ERTS:   10.2
    Status: stopped
    Release Info ==========================
    Name:              clock_maint_@127.0.0.1
    Version:           0.1.3
    ...



## questions

## logging

- 191017 creat github for ask elixirforum.com
- 191015 eDeliver not real upgrade?
- 191009 eDeliver start
- 190927 init. local

