for size=1,100 do
    for spaces=0,10 do
        data:extend({
            {
                type = "font",
                name = "minecraft-"..tostring(size).."-"..tostring(spaces),
                from = "minecraft",
                size = size,
                spacing = spaces
            }
        })
    end
end