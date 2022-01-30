data:extend({
    {
        type="recipe",
        name="hsv-lamp-recipe",
        localised_name="HSV lamp",
        localised_description="a colorful lamp with HSV support",
        enabled=false,
        subgroup="circuit-network",
        ingredients = {
            {"electronic-circuit",2},
            {"small-lamp",1},
            {"constant-combinator",1}
        },
        result="small-hsv-lamp-item"
    }
})  