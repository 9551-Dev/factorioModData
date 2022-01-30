data:extend({
    {
        type="int-setting",
        name="HSVL:lamp-updates-per-update",
        setting_type="runtime-global",
        default_value=10,
        minimum_value=1,
        localised_name="lamp updates per update",
        localised_descriptions="amount of lamps updated per 1 update"
    },
    {
        type="int-setting",
        name="HSVL:update-rate",
        setting_type="runtime-global",
        default_value=1,
        minimum_value=1,
        maximum_value=60,
        localised_name="update rate",
        localised_descriptions="amount of ticks between updates"
    }
})