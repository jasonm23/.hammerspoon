package.path = hs.configdir .. "/usr/local/share/lua/5.2/?.lua;" ..
               hs.configdir .. "/usr/local/share/lua/5.2/?/init.lua;" ..
               package.path
package.cpath = hs.configdir .. "/usr/local/lib/lua/5.2/?.so;" .. package.cpath

_ = require 'moses'
require 'moonscript'
require 'main'
