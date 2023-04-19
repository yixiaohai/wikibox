-- 获取服务器状态
function FiveCloudSDK:FiveCloudInit()
    self:HttpPostWithSign("/app/getKeyStatus", nil, {
        appid = FiveCloudConfig["appid"],
        appsecret = FiveCloudConfig["appsecret"]
    }, function(res)
        if res then
            if res.code == 200 then
                if res.data.status then
                    FiveCloudConfig["serveMode"] = true
                    FiveCloudConfig["gameStartTime"] = res.data.timestamp - math.floor(Time() + 0.5)
                    FiveCloudConfig["isOpen"] = res.data.isOpen
                    FiveCloudConfig["needInviteCode"] = res.data.needInviteCode
                end
            end
            if res.message then
                FiveCloudSDK:Message(res.message)
            end
        end
    end)
end

-- 第一次上传地图的时候设置Key
function FiveCloudSDK:SetKey()
    self:HttpPost("/app/setKey", {
        appid = FiveCloudConfig["appid"],
        appsecret = FiveCloudConfig["appsecret"],
        key = GetDedicatedServerKeyV3(FiveCloudConfig["requestKey"])
    }, function(res)
        if res then
            if res.code == 200 then
                FiveCloudConfig["serveMode"] = true
                FiveCloudConfig["gameStartTime"] = res.data.timestamp - math.floor(Time() + 0.5)
                FiveCloudSDK:Message(
                    "接入成功，将配置文件中的FiveCloudConfig['keyStatusCompleted']修改为true，重新上传即可正常通信。")
            else
                FiveCloudSDK:Message(res.message)
            end
        end
    end)
end

function FiveCloudSDK:Login(playerid, callback)
    local url = '/dota2/user/login'
    local steamid = tostring(PlayerResource:GetSteamID(playerid))
    local nickname = tostring(PlayerResource:GetPlayerName(playerid))
    local data = {
        Steamid = steamid,
        Nickname = nickname
    }
    FiveCloudSDK:HttpPostWithSign(url, playerid, data, callback)
end

function FiveCloudSDK:LoginForAllPlayer()
    for playerid = 0, (DOTA_MAX_TEAM_PLAYERS - 1) do
        if PlayerResource:GetConnectionState(playerid) == DOTA_CONNECTION_STATE_CONNECTED then
            local callback = (function(res)
                if res then
                    if res.code == 200 then
                        FiveCloudSDK:Message(res.message, playerid)
                    else
                        if res.code == 40002 then
                            FiveCloudSDK:Message("#NotIsCloudMode", playerid, "error")
                        else
                            FiveCloudSDK:Message(res.message, playerid)
                        end
                    end
                end
            end)

            FiveCloudSDK:Login(playerid, callback)
        end
    end
end
