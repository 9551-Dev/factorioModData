local baseInserter = data.raw["inserter"]["fast-inserter"]
local api = require("__uranium-toolkit__/api")
local inserter = table.deepcopy(baseInserter)

inserter.name = "uranium-inserter"
inserter.icon = "__uranium-toolkit__/graphics/icons/inserter.png"
inserter.icon_size = 64
inserter.max_health = 1000
inserter.corpse = "uranium-inserter-remnants"
inserter.fast_replace_group = "inserter"
inserter.extension_speed = 1
inserter.rotation_speed = 1
inserter.flags = {"placeable-neutral", "placeable-player", "player-creation"}

inserter.minable = {
    hardness = 0.2,
    mining_time = 0.4,
    result = "uranium-belt-item",
}

inserter.energy_per_movement = "52KJ"
inserter.energy_per_rotation = "50KJ"

inserter.energy_source = {
    type="electric",
    usage_priority="secondary-input",
    drain="100kW"
}

inserter.hand_base_picture = {
    filename = "__uranium-toolkit__/graphics/inserter/uranium-inserter-hand-base.png",
    priority = "extra-high",
    width = 32,
    height = 136,
    scale = 0.25
}

inserter.hand_closed_picture = {
    filename = "__uranium-toolkit__/graphics/inserter/uranium-inserter-hand-closed.png",
    priority = "extra-high",
    width = 72,
    height = 164,
    scale = 0.25
}

inserter.hand_open_picture = {
    filename = "__uranium-toolkit__/graphics/inserter/uranium-inserter-hand-open.png",
    priority = "extra-high",
    width = 72,
    height = 164,
    scale = 0.25
}

inserter.hand_base_shadow = {
    filename = "__uranium-toolkit__/graphics/inserter/uranium-inserter-hand-base-shadow.png",
    priority = "extra-high",
    width = 32,
    height = 132,
    scale = 0.25
}

inserter.hand_closed_shadow = {
    filename = "__uranium-toolkit__/graphics/inserter/uranium-inserter-hand-closed-shadow.png",
    priority = "extra-high",
    width = 72,
    height = 164,
    scale = 0.25
}

inserter.hand_open_shadow = {
    filename = "__uranium-toolkit__/graphics/inserter/uranium-inserter-hand-open-shadow.png",
    priority = "extra-high",
    width = 72,
    height = 164,
    scale = 0.25
}

inserter.platform_picture = {
    sheet = {
        filename = "__uranium-toolkit__/graphics/inserter/uranium-inserter-platform.png",
        priority = "extra-high",
        width = 105,
        height = 79,
        shift = api.util.by_pixel(1.5, 7.5-1),
        scale = 0.5
    }
}

inserter.stack = true

data:extend({
    inserter
})