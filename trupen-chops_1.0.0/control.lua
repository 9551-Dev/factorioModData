local sounds = require("__trupen-chops__/soundData")

local lastPlayed = 0
local delay = 60

local mined = function(event)
    local tick = event.tick
    if math.random(3,5) == 5 and tick > lastPlayed+delay then
        lastPlayed = tick
        local pindex = event.player_index
        local entity = event.entity
        local pos = entity.position
        local surface = game.surfaces[game.players[pindex].surface.index]
        local soundIndex = math.random(1,6)
        local sound = sounds[soundIndex]
        sound.position = pos
        surface.play_sound(sound)
    end
end

script.on_event(defines.events.on_player_mined_entity,mined,{
    {
        filter = "type",
        type = "tree"
    }
})