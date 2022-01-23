local baseBelt = data.raw["transport-belt"]["transport-belt"]
local api = require("__uranium-toolkit__/api")
local belt = table.deepcopy(baseBelt)

belt.name = "uranium-belt" 
belt.icon = "__uranium-toolkit__/graphics/icons/belt.png"
belt.icon_size = 32
belt.max_health = 1000
belt.corpse = "uranium-belt-remnants"
belt.fast_replaceable_group = "transport-belt"
belt.speed=0.9
belt.animation_speed_coefficient = 57.6
belt.related_underground_belt = "uranium-underground-belt"

belt.minable = {
    hardness = 0.2,
    mining_time = 0.4,
    result = "uranium-belt-item",
}

belt.belt_animation_set = api.uranium_belt_animation_set

data:extend({
    belt
})
