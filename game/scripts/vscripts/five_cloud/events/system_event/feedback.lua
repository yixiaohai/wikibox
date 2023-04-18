-- 反馈
function FiveCloudSystemEvent:Feedback(e)
    if not FiveCloudConfig["isCloudMode"] then
        FiveCloudSDK:Message("#NotIsCloudMode", e.playerid)
        return
    end
    FiveCloudSDK:Print(e,"[feedback]")
    local url = '/dota2/feedback/edit'
    local playerid = e.playerid
    local data = {
        Content = e.content
    }
    local callback = (function(res)
        if res then
            local v = res.message
            if res.code == 200 then
                FiveCloudSDK:Message(v, e.playerid, "info")
            else
                if res.code == 40002 then
                    FiveCloudSDK:Message("非服务器主机", e.playerid, "info")
                else
                    FiveCloudSDK:Message(v, e.playerid, "info")
                end
            end
        end
    end)
    FiveCloudSDK:HttpPostWithSign(url, playerid, data, callback)
end