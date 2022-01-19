data:extend({
    {
        name = "rust:update-rate",
        type = "int-setting",
        default_value = 900,
        minimum_value = 100,
        maximum_value = 10000,
        setting_type = "startup",
    },
    {
        name = "rust:damage-multiplier",
        type = "int-setting",
        default_value = 1,
        minimum_value = 1,
        maximum_value = 10,
        setting_type = "startup",
    },
    {
        name = "rust:rise-rate",
        type = "int-setting",
        default_value = 14,
        minimum_value = 11,
        maximum_value = 100,
        setting_type = "startup",
    },
    {
        name="rust:pollution-consumption-mod",
        type = "int-setting",
        default_value = 1,
        minimum_value = 1,
        maximum_value = 100,
        setting_type = "startup",
    },
    {
        name="rust:min-pollution-to-damage",
        type = "int-setting",
        default_value = 300,
        minimum_value = 0,
        maximum_value = 1000,
        setting_type = "startup",
    },
    {
        name="rust:max-damage-n-time",
        type = "int-setting",
        default_value = 10,
        minimum_value = 1,
        maximum_value = 100,
        setting_type = "startup",
    }
})

for k,v in pairs(require("__rust__/proto_list")) do
    data:extend({
        {
            name="rust:do-"..v,
            type = "bool-setting",
            default_value = true,
            setting_type = "startup",
            localised_name = "affect: "..v
        }
    })
end