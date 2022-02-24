local util = require("util")

local function make_rotated_animation_variations_from_sheet(variation_count, sheet)
    local result = {}
    local function set_y_offset(variation, i)
        local frame_count = variation.frame_count or 1
        local line_length = variation.line_length or frame_count
        if (line_length < 1) then
            line_length = frame_count
        end
        local height_in_frames = math.floor((frame_count * variation.direction_count + line_length - 1) / line_length)
        variation.y = variation.height * (i - 1) * height_in_frames
    end
    for i = 1,variation_count do
        local variation = util.table.deepcopy(sheet)
        if variation.layers then
            for _, layer in pairs(variation.layers) do
                set_y_offset(layer, i)
                if (layer.hr_version) then
                    set_y_offset(layer.hr_version, i)
                end
            end
        else
            set_y_offset(variation, i)
            if (variation.hr_version) then
                set_y_offset(variation.hr_version, i)
            end
        end
        table.insert(result, variation)
    end
    return result
end

local HSVToRGB = function(hue, saturation, value)
    if saturation == 0 then return value, value, value end
    local hue_sector = math.floor(hue / 60)
    local hue_sector_offset = (hue / 60) - hue_sector
    local p = value * (1 - saturation)
    local q = value * (1 - saturation * hue_sector_offset)
    local t = value * (1 - saturation * (1 - hue_sector_offset))
    if hue_sector == 0 then return value, t, p
    elseif hue_sector == 1 then return q, value, p
    elseif hue_sector == 2 then return p, value, t
    elseif hue_sector == 3 then return p, q, value
    elseif hue_sector == 4 then return t, p, value
    elseif hue_sector == 5 then return value, p, q end
end

local create2Darray = function(tbl)
    return setmetatable(tbl or {},
        {
            __index=function(t,k)
                local new = {}
                t[k]=new
                return new
            end
        }
    )
end

local create3Darray = function(tbl)
    return setmetatable(tbl or {},
        {
            __index=function(t,k)
                local new = create2Darray()
                t[k]=new
                return new
            end
        }
    )
end

local function interpolate(p1,p2,y)
    return (((y-p1.y)*(p2.x-p1.x)) / (p2.y-p1.y) + p1.x)
end

local function interpolateY(a,b,y)
    local ya = y - a.y
    local ba = b.y - a.y
    local x = a.x + (ya * (b.x - a.x)) / ba
    local z = a.z + (ya * (b.z - a.z)) / ba
    return x,z
end

local function interpolateZ(a,b,x)
    local z = a.z + (x-a.x) * (((b.z-a.z)/(b.x-a.x)))
    return z
end

local function interpolateOnLine(x1, y1, w1, x2, y2, w2, x3, y3)
    local fxy1=(x2-x3)/(x2-x1)*w1+(x3-x1)/(x2-x1)*w2
    return (y2-y3)/(y2-y1)*fxy1+(y3-y1)/(y2-y1)*fxy1
end

local function switchXYArray(array)
    local output = createSelfIndexArray()
    for x,yout in pairs(array) do
        if type(yout) == "table" then
            for y,val in pairs(yout) do
                output[y][x] = val
            end
        end
    end
    return output
end

local function copyArray(tbl)
    local output = {}
    for k,v in pairs(tbl) do output[k] = tbl[k] end
    return setmetatable(output,getmetatable(tbl))
end

local function strInsert(string,add)
    return string..add
end

local function getPowerValue(string)
    return string:match("%d+(%a+)%d?")
end

local function getPowerAmount(string)
    return string:match("(%d.-)%a")
end

local vectorAdd = function(n1,n2)
end

local vectorSub = function()

end

local vectorMul = function()
end

local vectorDiv = function()

end

local vectorMod = function()

end

local vectorEq = function()

end

local vectorTostring = function()

end

local function createVector(x,y,z)
    return setmetatable({
            x=x or 0,
            y=y or 0,
            z=z or 0
        },{
            __add=vectorAdd,
            __sub=vectorSub,
            __mul=vectorMul,
            __div=vectorDiv,
            __mod=vectorMod,
            __eq=vectorEq,
            __tostring=vectorTostring
        }
    )
end

local getTrueTableLen = function(tbl)
    local realLen = 0
    for k,v in pairs(tbl) do
        realLen = realLen + 1
    end
    return realLen,#tbl
end

local compareTable = function(tbl1,tbl2)
    local isMatching = true
    local tbl1Len = getTrueTableLen(tbl1)
    local tbl2Len = getTrueTableLen(tbl2)
    for k,v in pairs(tbl1) do
        if v ~= tbl2[k] then
            isMatching = false
        end
    end
    if isMatching and tbl1Len == tbl2Len then
        return true
    end
end

local function multiplyPower(power,mult)
    return tostring(getPowerAmount(power)*mult)..getPowerValue(power)
end

return {
    make_rotated_animation_variations_from_sheet = make_rotated_animation_variations_from_sheet,
    util=util,
    HSVToRGB=HSVToRGB,
    interpolation = {
        interpolate=interpolate,
        interpolateY=interpolateY,
        interpolateZ=interpolateZ,
        interpolateOnLine=interpolateOnLine,
    },
    array_manipulation = {
        switchXYArray=switchXYArray,
        copyArray=copyArray,
        deepCopy=util.table.deepcopy,
        create2Darray=create2Darray,
        create3Darray=create3Darray,
        get_true_length=getTrueTableLen,
        compare_table=compareTable
    },
    vector={
        create=createVector,
    },
    simple={
        string_connect=strInsert
    },
    string_manipulation={
        getPowerValue=getPowerValue,
        getPowerAmount=getPowerAmount,
        multiplyPower=multiplyPower,
    }
}
