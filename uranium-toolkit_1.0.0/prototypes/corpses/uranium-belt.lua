local util = require("util")
local api = require("__uranium-toolkit__/api")

data:extend({
    {
        type="corpse",
        name="uranium-belt-remnants",
        icon="__uranium-toolkit__/graphics/icons/belt.png",
        icon_size=32,
        flags={"placeable-neutral","building-direction-8-way","not-on-map"},
        subground="generic-remnants",
        order="a-a-a",
        selection_box={{-0.5,-0.5},{0.5,0.5}},
        tile_width=1,
        tile_height=1,
        selectable_in_game=false,
        time_before_removed=60*60*15,
        final_render_layer="remnants",
        remove_on_tile_placement=false,
        animation = api.make_rotated_animation_variations_from_sheet(8,{
            filename="__uranium-toolkit__/graphics/belt/uranium-belt-remnants.png",
            line_length=1,
            width="106",
            height="102",
            frame_count=1,
            axially_symmetrical = false,
            variation_count=1,
            direction_count=1,
            shift=util.by_pixel(0,3.5),
            scale=0.5
        })
    }
})