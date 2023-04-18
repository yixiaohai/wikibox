-- 向前端发送消息
-- @param content string 消息内容
-- @param playerid int 发送给的玩家
-- @param type string 如果是error，用dota默认风格来显示消息
function FiveCloudSDK:Message(content, playerid, type)
    if type == "error" then
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerid), "CustomHUDError", {
            v = content
        })
    else
        if playerid == nil then
            GameRules:SendCustomMessage(content, 1, -1)
        else
            GameRules:SendCustomMessage(content, 1, playerid)
        end
    end
end