data:extend({
    {
        type="int-setting",
        setting_type="startup",
        name="updaterate",
        default_value=4,
        minimum_value=1,
        maximum_value=60,
        localised_name="update rate"
        
    },
    {
        type="int-setting",
        setting_type="startup",
        name="smoothness",
        default_value=1,
        minimum_value=1,
        maximum_value=100,
        localised_name="color smoothness"
    },
    {
        type="int-setting",
        setting_type="startup",
        name="visibility",
        default_value=100,
        minimum_value=0,
        maximum_value=100,
        localised_name="visibility"
    },
    {
        type="int-setting",
        setting_type="startup",
        name="timedivider",
        default_value=4,
        minimum_value=1,
        maximum_value=100,
        localised_name="time divider"
    },
    {
        type="int-setting",
        setting_type="startup",
        name="SAT",
        default_value=1,
        minimum_value=0,
        maximum_value=100,
        localised_name="HSV SATURATION"
    },
    {
        type="int-setting",
        setting_type="startup",
        name="VALUE",
        default_value=1,
        minimum_value=0,
        maximum_value=100,
        localised_name="HSV VALUE"
    }
})