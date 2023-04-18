function FiveCloudSystemEvent:GetMailList(e)
    if not FiveCloudConfig["isCloudMode"] then
        FiveCloudSDK:Message("#NotIsCloudMode", e.playerid)
        return
    end
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
end

function FiveCloudSystemEvent:ReadMail(e)
    if not FiveCloudConfig["isCloudMode"] then
        FiveCloudSDK:Message("#NotIsCloudMode", e.playerid)
        return
    end
    local data = {
        Id = e.id
    }
    FiveCloudSDK:HttpPostWithSign("/dota2/mail/update", e.playerid, data, nil)
end

function FiveCloudSystemEvent:DeleteMail(e)
    if not FiveCloudConfig["isCloudMode"] then
        FiveCloudSDK:Message("#NotIsCloudMode", e.playerid)
        return
    end
    local data = {
        Id = e.id
    }
    FiveCloudSDK:HttpPostWithSign("/dota2/mail/delete", e.playerid, data, nil)
end