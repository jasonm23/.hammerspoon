# Hammerspoon config

This is a [Hammerspoon Config][1], originally based on [@mgee's][2] [(mgee/dotfiles/hammerspoon)][3].

It's written in [Moonscript][4], enjoy.

The following rocks are required:

    luarocks install moses
    luarocks install moonscript

# Changelog

### Fix up 2015-07-20

- Cleaned up README
- git ignore usr/ folder (so that local tree of luarocks can be installed without storage in repo)

### Removed Splash animation 2015-07-20

- Nice, but too annoying when editing the config.

### App Modal, Splash animation 2015-06-26

- Modal selection of apps. <kbd>Cmd</kbd> + <kbd>Opt</kbd> + <kbd>a</kbd>
    - iTerm2 - <kbd>t</kbd>
    - Emacs - <kbd>e</kbd>
    - MacVim - <kbd>v</kbd>
    - Finder - <kbd>f</kbd>
    - Google Chrome - <kbd>c</kbd>

### Added  Lua 5.3 upgrade 2015-07-17

### Added Toggle Wifi 2015-07-01

- Added toggle wifi
- Added animated splash

### Added Modal application selection 2015-06-26

- Added modal application selection <kbd>Cmd</kbd> + <kbd>Alt</kbd> + <kbd>a</kbd> -> [<kbd>v</kbd>]im, [<kbd>t</kbd>]erm, [<kbd>e</kbd>]macs, [<kbd>c</kbd>]hrome, [<kbd>f</kbd>]inder

### Added activateNewChrome 2015-06-25

- Switch to newly launched Chrome - <kbd>MASH</kbd> + <kbd>=</kbd>
    - (ie. for jasmine / rspec test browser instance)
- Set grid to 8w x 6h
- Added moses (underscore for Lua)

### Updated Modal System 2015-06-24

- Modal resizing and moving
- Vim / Emacs / arrow direction key support <kbd>h</kbd>, <kbd>j</kbd>, <kbd>k</kbd> / <kbd>C-p</kbd>, <kbd>C-n</kbd>, <kbd>C-b</kbd>, <kbd>C-f</kbd>
    - Show a banner while modes are active
    - Don't use alerts

### Added README 2015-06-23

- You're looking at it.

### Initial commit 2015-06-23

- Modal move/resize/position modes
<<<<<<< HEAD

- MASH (<kbd>Cmd</kbd> + <kbd>Ctrl</kbd> + <kbd>Opt</kbd>) hotkeys for position, size, app switching

- Applications

    - iTerm2         <kbd>MASH</kbd> + <kbd>t</kbd>
    - Emacs          <kbd>MASH</kbd> + <kbd>e</kbd>
    - MacVim         <kbd>MASH</kbd> + <kbd>v</kbd>
    - Finder         <kbd>MASH</kbd> + <kbd>f</kbd>
    - Google Chrome  <kbd>MASH</kbd> + <kbd>c</kbd>

- Move/Size to quater screen

    - Top-left       <kbd>MASH</kbd> + <kbd>q</kbd>
    - Top-right      <kbd>MASH</kbd> + <kbd>w</kbd>
    - Bottom-left    <kbd>MASH</kbd> + <kbd>a</kbd>
    - Bottom-left    <kbd>MASH</kbd> + <kbd>s</kbd>

- Move/Size MASH + up, down, left, right move/size to half screen position

- Maximize           <kbd>MASH</kbd> + <kbd>SPACE</kbd>
- snap all to grid   <kbd>MASH</kbd> + <kbd>\</kbd>

- Grid 6h x 4w
- <kbd>Cmd</kbd>+<kbd>Alt</kbd> (modal) <kbd>1</kbd>, <kbd>2</kbd>, <kbd>3</kbd> - position, size, move (<kbd>Enter</kbd> to end mode)
=======
- Mash (cmd,ctrl,opt) hotkeys for position, size, app switching
- Apps iTerm2 (mash + t)
- Emacs (mash + e)
- MacVim (mash + v)
- Finder (mash + f)
- Google Chrome (mash + g)
- mash + q,w,a,s move to quater screen size/position
- mash + up, down, left, right move/size to half screen position
- mash + space maximize
- mash + \ snap all to grid
- grid is 6h x 4w
- Cmd+Alt (modal) 1,2,3 - position, size, move (Enter to end mode)
>>>>>>> Add tall / wide

[1]: http://www.hammerspoon.org/
[2]: https://github.com/mgee
[3]: https://github.com/mgee/dotfiles/tree/master/hammerspoon
[4]: http://moonscript.org
