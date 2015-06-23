# Hammerspoon config

This is a [Hammerspoon Config][1], originally based on [@mgee's][2] [(mgee/dotfiles/hammerspoon)][3].

It's written in [Moonscript][4], enjoy.

# Changelog

### Updated Modal System 2015-06-24

- Modal resizing and moving
    - vim / emacs / arrow direction key support
    - show a banner while modes are active
    - don't use alerts

### Added README 2015-06-23

- You're looking at it.

### Initial commit 2015-06-23

- Modal move/resize/position modes
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

[1]: http://www.hammerspoon.org/
[2]: https://github.com/mgee
[3]: https://github.com/mgee/dotfiles/tree/master/hammerspoon
[4]: http://moonscript.org
