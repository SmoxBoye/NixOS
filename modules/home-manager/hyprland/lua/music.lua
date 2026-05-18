local TARGET_APP_CLASS = "com.github.th_ch.youtube_music" -- Used to find the app
local TARGET_APP_NAME = "pear-desktop" -- Used to launch the app
local SPECIAL_WORKSPACE = "special:Music"
local TOGGLE_HOTKEY     = "SUPER + M"

hl.config({
    windowrule = {
        { 
            match = { class = TARGET_APP_CLASS }, 
            workspace = SPECIAL_WORKSPACE 
        }
    }
})


local function resize_to_monitor_percent(width_percent, height_percent, target_win)
    return function()
        -- Get current monitor for the app
        local monitor = hl.get_monitor(target_win.monitor)
        if not monitor then return end

        local display_width = monitor.width
        local display_height = monitor.height

        -- Vertical monitor swaps width and height
        -- 1 = 90 deg, 3 = 270 deg, 5 = flipped 90, 7 = flipped 270
        if monitor.transform == 1 or monitor.transform == 3 or monitor.transform == 5 or monitor.transform == 7 then
            display_width, display_height = display_height, display_width
        end        

        -- Calculate percentage relative to monitor
        local target_width = math.floor(display_width * (width_percent / 100))
        local target_height = math.floor(display_height * (height_percent / 100))
         
        -- Resize
        hl.dispatch(hl.dsp.focus({ window = "address:" .. target_win.address })) -- Fix for quirky vertical monitor issues
        hl.dispatch(hl.dsp.window.resize({ 
            x = target_width, 
            y = target_height, 
            relative = false,
            window = "address:" .. target_win.address 
        }))
    end
end

-- Keybind
hl.bind(TOGGLE_HOTKEY, function()
    local target_win = nil

    
    -- Find music app
    for _, win in ipairs(hl.get_windows()) do
        if win.class == TARGET_APP_CLASS then
            target_win = win
            break
        end
    end

    -- Launch app if not already running
    if not target_win then
        hl.dispatch(hl.dsp.exec_cmd(TARGET_APP_NAME))
        return
    end

    -- Get the apps workspace
    local active_ws = hl.get_active_workspace()

    -- Is the app with us in this workspace?
    if target_win.workspace.id == active_ws.id or target_win.workspace.name == active_ws.name then
        -- Send it back to special Music workspace
        hl.dispatch(hl.dsp.window.move({ 
            workspace = SPECIAL_WORKSPACE, 
            window = "address:" .. target_win.address,
            follow = false 
        }))
    else
        -- Commandgrab app and put it in our current workspace
        hl.dispatch(
            hl.dsp.window.move({ 
                workspace = active_ws.name, 
                window = "address:" .. target_win.address 
            })
        )
        hl.dispatch(
            hl.dsp.window.float({ 
                action = "enable", 
                window = "address:" .. target_win.address 
            })
        )
        hl.dispatch(
            hl.dsp.window.center({ 
                window = "address:" .. target_win.address 
            })
        )
        hl.dispatch(resize_to_monitor_percent(80, 70, target_win))
        
    end
end, { description = "Toggle Music App Scratchpad" })
