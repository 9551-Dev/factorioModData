local soundList = {}
for i=1,6 do
    soundList[i] = {
        path="TC:chop_"..tostring(i),
        position={},
        volume_modifier=1
    }
end
return soundList