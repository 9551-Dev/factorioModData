data:extend({
    {
        type="technology",
        name="uranium-toolkit-research",
        localised_name="logistics 4",
        icon="__uranium-toolkit__/research/icon.png",
        icon_size=256,
        unit={
            count=1000,
            ingredients={
                {"automation-science-pack", 2},
                {"logistic-science-pack", 8},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1}
            },
            time=120
        },
        prerequisites={
            "logistics-3",
            "speed-module-3",
            "lubricant",
            "uranium-processing"
        },
        effects = {
            {
                type="unlock-recipe",
                recipe="uranium-belt-recipe"
            },
            {
                type="unlock-recipe",
                recipe="uranium-underground-belt-recipe"
            },
            {
                type="unlock-recipe",
                recipe="uranium-splitter-recipe"
            },
            {
                type="unlock-recipe",
                recipe="uranium-inserter-recipe"
            }
        }
    }
})

