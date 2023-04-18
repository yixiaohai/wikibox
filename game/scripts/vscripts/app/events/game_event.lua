if not GameEvent then
    GameEvent = class({})
end

function GameEvent:OnGameRulesStateChange(e)
    local game_state = GameRules:State_Get()
    --------------------- 设置队伍阶段 ---------------------
    if game_state == DOTA_GAMERULES_STATE_PRE_GAME then
        -- 自定义的野怪检测框
        AppEvent:NeutralcampRefreshRange({
            checked = 0
        })
    end
end

-- 监听单位死亡
function GameEvent:OnEntityKilled(e)
    -- FiveCloudSDK:Print(e, "OnEntityKilled")
    local killed = EntIndexToHScript(e.entindex_killed) -- 被杀
    local attacker = EntIndexToHScript(e.entindex_attacker) -- 凶手

    if FiveCloudConfig["isCloudMode"] then
        if killed:GetClassname() == "npc_dota_fort" then
            for nPlayerID = 0, (DOTA_MAX_TEAM_PLAYERS - 1) do
                if PlayerResource:GetConnectionState(nPlayerID) == DOTA_CONNECTION_STATE_CONNECTED then
                    local url = '/dota2/user/logout'
                    FiveCloudSDK:HttpPostWithSign(url, nPlayerID, {}, nil)
                end
            end
        end
    end
end