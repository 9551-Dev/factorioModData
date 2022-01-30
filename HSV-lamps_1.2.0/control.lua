local api = require("__HSV-lamps__/api.lua")
local signals = require("__HSV-lamps__/signalID")

local function createGlobal()
    if not global.lamp_list then
        global.lamp_list = api.array_manipulation.create3Darray()
    end
end

local createLampList = false

script.on_init(createGlobal)
script.on_configuration_changed(createGlobal)

script.on_load(function()
    if global.lamp_list then
        global.lamp_list = api.array_manipulation.create3Darray(global.lamp_list)
    else
        createLampList = true
    end
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
    if createLampList then
        global.lamp_list = api.array_manipulation.create3Darray()
    end
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
        global.lamp_list[position.x][position.y][entity.surface.index] = {
            entity=entity,
            light=light,
            enabledTex=sprite,
            surface=entity.surface
        }
    elseif entity.name == "small-flat-hsv-lamp" then
        local position = entity.position
        lightData.target = position
        flatSpriteData.target = position
        lightData.surface = entity.surface
        flatSpriteData.surface = entity.surface
        flatSpriteData.target.y = entity.position.y
        local light = rendering.draw_light(lightData)
        local sprite = rendering.draw_sprite(flatSpriteData)
        global.lamp_list[position.x][position.y][entity.surface.index] = {
            entity=entity,
            light=light,
            enabledTex=sprite,
            surface=entity.surface
        }
    end
end

local function removeGraphics(x,y,surface)
    local tblToDestroy = global.lamp_list[x][y][surface.index]
    local entity = global.lamp_list[x][y][surface.index].entity
    if tblToDestroy then
        rendering.destroy(tblToDestroy.light)
        rendering.destroy(tblToDestroy.enabledTex)
    end
end

local removeLamp = function(event)
    local entity = event.entity
    local smallen = 0
    if entity.name == "small-hsv-lamp" or entity.name == "small-flat-hsv-lamp" then
        local position = entity.position
        local tblToDestroy = global.lamp_list[position.x][position.y][entity.surface.index]
        if entity.name == "small-hsv-lamp" then
            tblToDestroy = global.lamp_list[position.x][position.y][entity.surface.index]
            smallen = -0.25 
        end
        if tblToDestroy then
            rendering.destroy(tblToDestroy.light)
            rendering.destroy(tblToDestroy.enabledTex)
        end
        global.lamp_list[position.x][position.y+smallen][entity.surface.index] = nil
        if api.array_manipulation.get_true_length(global.lamp_list[position.x][position.y]) == 0 then
            if entity.name == "small-hsv-lamp" then
                global.lamp_list[position.x][position.y] = nil
            else
                global.lamp_list[position.x][position.y] = nil
            end
        end
        if api.array_manipulation.get_true_length(global.lamp_list[position.x]) == 0 then
            global.lamp_list[position.x]=nil
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
        next_key, next_value = next(global.lamp_list, next_key)
        if next_key then
            local x = next_key
            for y,surface in pairs(next_value) do
                for k,block_data in pairs(surface) do
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
                    else
                        removeGraphics(x,y,block_data.surface)
                    end
                end
            end
        else
            break
        end
    end
    global.next_key = next_key
end)


script.on_nth_tick(60,function()
    game.print(serpent.block(global.lamp_list))
    local next_key = global.next_key2
    local next_value
    for i = 1,settings.global["HSVL:lamp-updates-per-update"].value do
        next_key, next_value = next(global.lamp_list, next_key)
        if next_key then
            local x = next_key
            if not next(next_value) then global.lamp_list[next_key] = nil end
            for y,surface in pairs(next_value) do
                if not next(surface) then global.lamp_list[next_key][y] = nil end
                for k,block_data in pairs(surface) do
                    if not next(block_data) then global.lamp_list[next_key][y][k] = nil end
                    if not block_data.entity.valid then
                        removeGraphics(x,y,block_data.surface)
                    end
                end
            end
        else
            break
        end
    end
    global.next_key2 = next_key
end)
