function FiveCloudSystemEvent:GetMailList(e)
    if FiveCloudConfig["isCloudMode"] and FiveCloudConfig["IsDedicatedServer"] then
        local player = PlayerResource:GetPlayer(e.playerid)

        local callback = (function(res)
            local data = {
                status = false
            }
            if res.code == 200 then
                data.status = true
                data.list = res.data
            end
            CustomGameEventManager:Send_ServerToPlayer(player, "MailList", data)
        end)

        FiveCloudSDK:HttpPostWithSign("/dota2/mail/list", e.playerid, {}, callback)
    else
        FiveCloudSDK:Message("#NotIsCloudMode", e.playerid, "error")
    end
end

function FiveCloudSystemEvent:ReadMail(e)
    if FiveCloudConfig["isCloudMode"] and FiveCloudConfig["IsDedicatedServer"] then
        local data = {
            Id = e.id
        }
        FiveCloudSDK:HttpPostWithSign("/dota2/mail/update", e.playerid, data, nil)
    else
        FiveCloudSDK:Message("#NotIsCloudMode", e.playerid, "error")
    end
end

function FiveCloudSystemEvent:DeleteMail(e)
    if FiveCloudConfig["isCloudMode"] and FiveCloudConfig["IsDedicatedServer"] then
        local data = {
            Id = e.id
        }
        FiveCloudSDK:HttpPostWithSign("/dota2/mail/delete", e.playerid, data, nil)
    else
        FiveCloudSDK:Message("#NotIsCloudMode", e.playerid, "error")
    end
end
