-- 1. Configuration Constants
-- Swap "Spotify" with your exact app class (e.g., "Cider", "kitty", "firefox")
local TARGET_APP_CLASS = "Pear Desktop"  
local SPECIAL_WORKSPACE = "special:music"
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

-- 3. The Dynamic Toggle Logic
hl.bind(TOGGLE_HOTKEY, function()
    local target_win = nil
    
    -- Scan all open windows to locate your app
    for _, win in ipairs(hl.get_windows()) do
        if win.class == TARGET_APP_CLASS then
            target_win = win
            break
        end
    end

    -- Edge case: If the app isn't running yet, launch it.
    if not target_win then
        hl.dispatch(hl.dsp.exec_cmd(TARGET_APP_CLASS))
        return
    end

    -- Grab the workspace you are currently focused on
    local active_ws = hl.get_active_workspace()

    -- Check if the app is currently on your active workspace
    if target_win.workspace.id == active_ws.id or target_win.workspace.name == active_ws.name then
        -- State A: It is hovering on your current screen. Send it back to the special workspace.
        hl.dispatch(hl.dsp.window.move({ 
            workspace = SPECIAL_WORKSPACE, 
            window = "address:" .. target_win.address 
        }))
    else
        -- State B: It's tucked away. Pull it to your current screen, force it to float, and center it.
        hl.dispatch(
            hl.dsp.window.move({ 
                workspace = active_ws.name, 
                window = "address:" .. target_win.address 
            }),
            hl.dsp.window.float({ 
                action = "set", 
                window = "address:" .. target_win.address 
            }),
            hl.dsp.window.center({ 
                window = "address:" .. target_win.address 
            })
        )
    end
end, { description = "Toggle Music App Scratchpad" })
