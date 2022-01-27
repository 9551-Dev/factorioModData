local setting = settings.startup["darker-dark"].value
for k,v in pairs(data.raw["lamp"]) do
    local lamp = data.raw["lamp"][k]
    local value = tonumber(lamp.energy_usage_per_tick:match("%d-(.-)%a"))
    local valType = lamp.energy_usage_per_tick:match("%a+")
    data.raw["lamp"][k].energy_usage_per_tick = tostring(value/settings.startup["light-power-multiplier"].value)..valType
    if setting then data.raw["lamp"][k].light.size = v.light.size/settings.startup["light-range-decreaser"].value end
end
if setting then
    data.raw["character"]["character"].light = nil
end