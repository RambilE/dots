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

-- ty github.com/VanderCat
function string.split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

while true do
    bytes = assert(socket.recv(fd, 1337))
    -- print(bytes)
    for i in string.gmatch(bytes, "%S+") do
        if string.find(i, "^workspace>>%d$") then -- find ws that we are moving to
            ws,_ = (string.gsub(i,"workspace>>",""))
            -- print(ws)
        end
        if string.find(i, "^fullscreen>>%d$") then -- find fullscreen state
            fsState,_ = (string.gsub(i,"fullscreen>>",""))
            if ws and fsState ~= nil then
                wsCache[ws] = fsState
            end
        end
        if string.find(i, "movewindow>>%g") then -- get ws that we are moving window to
            mvwindowWs,_ = (string.gsub(i,"movewindow>>",""))
            mvwindowtWs = string.split(mvwindowWs,",")
            -- print(mvwindow[2])
            -- if fsState then
            --     wsCache[mvwindowWs] = 1
            --     wsCache[ws] = 0
            -- end
        end
    end
    -- print("1 2 3 4 5 6 7 8 9 10 ", "table len:" ..tablelength(wsCache))
    -- for i in pairs(wsCache) do
    --     io.write(wsCache[i].. " ")
    -- end
    -- print("\n")

    if wsCache[ws] == "0" or wsCache[ws] == nil then
        print(" ")
    else
        print(" ")
    end

end
unistd.close(fd)

