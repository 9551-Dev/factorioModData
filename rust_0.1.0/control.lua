local list = require("__rust__/proto_list")
local includeProtos = {}
for k,v in pairs(list) do
    if settings.startup["rust:do-"..v].value then
        includeProtos[k] = v
    end
end
local checkListProtos = {}
for k,v in pairs(includeProtos) do
    checkListProtos[v] = true
end
local findEntites = {}
local updateEntityList = function()
    if not global.rust then global.rust = {map={}} end
    local surfaces = game.surfaces
    for k,v in pairs(includeProtos) do
        for k,v1 in pairs(game.get_filtered_entity_prototypes{{filter="type",type=v}}) do
            table.insert(findEntites,v1)
        end 
    end
    local entityNames = {}
    for k,v in pairs(findEntites) do
        table.insert(entityNames,v.name)
    end
    for k,v in pairs(surfaces) do
        local entities = v.find_entities_filtered{name=entityNames}
        global.rust.map[v.index] = entities
    end
end
script.on_init(updateEntityList)
local function addEntity(event)
    local entity = event.created_entity or event.entity or event.destination
    if checkListProtos[entity.type] then
        if not global.rust.map[entity.surface.index] then global.rust.map[entity.surface.index] = {} end
        table.insert(global.rust.map[entity.surface.index],entity)
    end
end
script.on_event(defines.events.on_built_entity,addEntity)
script.on_event(defines.events.on_entity_cloned,addEntity)
script.on_event(defines.events.on_robot_built_entity,addEntity)
script.on_event(defines.events.script_raised_built,addEntity)
script.on_event(defines.events.script_raised_revive,addEntity)
script.on_nth_tick(settings.startup["rust:update-rate"].value,function(event)
    for surfaceName,surface in pairs(global.rust.map) do
        for k,v in pairs(surface) do
            if v.valid then
                local damagePMinMax = v.prototype.max_health/100
                local riseRate = settings.startup["rust:rise-rate"].value/10
                local pollution = game.surfaces[surfaceName].get_pollution(v.position)
                if pollution > settings.startup["rust:min-pollution-to-damage"].value then
                    local rate = math.min(math.abs(pollution^riseRate/100^(riseRate*2)),settings.startup["rust:max-damage-n-time"].value/10)
                    v.health = v.health - (damagePMinMax*rate*settings.startup["rust:damage-multiplier"].value)
                    game.surfaces[surfaceName].pollute(v.position,-(damagePMinMax*rate*settings.startup["rust:pollution-consumption-mod"].value))
                    if v.health <= 0 then v.die() end
                end
            else
                table.remove(global.rust.map[surfaceName][k])
            end
        end
    end
end)
