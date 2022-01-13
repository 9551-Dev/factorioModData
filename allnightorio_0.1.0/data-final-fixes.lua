for k,v in pairs(data.raw["lamp"]) do
    local lamp = data.raw["lamp"][k]
    local value = tonumber(lamp.energy_usage_per_tick:match("%d-(.-)%a"))
    local valType = lamp.energy_usage_per_tick:match("%a+")
    data.raw["lamp"][k].energy_usage_per_tick = tostring(value*30)..valType
end