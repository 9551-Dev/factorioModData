local util = require("util")

data:extend({
    {
        type="corpse",
        name="uranium-splitter-remnants",
        icon="__uranium-toolkit__/graphics/icons/splitter.png",
        icon_size=32,
        flags={"placeable-neutral","building-direction-8-way","not-on-map"},
        subground="belt-remnants",
        order="a-g-a",
        selection_box={{-0.9,-0.5},{0.9,0.5}},
        tile_width=2,
        tile_height=1,
        selectable_in_game=false,
        time_before_removed=60*60*15,
        final_render_layer="remnants",
        remove_on_tile_placement=false,
        animation = {
            filename="__uranium-toolkit__/graphics/splitter/uranium-splitter-remnants.png",
            line_length=1,
            width="190",
            height="190",
            frame_count=1,
            axially_symmetrical = false,
            variation_count=1,
            direction_count=4,
            shift=util.by_pixel(3.5,1.5),
            scale=0.5
        }
    }
})