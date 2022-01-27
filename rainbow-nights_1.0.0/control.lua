local HSVtoRGB = require("__rainbow-nights__/api").HSV

local smoothness = settings.startup["smoothness"].value
local n = math.floor(255 - (settings.startup["visibility"].value*2.55))/255
script.on_nth_tick(settings.startup["updaterate"].value,function(event)
    local tick = ((event.tick/settings.startup["timedivider"].value) % (255*smoothness))/smoothness
    local r,g,b = HSVtoRGB(tick,settings.startup["SAT"].value,settings.startup["VALUE"].value)
    r,g,b = math.max(0,r-n),math.max(0,g-n),math.max(0,b-n)
    for k,v in pairs(game.surfaces) do
        game.surfaces[k].brightness_visual_weights = {r=r,g=g,b=b}
    end
end)