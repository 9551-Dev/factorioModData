local function make_rotated_animation_variations_from_sheet(variation_count, sheet)
    local result = {}
    local function set_y_offset(variation, i)
        local frame_count = variation.frame_count or 1
        local line_length = variation.line_length or frame_count
        if (line_length < 1) then
            line_length = frame_count
        end
        local height_in_frames = math.floor((frame_count * variation.direction_count + line_length - 1) / line_length)
        variation.y = variation.height * (i - 1) * height_in_frames
    end
    for i = 1,variation_count do
        local variation = util.table.deepcopy(sheet)
        if variation.layers then
            for _, layer in pairs(variation.layers) do
                set_y_offset(layer, i)
                if (layer.hr_version) then
                    set_y_offset(layer.hr_version, i)
                end
            end
        else
            set_y_offset(variation, i)
            if (variation.hr_version) then
                set_y_offset(variation.hr_version, i)
            end
        end
        table.insert(result, variation)
    end
    return result
end

local uranium_belt_animation_set = {
    animation_set = {
        filename="__uranium-toolkit__/graphics/belt/uranium-belt.png",
        priority="extra-high",
        width=128,
        height=128,
        frame_count=32,
        direction_count=20,
        scale=0.5,
    }
}

return {
    make_rotated_animation_variations_from_sheet = make_rotated_animation_variations_from_sheet,
    uranium_belt_animation_set = uranium_belt_animation_set,
    util=require("util")
}