-- 反馈
function FiveCloudSystemEvent:Feedback(e)
    if FiveCloudConfig["isCloudMode"] and FiveCloudConfig["IsDedicatedServer"] then
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
                        FiveCloudSDK:Message("#NotIsCloudMode", e.playerid, "error")
                    else
                        FiveCloudSDK:Message(v, e.playerid, "info")
                    end
                end
            end
        end)
        FiveCloudSDK:HttpPostWithSign(url, playerid, data, callback)
    else
        FiveCloudSDK:Message("#NotIsCloudMode", e.playerid, "error")
    end
end
