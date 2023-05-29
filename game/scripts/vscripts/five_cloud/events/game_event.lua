if not FiveCloudGameEvent then
    FiveCloudGameEvent = class({})
end

function FiveCloudGameEvent:OnGameRulesStateChange(e)
    FiveCloudSDK:Print(e, "OnGameRulesStateChange")
    local game_state = GameRules:State_Get()
    --------------------- 设置队伍阶段 ---------------------
    if game_state == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
        GameState:GameStateCustomGameSetup()
        --------------------- 选择英雄阶段 ---------------------
    elseif game_state == DOTA_GAMERULES_STATE_HERO_SELECTION then
        GameState:GameStateHeroSelection()
        ----------------------- 决策阶段 -----------------------
    elseif game_state == DOTA_GAMERULES_STATE_STRATEGY_TIME then
        GameState:GameStateStrategyTime()
        --------------------- 队伍展示阶段 ---------------------
    elseif game_state == DOTA_GAMERULES_STATE_TEAM_SHOWCASE then
        GameState:GameStateTeamShowcase()
        ------------------- 等待地图加载阶段 -------------------
    elseif game_state == DOTA_GAMERULES_STATE_WAIT_FOR_MAP_TO_LOAD then
        GameState:GameStateWaitForMapToLoad()
        ----------------------- 预备阶段 -----------------------
    elseif game_state == DOTA_GAMERULES_STATE_PRE_GAME then
        GameState:GameStatePreGame()
        ----------------------- 开始游戏 -----------------------
    elseif game_state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        GameState:GameStateInProgress()
        ----------------------- 游戏结束 -----------------------
    elseif game_state == DOTA_GAMERULES_STATE_POST_GAME then
        GameState:GameStatePostGame()
    end
end

function FiveCloudGameEvent:OnPlayerChat(e)
    FiveCloudSDK:Print(e, "OnPlayerChat")

    if FiveCloudConfig["isDebugMode"] then
        local text = string.sub(e.text, 1, 1)
        if text == "-" then
            ChatEvent:Resolving(e)
        end
    end
end

function FiveCloudGameEvent:OnNPCSpawned(e)
    -- FiveCloudSDK:Print(e, "OnNPCSpawned")
    local unit = EntIndexToHScript(e.entindex)

    if unit:IsIllusion() then
        FiveCloudSystemEvent:OnIllusionSpawn(unit)
    end

end

-- 监听单位死亡
function FiveCloudGameEvent:OnEntityKilled(e)
    -- FiveCloudSDK:Print(e, "OnEntityKilled")
    local killed = EntIndexToHScript(e.entindex_killed) -- 被杀
    local attacker = EntIndexToHScript(e.entindex_attacker) -- 凶手

    if killed:IsRealHero() and not killed:IsClone() then
        FiveCloudSDK:Print(killed:GetAbsOrigin(), "killed:GetAbsOrigin")
        if FiveCloudConfig["HeroSituRespawnMode"] then
            killed:SetRespawnPosition(killed:GetAbsOrigin())
        end
    end
end

function FiveCloudGameEvent:OnPlayerDisconnect(e)
    FiveCloudSDK:Print(e, "OnPlayerDisconnect")
    if FiveCloudConfig["isCloudMode"] then
        local nPlayerID = e.PlayerID
        local url = '/dota2/user/logout'
        FiveCloudSDK:HttpPostWithSign(url, nPlayerID, {}, nil)
    end
end

function FiveCloudGameEvent:OnPlayerReconnected(e)
    FiveCloudSDK:Print(e, "OnPlayerReconnected")
    if FiveCloudConfig["isCloudMode"] then
        local url = '/dota2/user/login'
        local nPlayerID = e.PlayerID
        FiveCloudSDK:httpPostWithSign(url, nPlayerID, {}, nil)
    end
    CustomGameEventManager:Send_ServerToAllClients("ShowTopMenu", {})
end