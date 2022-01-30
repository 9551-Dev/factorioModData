local api = require("__HSV-lamps__/api")

data:extend({
    {
        type="corpse",
        name="hsv-lamp-remnants",
        icon="__HSV-lamps__/graphics/icons/hsv-lamp-icon.png",
        icon_size=64,
        flags = {"placeable-neutral", "not-on-map"},
        order = "a-a-a",
        collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        tile_width = 1,
        tile_height = 1,
        selectable_in_game = false,
        time_before_removed = 60 * 60 * 15,
        final_render_layer = "remnants",
        remove_on_tile_placement = false,
        animation = api.make_rotated_animation_variations_from_sheet(1,{
            filename = "__HSV-lamps__/graphics/remnants/rainbow-lamp-remnants.png",
            line_length = 1,
            width = 102,
            height = 96,
            frame_count = 1,
            variation_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(-1, 3),
            scale = 0.5
        })
    }
})