if not ChatEvent then
    ChatEvent = class({})
end

function ChatEvent:Resolving(e)
    local text = string.gsub(e.text, "-", "")
    local playerid = e.playerid
    local function_name = ""
    local args = {}
    if string.find(text, " ") then
        local text_ary = FiveCloudSDK:Split(text, " ")
        local length = #text_ary
        function_name = text_ary[1]
        for i = 2, length do
            table.insert(args, text_ary[i])
        end
    else
        function_name = text
    end
    if type(ChatEvent[function_name]) == "function" then
        ChatEvent[function_name](self, playerid, args)
    end
end

function ChatEvent:addmodifier(playerid, args)
    local hero = PlayerResource:GetPlayer(playerid):GetAssignedHero()
    local length = #args
    local modifier_name = tostring(args[1])
    local duration = -1
    if length > 1 then
        duration = tonumber(args[2])
    end
    hero:AddNewModifier(hero, nil, modifier_name, {duration = duration})
end

function ChatEvent:removemodifier(playerid, args)
    local hero = PlayerResource:GetPlayer(playerid):GetAssignedHero()
    local modifier_name = tostring(args[1])
    hero:RemoveModifierByName(modifier_name)
end