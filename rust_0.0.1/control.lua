local includeProtos = {
    "assembling-machine",
    "ammo-turret",
}
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
script.on_event(defines.events.on_built_entity,function(event)
    updateEntityList()
    local entity = event.created_entity
    if includeProtos[entity.prototype] then
        if not global.rust.map[entity.surface.index] then global.rust.map[entity.surface.index] = {} end
        table.insert(global.rust.map[entity.surface.index],entity)
    end
end)
script.on_nth_tick(1800,function(event)
    for surfaceName,surface in pairs(global.rust.map) do
        for k,v in pairs(surface) do
            if v.valid then
                local damagePMinMax = v.prototype.max_health/100
                local riseRate = 1.4
                local pollution = game.surfaces[surfaceName].get_pollution(v.position)
                if pollution > 500 then
                    local rate = math.min(math.abs(pollution^riseRate/100^riseRate*2),1)
                    v.health = v.health - damagePMinMax*rate
                    game.surfaces[surfaceName].pollute(v.position,-(damagePMinMax*rate))
                    if v.health <= 0 then v.die() end
                end
            end
        end
    end
end)