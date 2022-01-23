local api = require("__uranium-toolkit__/api")

local baseSplitter = data.raw["splitter"]["splitter"]
local splitter = table.deepcopy(baseSplitter)

splitter.name = "uranium-splitter"
splitter.icon = "__uranium-toolkit__/graphics/icons/splitter.png"
splitter.icon_size = 32
splitter.max_health = 1000
splitter.corpse = "uranium-splitter-remnants"
splitter.fast_replace_group = "splitter"
splitter.speed = 0.9
splitter.animation_speed_coefficient = 57.6

splitter.minable = {
    hardness = 0.2,
    mining_time = 0.4,
    result = "uranium-splitter-item"
}

splitter.belt_animation_set = api.uranium_belt_animation_set

splitter.structure = {
    north = {
        filename = "__uranium-toolkit__/graphics/splitter/uranium-splitter-north.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 160,
        height = 70,
        shift = api.util.by_pixel(7, 0),
        scale = 0.5
    },
    east = {
        filename = "__uranium-toolkit__/graphics/splitter/uranium-splitter-east.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 90,
        height = 84,
        shift = api.util.by_pixel(4, 13),
        scale = 0.5
    },
    south = {
        filename = "__uranium-toolkit__/graphics/splitter/uranium-splitter-south.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 164,
        height = 64,
        shift = api.util.by_pixel(4, 0),
        scale = 0.5
    },
    west = {
        filename = "__uranium-toolkit__/graphics/splitter/uranium-splitter-west.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 94,
        height = 86,
        shift = api.util.by_pixel(6, 12),
        scale = 0.5
    }
}

splitter.structure_patch = {
    north = api.util.empty_sprite(),
    east = {
        filename = "__uranium-toolkit__/graphics/splitter/uranium-splitter-east-top_patch.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 90,
        height = 104,
        shift = api.util.by_pixel(4, -20),
        scale = 0.5
    },
    south = api.util.empty_sprite(),
    west = {
        filename = "__uranium-toolkit__/graphics/splitter/uranium-splitter-west-top_patch.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 94,
        height = 96,
        shift = api.util.by_pixel(6, -18),
        scale = 0.5
    }
}

data:extend({
    splitter
})
