local mult = settings.startup["robrangemult"].value
for k,v in pairs(data.raw["roboport"]) do
    local logiRad,consRad = v.logistics_radius*mult,v.construction_radius*mult
    data.raw["roboport"][k].construction_radius = consRad
    data.raw["roboport"][k].logistics_radius = logiRad
end
local mult = settings.startup["cabrangemult"].value
for k,v in pairs(data.raw["electric-pole"]) do
    local wireReach,supplyArea = math.min(v.maximum_wire_distance*mult,64),math.min(v.supply_area_distance*mult,64)
    data.raw["electric-pole"][k].maximum_wire_distance = wireReach
    data.raw["electric-pole"][k].supply_area_distance = supplyArea
end
