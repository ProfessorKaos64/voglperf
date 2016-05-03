# voglperf

Benchmarking tool for Linux OpenGL games. Spews frame information every second. Example:

```
##############################################################################
Voglperf framerates from pid 12106.
##############################################################################
3564.35 fps frames:3567 time:1000.74ms min:0.23ms max:14.72ms
4144.01 fps frames:4145 time:1000.24ms min:0.23ms max:1.20ms
4037.20 fps frames:4038 time:1000.20ms min:0.23ms max:1.20ms
4059.60 fps frames:4060 time:1000.10ms min:0.23ms max:1.09ms
```

Can also write frame times to a log file which can then be graphed with gnuplot, etc.

```
cat /tmp/voglperf.glxspheres64.2014_02_12-16_02_20.csv:
# Feb 12 16:02:20 - glxspheres64                                                                                                                                                    
# 3414.30 fps frames:3417 time:1000.79ms min:0.23ms max:15.00ms
0.42
0.34
0.30
0.30
0.29
0.29
```

# Building

Voglperf uses cmake for building and the binaries are put into the bin/ directory, with libraries in lib/. A Makefile is included to simplify this a bit and see how cmake is launched.

### Requirements if building on SteamOS

If you are using SteamOS, setup your environment (if you have not already done so):

 - Click **"Settings"** on top right.
 - Click **"Display > Interface"** on left.
 - Check **"Enable access to the Linux desktop"**.
 - Head back to main menu, click **"Exit"**, **"Return to Desktop"** (or hit ctrl+alt+F8)
 - Click **"Activities"** on top left, then **"Applications"**.
 - Click **"Terminal"** icon.
 - Type **`passwd`** and enter a password.

Ensure you have Debian sources added:

```
echo "deb http://ftp.debian.org/debian wheezy main contrib non-free" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
```
 
### Install build packages

Please ensure you have [multi-arch](https://wiki.debian.org/Multiarch/HOWTO) configured.

On Debian systems, the below should satisfy the requirements:
```
sudo apt-get install gdbserver nfs-common openssh-server ca-certificates cmake g++ gcc-multilib g++-multilib ncurses-dev mesa-common-dev libgl1-mesa-dev libgl1-mesa-dev:i386 libncurses5-dev libncurses5-dev:i386 libedit-dev libedit-dev:i386 libtinfo-dev libtinfo-dev:i386 libstdc++-dev libstdc++-dev:i386
```

### Building voglperf manually:

```
git clone https://github.com/ProfessorKaos64/voglperf
cd voglperf
make voglperf32
make voglperf64
```

A debian package can be built using debuild/pdebuild. This will install the binaries to /usr/bin/ and the libraries to /usr/lib. A package can also be found via packages.libregeek.org. The [SteamOS tools](https://github.com/ProfessorKaos64/SteamOS-Tools) package will update with your system.

# Running volglpef

The built binaries will be voglperf32 and voglperf64. Most games are 32 bit, so voglperf32 wil suffice.

### Run voglperf on SteamOS

You can run voglpeft via SSH, and also view/control it via the web interface. If you choose to run voglperf over SSH, run `ip addr` and note IP address of your SteamOS box. From there:

```
ssh desktop@127.16.10.93
cd voglperf
sudo -u steam bin/voglperfrun32
```

Run voglperf as "_steam_" user.
```
sudo -u steam bin/voglperfrun32
```

 - Double click **"Return to Steam"** (or hit ctrl+alt+f7)
 - Connect to voglperf url with Chrome or Firefox browser from another computer.
 - Browser should show something like:

### Run voglperf on other Debian systems
```
bin/voglperfrun32
```

# Working with voglperf

Once started, you should see something like:

```
Starting web server...
Started http://172.16.10.93:8081
```

### Help and commands

```
game start [steamid | filename]: Start game.
game stop: Send SIGTERM signal to game.
game set (steamid | filename): Set gameid to launch.
game args: set game arguments.
logfile start [seconds]: Start capturing frame time data to filename.
logfile stop: Stop capturing frame time data.
status: Print status and options.
quit: Quit voglperfrun.
logfile [on | off]: Frame time logging on.
verbose [on | off]: Frame time logging on.
fpsprint [on | off]: Frame time logging on.
fpsshow [on | off]: Frame time logging on.
dry-run [on | off]: Frame time logging on.
ld-debug [on | off]: Frame time logging on.
xterm [on | off]: Frame time logging on.
debugger-pause [on | off]: Frame time logging on.
```

### Launching games

 - Find your game's appID on [steamdb](http://steamdb.info/linux/)
  * For example, start TF2 with `game start 440`
  * Click **OK** button on "Allow game launch" dialog.

###  Logs

 - To capture logfile for 10 seconds, type:

  * `logfile start 10` ; 

 - Should see something like:

  * ` Logfile started: /tmp/voglperf.Team-Fortress-2.2014_04_01-06_28_16.csv (10 seconds).`  

  * `Logfile stopped: http://172.16.10.93:8081/logfile/tmp/voglperf.Team-Fortress-2.2014_04_01-06_28_16.csv`

 - Right click on logfile link and say "Open in New Tab" (or whatever).
 
Display graph in gnuplot (install gnuplot-x11):

> gnuplot -p -e 'set terminal wxt size 1280,720;set ylabel "milliseconds";set yrange [0:100]; plot "/tmp/voglperf.Team-Fortress-2.2014_02_13-13_06_20.csv" with lines'

Output graph to blah.png:

> gnuplot -p -e 'set output "blah.png";set terminal pngcairo size 1280,720 enhanced;set ylabel "milliseconds";set yrange [0:100]; plot "/tmp/voglperf.Team-Fortress-2.2014_02_13-13_06_20.csv" with lines'


### Notes
 - HTML needs to be cleaned up.
 - Occasionally web client will think two clients are connected and duplicated messages. (Needs to be tracked down.)
 - We are currently adding voglperf as a SteamOS package.


# Example Screenshots

![Example screenshot](https://raw.github.com/ValveSoftware/voglperf/master/screenshot.png)


# License and Credits

voglperf code is under the [MIT](http://opensource.org/licenses/MIT) License. The license file [Repository License](https://github.com/ValveSoftware/voglperf/blob/master/LICENSE) is stored within the repository.
