local YTMusic = {}

-- Standard playback handlers
function YTMusic.playpause()
  return hl.dsp.exec_cmd("playerctl -p YoutubeMusic play-pause")
end

function YTMusic.next()
  return hl.dsp.exec_cmd("playerctl -p next")
end

function YTMusic.previous()
  return hl.dsp.exec_cmd("playerctl -p next")
end

-- Cumulative volume adjustment handlers
function YTMusic.volumeup()
  return function()
    local handle = io.popen("playerctl -p YoutubeMusic volume")
    local current = tonumber(handle:read("*a"))
    handle:close()
    if current then
      local new_vol = math.min(1.0, current + 0.02)
      os.execute(string.format("playerctl -p YoutubeMusic volume %f", new_vol))
    end
  end
end

function YTMusic.volumedown()
  return function()
    local handle = io.popen("playerctl -p YoutubeMusic volume")
    local current = tonumber(handle:read("*a"))
    handle:close()
    if current then
      local new_vol = math.max(0.0, current - 0.02)
      os.execute(string.format("playerctl -p YoutubeMusic volume %f", new_vol))
    end
  end
end

return YTMusic
