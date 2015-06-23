require 'moonscript'

import HotkeyModal from require 'hotkey_modal'
import Grid from require 'grid'
Action = require 'action'

launchOrActivateApp = (appName) ->
  wasAlreadyRunning = hs.appfinder.appFromName(appName) != nil
  hs.application.launchOrFocus appName

grid1 = Grid 6, 4

mash = {'ctrl', 'alt', 'cmd'}

hs.hotkey.bind mash, '\\',    grid1\snapAll
hs.hotkey.bind mash, 'SPACE', Action.Maximize!\perform
hs.hotkey.bind mash, 'N',     Action.MoveToNextScreen!\perform
hs.hotkey.bind mash, 'P',     Action.MoveToPreviousScreen!\perform

hs.hotkey.bind mash, 'LEFT',  Action.MoveToUnit({x: 0.0, y: 0.0, w: 0.5, h: 1.0})\perform
hs.hotkey.bind mash, 'RIGHT', Action.MoveToUnit({x: 0.5, y: 0.0, w: 0.5, h: 1.0})\perform
hs.hotkey.bind mash, 'UP',    Action.MoveToUnit({x: 0.0, y: 0.0, w: 1.0, h: 0.5})\perform
hs.hotkey.bind mash, 'DOWN',  Action.MoveToUnit({x: 0.0, y: 0.5, w: 1.0, h: 0.5})\perform

hs.hotkey.bind mash, 'Q',     Action.MoveToUnit({x: 0.0, y: 0.0, w: 0.5, h: 0.5})\perform
hs.hotkey.bind mash, 'W',     Action.MoveToUnit({x: 0.5, y: 0.0, w: 0.5, h: 0.5})\perform
hs.hotkey.bind mash, 'A',     Action.MoveToUnit({x: 0.0, y: 0.5, w: 0.5, h: 0.5})\perform
hs.hotkey.bind mash, 'S',     Action.MoveToUnit({x: 0.5, y: 0.5, w: 0.5, h: 0.5})\perform

modalMods = {'cmd', 'alt'}

appShortcuts = {
  E: 'Emacs'
  V: 'MacVim'
  F: 'Finder'
  T: 'iTerm2'
  C: 'Google Chrome'
}

for shortcut, appName in pairs appShortcuts
  hs.hotkey.bind mash, shortcut, ->
                 hs.alert "Switching to #{appName}"
                 launchOrActivateApp appName

resize = HotkeyModal 'Resizing', modalMods, 'r'

resize\bind {}, 'UP',     grid1\resizeShorter
resize\bind {}, 'DOWN',   grid1\resizeTaller
resize\bind {}, 'LEFT',   grid1\resizeThinner
resize\bind {}, 'RIGHT',  grid1\resizeWider
resize\bind {}, 'K',      grid1\resizeShorter
resize\bind {}, 'J',      grid1\resizeTaller
resize\bind {}, 'H',      grid1\resizeThinner
resize\bind {}, 'L',      grid1\resizeWider
resize\bind {}, 'P',      grid1\resizeShorter
resize\bind {}, 'N',      grid1\resizeTaller
resize\bind {}, 'B',      grid1\resizeThinner
resize\bind {}, 'F',      grid1\resizeWider
resize\bind {}, 'RETURN', resize\exit

move = HotkeyModal 'Moving', modalMods, 'm'

move\bind {}, 'UP',     grid1\moveUp
move\bind {}, 'DOWN',   grid1\moveDown
move\bind {}, 'LEFT',   grid1\moveLeft
move\bind {}, 'RIGHT',  grid1\moveRight
move\bind {}, 'K',      grid1\moveUp
move\bind {}, 'J',      grid1\moveDown
move\bind {}, 'H',      grid1\moveLeft
move\bind {}, 'L',      grid1\moveRight
move\bind {}, 'P',      grid1\moveUp
move\bind {}, 'N',      grid1\moveDown
move\bind {}, 'B',      grid1\moveLeft
move\bind {}, 'F',      grid1\moveRight
move\bind {}, 'RETURN', move\exit

hs.window.animationDuration = 0
hs.pathwatcher.new(hs.configdir, (files) -> hs.reload!)\start!
hs.alert.show "Power of Hammerspoon Activated!", 3
