-- 获取随机字符串
-- @param len int 长度
-- return string
function FiveCloudSDK:RandomStr(len)
    local rankStr = ""
    local randNum = 0

    for i = 1, len do
        if RandomInt(1, 3) == 1 then
            randNum = string.char(RandomInt(0, 25) + 65) -- 生成大写字母 random(0,25)生成0=< <=25的整数
        elseif RandomInt(1, 3) == 2 then
            randNum = string.char(RandomInt(0, 25) + 97) -- 生成小写字母
        else
            randNum = RandomInt(0, 9) -- 生成0=< and <=9的随机数字
        end
        rankStr = rankStr .. randNum
    end
    return rankStr
end

-- 分割字符串
-- @param str string 要分割的字符串
-- @param sep string 分隔符
-- return table
function FiveCloudSDK:Split(str, sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    str:gsub(pattern, function(c)
        fields[#fields + 1] = c
    end)
    return fields
end
