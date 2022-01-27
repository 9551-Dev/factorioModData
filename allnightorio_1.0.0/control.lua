local updateSettings = function()
    for k,v in pairs(game.surfaces) do
        if settings.startup["darker-dark"].value then
            game.surfaces[k].min_brightness = 0.3
        else
            game.surfaces[k].min_brightness = 0
        end
    end
end
local setNight = function()
    local surfaces = game.surfaces
    updateSettings()
    for indice,surface in pairs(surfaces) do
        surface.daytime = surface.evening
        surface.freeze_daytime = true
        surface.brightness_visual_weights = {1/0.7,1/0.7,1/0.7}
    end
end
script.on_configuration_changed(updateSettings)
script.on_init(setNight)
script.on_event(defines.events.on_surface_created,setNight)
script.on_event(defines.events.on_player_created,function(player)
    setNight()
    local pIndex = player.player_index
    game.players[pIndex].insert{name="coal",count=30}
    game.players[pIndex].insert{name="wood",count=50}
end)

local waitingToSmolder = {}
local waitingToDie = {}
local toBeRemoved = {}

script.on_event(defines.events.on_built_entity,function(data)
    local entity = data.created_entity
    if entity.name == "burner-torch" then
        table.insert(waitingToSmolder,{entity=entity,start=data.tick,wait=2400})
    end
    if entity.name == "smoldering-torch" then
        table.insert(waitingToDie,{entity=entity,start=data.tick,wait=1200})
    end
end)

script.on_event(defines.events.on_tick,function(event)
    local curTick = event.tick
    for k,v in pairs(waitingToSmolder) do
        if curTick-v.start >= v.start+v.wait then
            if v.entity.valid then
                local surface = v.entity.surface
                local newEnt = surface.create_entity{name="smoldering-torch",position=v.entity.position}
                newEnt.force = "neutral"
                v.entity.destroy{false,true}
                table.insert(waitingToDie,{entity=newEnt,start=curTick,wait=v.wait/2})
            end
            table.remove(waitingToSmolder,k)
        end
    end
    for k,v in pairs(waitingToDie) do
        if curTick-v.start >= v.start+v.wait then
            if v.entity.valid then
                local surface = v.entity.surface
                local newEnt = surface.create_entity{name="dead-torch",position=v.entity.position}
                newEnt.force = "neutral"
                v.entity.destroy{false,true}
                table.insert(toBeRemoved,{entity=newEnt,start=curTick,wait=v.wait*5})
            end
            table.remove(waitingToDie,k)
        end
    end
    for k,v in pairs(toBeRemoved) do
        if curTick-v.start >= v.start+v.wait then
            if v.entity.valid then
                local surface = v.entity.surface
                v.entity.destroy{false,true}
            end
            table.remove(toBeRemoved,k)
        end
    end
end)