local torch = {
    always_on = true,
    glow_size=8,
    draw_copper_wires=false,
    draw_circuit_wires=false,
    energy_usage_per_tick=tostring(1/60).."J",
    render_no_power_icon = false,
    render_no_network_icon = false,
    subgroup="circuit-network"
}

local icon = {
    {
        icon="__allnightorio__/textures/torchlit.png",
        tint={r=1,g=1,b=1,a=1},
        icon_size = 32
    }   
}

torch.icons = icon

torch.type = "lamp"
torch.name = "burner-torch"

local sprite = {
    filename = "__allnightorio__/textures/torchlit.png",
    priority = "extra-high",
    width = 32,
    height = 32
}

torch.picture_on = sprite
torch.picture_off = sprite
torch.sticker_box = {{-0.5, -0.5}, {0.5, 0.5}}
torch.selection_box = {{-0.5, -0.5}, {0.5, 0.5}}
torch.collision_box = {{-0.2, -0.2}, {0.2, 0.2}}
torch.minable = {mining_time = 0.2,result="wood",count=2    }


torch.light = {
    intensity = 0.8,
    size=35,
    color={
        r=0.7,
        g=0.5,
        b=0
    }
}

local energySource = {
    type="void",
}

torch.energy_source = energySource

local torchItem = {
    type="item",
    name="burner-torch",
    place_result="burner-torch",
    icons=icon,
    stack_size=20
}

local torchrecipe = {
    type="recipe",
    enabled=true,
    name="burner-torch",
    ingredients={{"coal",5},{"wood",2}},
    result="burner-torch"
}

data:extend{torch,torchItem,torchrecipe}