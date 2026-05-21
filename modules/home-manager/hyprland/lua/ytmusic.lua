local YTMusic = {}

-- Track the volume state in Lua memory
local current_vol = 0.1

-- Helper function to calculate a smart step size based on current volume
local function get_dynamic_step(vol)
  if vol <= 0.15 then
    return 0.01  -- Tiny 1% steps when very quiet (0% to 15% volume range)
  elseif vol <= 0.40 then
    return 0.02  -- Gentle 2% steps for medium-low listening (15% to 40% range)
  else
    return 0.04  -- Snappy 4% steps when listening at normal or loud levels (> 40%)
  end
end

function YTMusic.playpause()
  return hl.dsp.exec_cmd("playerctl -p YoutubeMusic play-pause")
end

function YTMusic.next()
  return hl.dsp.exec_cmd("playerctl -p next")
end

function YTMusic.previous()
  return hl.dsp.exec_cmd("playerctl -p previous")
end

function YTMusic.volumeup()
  return function()
    local step = get_dynamic_step(current_vol)
    current_vol = math.min(1.0, current_vol + step)
    
    hl.dispatch(hl.dsp.exec_cmd(string.format("playerctl -p YoutubeMusic volume %.2f", current_vol)))
  end
end

function YTMusic.volumedown()
  return function()
    local step = get_dynamic_step(current_vol)
    current_vol = math.max(0.0, current_vol - step)
    
    hl.dispatch(hl.dsp.exec_cmd(string.format("playerctl -p YoutubeMusic volume %.2f", current_vol)))
  end
end

return YTMusic
