require 'moonscript'

import insert from table

modals = {}

class HotkeyModal
  new: (title, mods, key) =>
    insert modals, @
    @key = hs.hotkey.bind mods, key, -> @enter self
    @keys = {}
    @title = title
    @active = false

  banner: (message)=>
     black = {red: 0, green: 0, blue: 0, alpha: 1}
     white = {red: 1, green: 1, blue: 1, alpha: 0.3}

     screen = hs.screen.mainScreen!
     screenFrame = screen\frame!

     h = 40
     ts = 25
     w = screenFrame['w']

     -- mid = (screenFrame['h'] - h) / 2
     -- frameMid = {h: h, w: w, x: 0, y: mid}
     -- textFrameMid = {h: h, w: w, x: w / 2 - 200, y: mid + (h - ts) / 2 - 3}
     frameTop = {h: h, w: w, x: 0, y: 0}
     textFrameTop = {h: h, w: w, x: w / 2 - 200, y: 26}

     rect = hs.drawing.rectangle frameTop
     rect\setFillColor white
     rect\setStroke false
     rect\show!

     text = hs.drawing.text textFrameTop, message
     text\setTextFont "Helvetica Neue"
     text\setTextColor black
     text\setTextSize ts
     text\show!
     {text,rect}

  bind: (mods, key, pressedfn, releasedfn) =>
    insert @keys, hs.hotkey.new mods, key, pressedfn, releasedfn

  disableOtherModals: (using modals) =>
    for m in *modals do if m != @ and m\isActive! then m\exitSilent!

  enter: (using modals) =>
    @disableOtherModals!
    @active = true
    @bannerText = @banner "#{@title} - Press Enter to exit"
    @key\disable!
    for key in *@keys do hs.hotkey.enable key

  exitSilent: =>
    @active = false
    for layer in *@bannerText do layer\delete!
    for key in *@keys do hs.hotkey.disable key
    @key\enable!

  exit: =>
    @exitSilent!

  isActive: => @active
{
  :HotkeyModal
}
