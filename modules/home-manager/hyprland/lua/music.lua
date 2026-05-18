-- 1. Configuration Constants
-- Swap "Spotify" with your exact app class (e.g., "Cider", "kitty", "firefox")
local TARGET_APP_CLASS = "com.github.th_ch.youtube_music"
local TARGET_APP_NAME = "pear-desktop"
local SPECIAL_WORKSPACE = "special:Music"
local TOGGLE_HOTKEY     = "SUPER + M"

-- 2. Define Initial Window Rules
-- This ensures the app opens directly into your designated special workspace by default.
hl.config({
    windowrule = {
        { 
            match = { class = TARGET_APP_CLASS }, 
            workspace = SPECIAL_WORKSPACE 
        }
    }
})

local function notify(ntext) 
    hl.notification.create({text = ntext, duration = 3000})
    
end 

local function resize_to_monitor_percent(width_percent, height_percent, target_win)
    return function()
        -- Fetch current active monitor data
        local monitor = hl.get_monitor(target_win.monitor)
        if not monitor then return end

        local display_width = monitor.width
        local display_height = monitor.height

        -- 1 = 90 deg, 3 = 270 deg, 5 = flipped 90, 7 = flipped 270
        if monitor.transform == 1 or monitor.transform == 3 or monitor.transform == 5 or monitor.transform == 7 then
            -- Swap values because the monitor is currently in a vertical/portrait mode
            display_width, display_height = display_height, display_width
        end        

        -- Calculate exact pixel values relative to this specific monitor
        local target_width = math.floor(display_width * (width_percent / 100))
        local target_height = math.floor(display_height * (height_percent / 100))
         
        -- Apply the exact pixel resizing absolute adjustment
        hl.dispatch(hl.dsp.focus({ window = "address:" .. target_win.address }))
        hl.dispatch(hl.dsp.window.resize({ 
            x = target_width, 
            y = target_height, 
            relative = false,
            window = "address:" .. target_win.address 
        }))
    end
end

-- 3. The Dynamic Toggle Logic
hl.bind(TOGGLE_HOTKEY, function()
    local target_win = nil
    notify("Running command")

    
    -- Scan all open windows to locate your app
    for _, win in ipairs(hl.get_windows()) do
        if win.class == TARGET_APP_CLASS then
            target_win = win
            notify("Found Window")
            break
        end
    end

    -- Edge case: If the app isn't running yet, launch it.
    if not target_win then
        hl.dispatch(hl.dsp.exec_cmd(TARGET_APP_NAME))
        notify("Creating Window")
        return
    end

    -- Grab the workspace you are currently focused on
    local active_ws = hl.get_active_workspace()

    -- Check if the app is currently on your active workspace
    if target_win.workspace.id == active_ws.id or target_win.workspace.name == active_ws.name then
        -- State A: It is hovering on your current screen. Send it back to the special workspace.
        hl.dispatch(hl.dsp.window.move({ 
            workspace = SPECIAL_WORKSPACE, 
            window = "address:" .. target_win.address,
            follow = false 
        }))
        notify("State A")
    else
        -- State B: It's tucked away. Pull it to your current screen, force it to float, and center it.
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
        hl.dispatch(resize_to_monitor_percent(80, 70, target_win))
        hl.dispatch(
            hl.dsp.window.center({ 
                window = "address:" .. target_win.address 
            })
        )
        notify("State B")
    end
end, { description = "Toggle Music App Scratchpad" })
