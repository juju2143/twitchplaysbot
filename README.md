twitchplaysbot
==============

Simple opensource reimplementation of the Twitch Plays Pokémon bot, in case you want to make your own.

Only tested with [FCEUX](http://www.fceux.com/) and [Snes9x-rr](https://code.google.com/p/snes9x-rr/), but should work with most emulators with Lua support out there (usually the "rerecording" forks as described [here](http://tasvideos.org/EmulatorResources.html) and [here](http://tasvideos.org/LuaScripting.html)). Some games might or might not work due to the way they handle inputs. I will not provide you with ROM files, you know where to find them ;)

Installation
------------
1.  Get and install your favorite emulator as described in the paragraph above and load up a game.
2.  Put the .lua files in the same folder, remove the .example to the settings.lua.example file and edit it accordingly.
3.  If your emulator don't natively support Lua sockets, download [the latest version of LuaSocket](http://files.luaforge.net/releases/luasocket/luasocket/luasocket-2.0.2) and unzip the folders (not lua5.1.dll and lua5.1.exe found in the root of the .zip) in the directory where your emulator is installed.
4.  Load up ircbot.lua in the Lua scripting dialog of the emulator, run it and have fun!
5.  Optionally set up Twitch to capture the output of the emulator if you set it up to run on irc.twitch.tv.

Only basic button/joypad commands are supported in the chat.
