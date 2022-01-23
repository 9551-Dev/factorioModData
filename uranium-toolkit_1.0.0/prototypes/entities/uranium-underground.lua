local baseBelt = data.raw["underground-belt"]["underground-belt"]
local api = require("__uranium-toolkit__/api")
local belt = table.deepcopy(baseBelt)

belt.name = "uranium-underground-belt" 
belt.icon = "__uranium-toolkit__/graphics/icons/underground.png"
belt.icon_size = 32
belt.max_health = 1000
belt.corpse = "uranium-belt-remnants"
belt.speed = 0.9
belt.animation_speed_coefficient = 57.6
belt.max_distance = 40

belt.minable = {
    hardness = 0.2,
    mining_time = 0.4,
    result = "uranium-underground-belt-item",
}

belt.belt_animation_set = api.uranium_belt_animation_set

belt.structure = {
    direction_in = {
        sheet = {
            filename = "__uranium-toolkit__/graphics/underground/uranium-underground-belt-structure.png",
            priority = "extra-high",
            width = 192,
            height =192,
            y = 192,
            scale = 0.5
        }
    },
    direction_out = {
        sheet = {
            filename = "__uranium-toolkit__/graphics/underground/uranium-underground-belt-structure.png",
            priority = "extra-high",
            width = 192,
            height = 192,
            scale = 0.5
        }
    },
    direction_in_side_loading = {
        sheet = {
            filename = "__uranium-toolkit__/graphics/underground/uranium-underground-belt-structure.png",
            priority = "extra-high",
            width = 192,
            height = 192,
            y = 192*3,
            scale = 0.5
        }
    },
    direction_out_side_loading = {
        sheet = {
            filename = "__uranium-toolkit__/graphics/underground/uranium-underground-belt-structure.png",
            priority = "extra-high",
            width = 192,
            height = 192,
            y= 192*2,
            scale = 0.5
        }
    },
    back_patch = {
        sheet = {
            filename = "__uranium-toolkit__/graphics/underground/uranium-underground-belt-structure-back-patch.png",
            priority = "extra-high",
            width = 192,
            height = 192,
            scale = 0.5
        }
    },
    front_patch = {
        sheet = {
            filename = "__uranium-toolkit__/graphics/underground/uranium-underground-belt-structure-front-patch.png",
            priority = "extra-high",
            width = 192,
            height = 192,
            scale = 0.5
        }
    }
}

data:extend({
    belt
})
