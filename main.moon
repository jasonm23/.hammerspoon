import HotkeyModal from require "hotkey_modal"
import Grid from require "grid"
Action = require "action"

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

grid1 = Grid 28, 26

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
resizeMode\bind {}, "T",      grid1\fullHeight
resizeMode\bind {}, "W",      grid1\fullWidth
resizeMode\bind {}, "B",      grid1\wideCentered
resizeMode\bind {}, "H",      grid1\halfWidth
resizeMode\bind {}, "C",      grid1\centered

resizeMode\bind {}, "M",      moveMode\enter
resizeMode\bind {}, "RETURN", resizeMode\exit

moveMode\bind {}, "UP",     grid1\moveUp
moveMode\bind {}, "DOWN",   grid1\moveDown
moveMode\bind {}, "LEFT",   grid1\moveLeft
moveMode\bind {}, "RIGHT",  grid1\moveRight
moveMode\bind {}, "C",      grid1\centered
moveMode\bind {}, "B",      grid1\wideCentered

moveMode\bind {}, "R",      resizeMode\enter
moveMode\bind {}, "RETURN", moveMode\exit

toolsMode = HotkeyModal "Tools", modalMods, "t"

toolsMode\bind {}, "B", toggleBlueTooth
toolsMode\bind {}, "W", toggleWifi
toolsMode\bind {}, "RETURN", toolsMode\exit

hs.window.animationDuration = 0
hs.pathwatcher.new(hs.configdir, (files) -> hs.reload!)\start!
hs.alert.show "By the Power of Hammerspoon!!!", 3
