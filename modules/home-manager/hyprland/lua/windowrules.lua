local function window_rule(rule)
  hl.window_rule(rule)
end

window_rule({ match = { class = "rofi" }, float = true })
window_rule({ match = { class = "swaync" }, float = true })
window_rule({ match = { class = "xdg-desktop-portal-gtk" }, float = true })
window_rule({ match = { class = "solaar" }, float = true })

return true
