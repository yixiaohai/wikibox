if not GameState then
    GameState = class({})
end

---------- 游戏状态 - 设置队伍阶段 ----------
function GameState:GameStateCustomGameSetup()

end

---------- 游戏状态 - 选择英雄阶段 ----------
function GameState:GameStateHeroSelection()

end

----------------- 决策阶段 -----------------
function GameState:GameStateStrategyTime()
    for playerid = 0, (DOTA_MAX_TEAM_PLAYERS - 1) do
        local player = PlayerResource:GetPlayer(playerid)
        if player and not PlayerResource:HasSelectedHero(playerid) then
            player:MakeRandomHeroSelection()
        end
    end
end

--------------- 队伍展示阶段 ---------------
function GameState:GameStateTeamShowcase()
end

------------- 等待地图加载阶段 -------------
function GameState:GameStateWaitForMapToLoad()
end

------------ 游戏状态 - 预备阶段 ------------
function GameState:GameStatePreGame()
    CustomGameEventManager:Send_ServerToAllClients("ShowTopMenu", {})
end

------------ 游戏状态 - 游戏开始 ------------
function GameState:GameStateInProgress()

end

------------ 游戏状态 - 游戏结束 ------------
function GameState:GameStatePostGame()
    FiveCloudSDK:Print('GameStatePostGame')
end
