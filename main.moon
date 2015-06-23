require 'moonscript'

import HotkeyModal from require 'hotkey_modal'
import Grid from require 'grid'
Action = require 'action'

launchOrActivateApp = (appName) ->
  wasAlreadyRunning = hs.appfinder.appFromName(appName) != nil
  hs.application.launchOrFocus(appName)

grid1 = Grid(6, 4)

mash = {'CTRL', 'ALT', 'CMD'}

hs.hotkey.bind(mash, 'SPACE', Action.Maximize!\perform)
hs.hotkey.bind(mash, '\\',    grid1\snapAll)
hs.hotkey.bind(mash, 'N',     Action.MoveToNextScreen!\perform)
hs.hotkey.bind(mash, 'P',     Action.MoveToPreviousScreen!\perform)

hs.hotkey.bind(mash, 'LEFT',  Action.MoveToUnit({x: 0.0, y: 0.0, w: 0.5, h: 1.0})\perform)
hs.hotkey.bind(mash, 'RIGHT', Action.MoveToUnit({x: 0.5, y: 0.0, w: 0.5, h: 1.0})\perform)
hs.hotkey.bind(mash, 'UP',    Action.MoveToUnit({x: 0.0, y: 0.0, w: 1.0, h: 0.5})\perform)
hs.hotkey.bind(mash, 'DOWN',  Action.MoveToUnit({x: 0.0, y: 0.5, w: 1.0, h: 0.5})\perform)

hs.hotkey.bind(mash, 'Q',     Action.MoveToUnit({x: 0.0, y: 0.0, w: 0.5, h: 0.5})\perform)
hs.hotkey.bind(mash, 'W',     Action.MoveToUnit({x: 0.5, y: 0.0, w: 0.5, h: 0.5})\perform)
hs.hotkey.bind(mash, 'A',     Action.MoveToUnit({x: 0.0, y: 0.5, w: 0.5, h: 0.5})\perform)
hs.hotkey.bind(mash, 'S',     Action.MoveToUnit({x: 0.5, y: 0.5, w: 0.5, h: 0.5})\perform)

modalMods = {'CMD', 'ALT'} -- Enter to exit from a modal key map

appShortcuts = {
  'E': 'Emacs'
  'V': 'MacVim'
  'F': 'Finder'
  'T': 'iTerm2'
  'C': 'Google Chrome'
}

for shortcut, appName in pairs(appShortcuts)
  hs.hotkey.bind(mash, shortcut, ->
                                  hs.alert("Switching to #{appName}")
                                  launchOrActivateApp(appName)
                )

position = HotkeyModal('Position', modalMods, '1')

position\bind({}, 'UP',     grid1\positionTopRight)
position\bind({}, 'DOWN',   grid1\positionBottomLeft)
position\bind({}, 'LEFT',   grid1\positionTopLeft)
position\bind({}, 'RIGHT',  grid1\positionBottomRight)
position\bind({}, 'RETURN', position\exit)

resize = HotkeyModal('Resize', modalMods, '2')

resize\bind({}, 'UP',     grid1\resizeShorter)
resize\bind({}, 'DOWN',   grid1\resizeTaller)
resize\bind({}, 'LEFT',   grid1\resizeThinner)
resize\bind({}, 'RIGHT',  grid1\resizeWider)
resize\bind({}, 'RETURN', resize\exit)

move = HotkeyModal('Move', modalMods, '3')

move\bind({}, 'UP',     grid1\moveUp)
move\bind({}, 'DOWN',   grid1\moveDown)
move\bind({}, 'LEFT',   grid1\moveLeft)
move\bind({}, 'RIGHT',  grid1\moveRight)
move\bind({}, 'K',     grid1\moveUp)
move\bind({}, 'J',   grid1\moveDown)
move\bind({}, 'H',   grid1\moveLeft)
move\bind({}, 'L',  grid1\moveRight)
move\bind({}, 'RETURN', move\exit)

hs.window.animationDuration = 0
hs.pathwatcher.new(hs.configdir, (files) -> hs.reload!)\start!
hs.alert.show("Hammerspoon loaded", 1)
