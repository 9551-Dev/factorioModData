local api = require("__HSV-lamps__/api.lua")
return {
    led_red = {
        filename="__HSV-lamps__/graphics/lamps/flat-lamp/connector-off.png",
        width=6,
        height=6,
        priority="extra-high-no-scale",
        shift=api.util.by_pixel(13,13)
    },
    led_blue = {
        filename="__HSV-lamps__/graphics/lamps/flat-lamp/connector-blue.png",
        width=6,
        height=6,
        priority="extra-high-no-scale",
        shift=api.util.by_pixel(13,13)
    },
    led_green={
        type="sprite",
        filename="__HSV-lamps__/graphics/lamps/flat-lamp/connector-on.png",
        width=6,
        height=6,
        priority="extra-high-no-scale",
        shift=api.util.by_pixel(13,13)
    },
    led_light={
        color = {r=0,g=255,b=0,a=255},
        size = 0,
        intensity = 0
    }
}