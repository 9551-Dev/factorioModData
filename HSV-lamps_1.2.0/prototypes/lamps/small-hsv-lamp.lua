local base_lamp = data.raw["lamp"]["small-lamp"]
local api = require("__HSV-lamps__/api")
local lamp = table.deepcopy(base_lamp)

lamp.signal_to_color_mapping = nil
lamp.name = "small-hsv-lamp"

lamp.picture_off = {
    layers = {
        {
            filename = "__HSV-lamps__/graphics/lamps/rainbow-lamp.png",
            priority = "high",
            width = 83,
            height = 70,
            frame_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(0.25,3),
            scale = 0.5
        },
        {
            filename = "__HSV-lamps__/graphics/lamps/lamp-shadow.png",
            priority = "high",
            width = 76,
            height = 47,
            frame_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(4, 4.75),
            draw_as_shadow = true,
            scale = 0.5
        }
    }
}

lamp.energy_usage_per_tick = api.string_manipulation.multiplyPower(lamp.energy_usage_per_tick,10)

lamp.picture_on = {
    filename = "__HSV-lamps__/graphics/lamps/rainbow-lamp.png",
    priority = "high",
    width = 83,
    height = 70,
    frame_count = 1,
    axially_symmetrical = false,
    direction_count = 1,
    shift = util.by_pixel(0.25,3),
    scale = 0.5
}

lamp.corpse = "hsv-lamp-remnants"

lamp.use_colors = false

lamp.light.size = 0

lamp.localised_name="HSV lamp"
lamp.localised_description="a colorful lamp with HSV support"

lamp.minable.result = "small-hsv-lamp-item"

data:extend({
    lamp
})