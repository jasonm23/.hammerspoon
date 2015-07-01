require 'moonscript'

import HotkeyModal from require "hotkey_modal"
import Grid from require "grid"
Action = require "action"

makeSplash = () ->
  s = hs.screen.mainScreen!
  frame = s\frame!
  w = 800
  h = 340
  x = (frame.w/2) - (w/2)
  y = (frame.h/2) - (h/2)
  splash = hs.drawing.image({w:w, h:h, x: x, y: y}, "hammerclip.gif")
  splash

launchOrActivateApp = (appName) ->
  wasAlreadyRunning = hs.appfinder.appFromName appName != nil
  hs.application.launchOrFocus appName

launchOrActivateAppWithAlert = (appName) ->
  hs.alert "Switching to #{appName}"
  launchOrActivateApp appName

activateNewChrome = ->
  lastApp = _.last(hs.application.runningApplications(),1)[1]
  lastApp\activate() if lastApp != nil and lastApp\title() == "Google Chrome"

toggleBlueTooth = ->
  hs.alert "Toggle Bluetooth - not yet ..."

toggleWifi = ->
  if hs.wifi.currentNetwork() == nil then
    hs.alert "Toggle WiFi on"
    os.execute "networksetup -setairportpower en0 on"
  else
    hs.alert "Toggle WiFi off"
    os.execute "networksetup -setairportpower en0 off"

grid1 = Grid 8, 6

mash = {"ctrl", "alt", "cmd"}

hs.hotkey.bind mash, "=",     activateNewChrome
hs.hotkey.bind mash, "\\",    grid1\snapAll
hs.hotkey.bind mash, "SPACE", Action.Maximize!\perform
hs.hotkey.bind mash, "N",     Action.MoveToNextScreen!\perform
hs.hotkey.bind mash, "P",     Action.MoveToPreviousScreen!\perform

hs.hotkey.bind mash, "LEFT",  Action.MoveToUnit({x: 0.0, y: 0.0, w: 0.5, h: 1.0})\perform
hs.hotkey.bind mash, "RIGHT", Action.MoveToUnit({x: 0.5, y: 0.0, w: 0.5, h: 1.0})\perform
hs.hotkey.bind mash, "UP",    Action.MoveToUnit({x: 0.0, y: 0.0, w: 1.0, h: 0.5})\perform
hs.hotkey.bind mash, "DOWN",  Action.MoveToUnit({x: 0.0, y: 0.5, w: 1.0, h: 0.5})\perform

hs.hotkey.bind mash, "Q",     Action.MoveToUnit({x: 0.0, y: 0.0, w: 0.5, h: 0.5})\perform
hs.hotkey.bind mash, "W",     Action.MoveToUnit({x: 0.5, y: 0.0, w: 0.5, h: 0.5})\perform
hs.hotkey.bind mash, "A",     Action.MoveToUnit({x: 0.0, y: 0.5, w: 0.5, h: 0.5})\perform
hs.hotkey.bind mash, "S",     Action.MoveToUnit({x: 0.5, y: 0.5, w: 0.5, h: 0.5})\perform

modalMods = {"cmd", "alt"}

appsMode = HotkeyModal "Apps", modalMods, "a"

appShortcuts = {
  E: "Emacs"
  V: "MacVim"
  F: "Finder"
  T: "iTerm2"
  C: "Google Chrome"
}

for shortcut, appName in pairs appShortcuts
  hs.hotkey.bind mash, shortcut, ->
    launchOrActivateAppWithAlert(appName)

  appsMode\bind {}, shortcut, ->
    launchOrActivateAppWithAlert(appName)
    appsMode\exit!

appsMode\bind {}, "RETURN", appsMode\exit

resizeMode = HotkeyModal "Resizing", modalMods, "r"
moveMode = HotkeyModal "Moving", modalMods, "m"

resizeMode\bind {}, "UP",     grid1\resizeShorter
resizeMode\bind {}, "DOWN",   grid1\resizeTaller
resizeMode\bind {}, "LEFT",   grid1\resizeThinner
resizeMode\bind {}, "RIGHT",  grid1\resizeWider
resizeMode\bind {}, "K",      grid1\resizeShorter
resizeMode\bind {}, "J",      grid1\resizeTaller
resizeMode\bind {}, "H",      grid1\resizeThinner
resizeMode\bind {}, "L",      grid1\resizeWider
resizeMode\bind {}, "P",      grid1\resizeShorter
resizeMode\bind {}, "N",      grid1\resizeTaller
resizeMode\bind {}, "B",      grid1\resizeThinner
resizeMode\bind {}, "F",      grid1\resizeWider
resizeMode\bind {}, "M",      moveMode\enter
resizeMode\bind {}, "RETURN", resizeMode\exit

moveMode\bind {}, "UP",     grid1\moveUp
moveMode\bind {}, "DOWN",   grid1\moveDown
moveMode\bind {}, "LEFT",   grid1\moveLeft
moveMode\bind {}, "RIGHT",  grid1\moveRight
moveMode\bind {}, "K",      grid1\moveUp
moveMode\bind {}, "J",      grid1\moveDown
moveMode\bind {}, "H",      grid1\moveLeft
moveMode\bind {}, "L",      grid1\moveRight
moveMode\bind {}, "P",      grid1\moveUp
moveMode\bind {}, "N",      grid1\moveDown
moveMode\bind {}, "B",      grid1\moveLeft
moveMode\bind {}, "F",      grid1\moveRight
moveMode\bind {}, "R",      resizeMode\enter
moveMode\bind {}, "RETURN", moveMode\exit

toolsMode = HotkeyModal "Tools", modalMods, "t"

toolsMode\bind {}, "B", toggleBlueTooth
toolsMode\bind {}, "W", toggleWifi
toolsMode\bind {}, "RETURN", toolsMode\exit

hs.window.animationDuration = 0
hs.pathwatcher.new(hs.configdir, (files) -> hs.reload!)\start!
splash = makeSplash!
splash\show!
hs.alert.show "By the Power of Hammerspoon!!!", 3
hs.timer.doAfter 4, splash\delete
