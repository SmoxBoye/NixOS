hl.on("hyprland.start", function()
  hl.exec_cmd("ashell")
  hl.exec_cmd("swaync")
  hl.exec_cmd("hyprpolkitagent")
  hl.exec_cmd("kitty", { workspace = "1 silent" })
  hl.exec_cmd("deltatune")
  hl.exec_cmd("xrandr --output HDMI-A-1 --primary")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("hyprsunset")
  hl.exec_cmd("udiskie")
end)

return true
