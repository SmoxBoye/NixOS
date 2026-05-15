hl.config({
  general = {
    gaps_in = 3,
    gaps_out = 5,
    border_size = 1,
    col = {
      active_border = { colors = {"rgba(294559cc)", "rgba(295935cc)", angle = 45}},
      inactive_border = "rgba(595959aa)",
    },
    layout = "dwindle",
    allow_tearing = true,
    resize_on_border = true,
  },
  decoration = {
    blur = {
      enabled = true,
      size = 5,
      passes = 2,
      new_optimizations = true,
      ignore_opacity = true,
      xray = true,
    },
    shadow = {
      enabled = false,
    },
  },
  animations = {
    enabled = true,
  },
  input = {
    kb_layout = "se",
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = {
      natural_scroll = true,
    },
  },
  dwindle = {
    preserve_split = true,
  },
  misc = {
    vrr = 1,
    middle_click_paste = false,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    mouse_move_enables_dpms = true,
    key_press_enables_dpms = true,
  },
})

hl.curve("snappy", {
  type = "bezier",
  points = { { 0.4, 0 }, { 0.2, 1 } },
})

hl.animation({ leaf = "windows", enabled = true, speed = 1, bezier = "snappy", style = "popin" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "snappy", style = "slidefade" })

hl.monitor({
  output = "DP-3",
  mode = "2560x1440@120",
  position = "auto-left",
  scale = "1.0",
  vrr = 1,
})
hl.monitor({
  output = "HDMI-A-1",
  mode = "3840x2160@120",
  position = "0x0",
  scale = "1.0",
  vrr = 1,
})
hl.monitor({
  output = "DP-2",
  mode = "1920x1200@60",
  position = "auto-center-right",
  scale = "1.0",
  transform = 1,
})
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = "1",
})


return true
