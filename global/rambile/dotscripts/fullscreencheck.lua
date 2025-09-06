#! /usr/bin/env lua
-- 1. open socket
-- 2. read socket for fullscreen
-- 3. send smth to waybar

local socket =  require("posix.sys.socket")
local unistd =  require("posix.unistd")
local fd =      assert(socket.socket(socket.AF_UNIX, socket.SOCK_STREAM, 0))

local XDRD =  os.getenv("XDG_RUNTIME_DIR")
local HIS =   os.getenv("HYPRLAND_INSTANCE_SIGNATURE")

assert(socket.connect(fd, {family = socket.AF_UNIX, path = ""..XDRD.."/hypr/"..HIS.."/.socket2.sock"}))

local wsCache = {0,0,0,0,0,0,0,0,0,0}
--local ws = 1
--local fsState = 0
while true do
    bytes = assert(socket.recv(fd, 1337))
    --  print(bytes)
    for i in string.gmatch(bytes, "%S+") do
        if string.find(i, "^workspace>>%d$") then -- find workspace that we are switching to
            ws,_ = (string.gsub(i,"workspace>>",""))
        end
        if string.find(i, "^fullscreen>>%d$") then -- find fullscreen state
            fsState,_ = (string.gsub(i,"fullscreen>>",""))
            if ws and fsState then
                wsCache[ws] = fsState
            end
        end
        if string.find(i, "^movewindow>>*,%d$") then
            nextWs,_ = (string.gsub(i,"movewindow>>",""))
            print(nextWs)
        end
    end
    -- print(ws, fsState, wsCache[ws])
    --print(type(ws))

    if wsCache[ws] == "0" or wsCache[ws] == nil then
        print(" ")
    else
        print(" ")
    end

end
unistd.close(fd)

