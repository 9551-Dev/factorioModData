data:extend({
    {
        type="technology",
        name="advanced-lighting",
        icon="__HSV-lamps__/prototypes/science/science.png",
        icon_size = 256,
        localised_name="advanced lighting",
        localised_description="advanced lamps with full color and HSV support",
        effects = {
            {
                type="unlock-recipe",
                recipe="hsv-lamp-recipe"
            },
            {
                type="unlock-recipe",
                recipe="flat-hsv-lamp-recipe"
            },
        },
        prerequisites = {
            "optics",
            "electronics",
            "circuit-network"
        },
        unit = {
            count = 50,
            time=10,
            ingredients={
                {"automation-science-pack",1},
                {"logistic-science-pack",1}
            },
        },
    }
})

