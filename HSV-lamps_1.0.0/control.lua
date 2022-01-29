local api = require("__HSV-lamps__/api.lua")
local signals = require("__HSV-lamps__/signalID")

local function createGlobal()
    if not global.lampsList then
        global.lampsList = api.array_manipulation.create2Darray()
    end
end

script.on_init(createGlobal)
script.on_configuration_changed(createGlobal)

script.on_load(function()
    global.lampsList = api.array_manipulation.create2Darray(global.lampsList)
end)

local lightData = {
    sprite = "utility/light_medium",
    scale = 2,
    intensity = 1,
    visible = false,
    color = {r=0,g=0,b=0,a=255}
}

local spriteData = {
    sprite="hsv-lamp-on-sprite",
    tint={r=255,g=255,b=255},
    visible=false
}

local flatSpriteData = {
    sprite="hsv-flat-lamp-sprite",
    tint={r=255,g=255,b=255},
    visible=false
}

local createNewLamp = function(event)
    local entity = event.created_entity or event.entity or event.destination
    if entity.name == "small-hsv-lamp" then
        local position = entity.position
        lightData.target = position
        spriteData.target = position
        lightData.surface = entity.surface
        spriteData.surface = entity.surface
        spriteData.target.y = entity.position.y + -0.25
        local light = rendering.draw_light(lightData)
        local sprite = rendering.draw_sprite(spriteData)
        global.lampsList[position.x][position.y] = {entity=entity,light=light,enabledTex=sprite}
    elseif entity.name == "small-flat-hsv-lamp" then
        local position = entity.position
        lightData.target = position
        flatSpriteData.target = position
        lightData.surface = entity.surface
        flatSpriteData.surface = entity.surface
        flatSpriteData.target.y = entity.position.y
        local light = rendering.draw_light(lightData)
        local sprite = rendering.draw_sprite(flatSpriteData)
        global.lampsList[position.x][position.y] = {entity=entity,light=light,enabledTex=sprite}
    end
end
local removeLamp = function(event)
    local entity = event.entity
    if entity.name == "small-hsv-lamp" or entity.name == "small-flat-hsv-lamp" then
        local position = entity.position
        local tblToDestroy = global.lampsList[position.x][position.y]
        if entity.name == "small-hsv-lamp" then
            tblToDestroy = global.lampsList[position.x][position.y-0.25]
        end
        if tblToDestroy then
            rendering.destroy(tblToDestroy.light)
            rendering.destroy(tblToDestroy.enabledTex)
        end
        global.lampsList[position.x][position.y] = nil
        if api.array_manipulation.get_true_length(global.lampsList[position.x]) == 0 then
            global.lampsList[position.x]=nil
        end
    end
end

script.on_event(defines.events.on_built_entity, createNewLamp)
script.on_event(defines.events.on_entity_cloned, createNewLamp)
script.on_event(defines.events.on_robot_built_entity, createNewLamp)
script.on_event(defines.events.script_raised_built, createNewLamp)
script.on_event(defines.events.script_raised_revive, createNewLamp)

script.on_event(defines.events.on_player_mined_entity,removeLamp)
script.on_event(defines.events.on_entity_died,removeLamp)
script.on_event(defines.events.on_robot_mined_entity,removeLamp)
script.on_event(defines.events.script_raised_destroy,removeLamp)

script.on_nth_tick(settings.global["HSVL:update-rate"].value,function(event)
    local tick = event.tick
    local next_key = global.next_key
    local next_value
    for i = 1,settings.global["HSVL:lamp-updates-per-update"].value do
        next_key, next_value = next(global.lampsList, next_key)
        if next_key then
            local x = next_key
            for y,block_data in pairs(next_value) do
                if block_data.entity.valid then
                    local lampstate = block_data.entity.status == 1
                    local H = math.min(block_data.entity.get_merged_signal(signals.H),255)+1
                    local S = math.min(block_data.entity.get_merged_signal(signals.S)/255,255)
                    local V = math.min(block_data.entity.get_merged_signal(signals.V)/255,255)
                    local r,g,b = api.HSVToRGB(H,S,V)
                    rendering.set_visible(block_data.light,lampstate)
                    rendering.set_visible(block_data.enabledTex,lampstate)
                    rendering.set_color(block_data.enabledTex,{
                        r=math.max(0,math.min(r,255)),
                        g=math.max(0,math.min(g,255)),
                        b=math.max(0,math.min(b,255))
                    })
                    rendering.set_color(block_data.light,{
                        r=math.max(0,math.min(r,255)),
                        g=math.max(0,math.min(g,255)),
                        b=math.max(0,math.min(b,255)),
                        a=0
                    })
                end
            end
        else
            break
        end
    end
    global.next_key = next_key
end)