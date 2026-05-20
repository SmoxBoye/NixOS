local YTMusic = require("smoxboye.ytmusic")

local mainMod = "SUPER"

local function combo(mods, key)
  if mods == "" then
    return key
  end

  local parts = {}

  for part in mods:gmatch("%S+") do
    parts[#parts + 1] = part
  end

  parts[#parts + 1] = key

  return table.concat(parts, " + ")
end

local function bind_exec(mods, key, command, flags)
  hl.bind(combo(mods, key), hl.dsp.exec_cmd(command), flags)
end

local function bind_dispatch(mods, key, dispatcher, flags)
  hl.bind(combo(mods, key), dispatcher, flags)
end

-- Window management
bind_dispatch(mainMod, "Q", hl.dsp.window.close())
bind_exec(mainMod, "Return", "kitty")
bind_exec(mainMod, "Space", "rofi -show drun")
bind_exec(mainMod, "E", "dolphin")
bind_dispatch(mainMod, "F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
bind_dispatch(mainMod, "W", hl.dsp.window.float({ action = "toggle" }))
bind_exec(mainMod, "B", "firefox")
bind_exec(mainMod, "G", "myna")
bind_exec(mainMod, "P", "hyprctl dispatch dpms off && sleep 2 && hyprctl dispatch dpms on")

-- Screenshots
bind_exec("", "Print", "grimblast copy area")
bind_exec(mainMod .. " SHIFT", "S", "grimblast copy area")

-- Lock
bind_exec(mainMod, "L", "hyprlock")

-- Music
hl.bind("code:172", YTMusic.playpause());
hl.bind("code:173", YTMusic.previous());
hl.bind("code:171", YTMusic.next());
hl.bind(mainMod .. " + code:123", YTMusic.volumeup())
hl.bind(mainMod .. " + code:122", YTMusic.volumedown())

-- Audio
hl.bind("code:123", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"));
hl.bind("code:122", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"));

-- Focus movement
bind_dispatch(mainMod, "left", hl.dsp.focus({ direction = "l" }))
bind_dispatch(mainMod, "right", hl.dsp.focus({ direction = "r" }))
bind_dispatch(mainMod, "up", hl.dsp.focus({ direction = "u" }))
bind_dispatch(mainMod, "down", hl.dsp.focus({ direction = "d" }))

-- Mouse workspace switching
bind_dispatch(mainMod, "mouse:275", hl.dsp.focus({ workspace = "r-1" }))
bind_dispatch(mainMod, "mouse:276", hl.dsp.focus({ workspace = "r+1" }))

-- Workspace navigation
for ws = 1, 9 do
  local key = tostring(ws)
  local workspaceId = tostring(ws)

  bind_dispatch(mainMod, key, hl.dsp.focus({ workspace = workspaceId }))
  bind_dispatch(mainMod .. " SHIFT", key, hl.dsp.window.move({ workspace = workspaceId }))
end

-- Mouse bindings
bind_dispatch(mainMod, "mouse:272", hl.dsp.window.drag(), { mouse = true })
bind_dispatch(mainMod, "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Non-consuming global shortcut
hl.bind("SUPER + SUPER_L", hl.dsp.exec_cmd("quickshell:toggle-doors"), { non_consuming = true })

return true
