local base_lamp = data.raw["lamp"]["small-lamp"]
local api = require("__HSV-lamps__/api")
local connection_sprites = require("__HSV-lamps__/prototypes/lamps/flat-lamp/connection-sprites")
local lamp = table.deepcopy(base_lamp)

lamp.signal_to_color_mapping = nil
lamp.name = "small-flat-hsv-lamp"

lamp.picture_off = {
    layers = {
        {
            filename = "__HSV-lamps__/graphics/lamps/flat-lamp/lamp-base.png",
            priority = "no-atlas",
            width = 64,
            height = 64,
            frame_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            scale = 0.5
        }
    }
}

lamp.energy_usage_per_tick = api.string_manipulation.multiplyPower(lamp.energy_usage_per_tick,10)

lamp.selection_box = {{-0.5, -0.5}, {0.5, 0.5}}

lamp.collision_box = nil

lamp.tile_width = 1
lamp.tile_height = 1

lamp.picture_on = {
    filename = "__HSV-lamps__/graphics/lamps/flat-lamp/lamp-base.png",
    priority = "no-atlas",
    width = 64,
    height = 64,
    frame_count = 1,
    axially_symmetrical = false,
    direction_count = 1,
    scale = 0.5
}


lamp.use_colors = false

lamp.light.size = 0

lamp.circuit_connector_sprites = connection_sprites

lamp.circuit_wire_connection_point.wire = {
    green={x=0.45,y=0.45},
    red={x=0.42,y=0.42}
}

lamp.minable.result = "small-flat-hsv-lamp-item"

data:extend({
    lamp
})