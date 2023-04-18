function App:GameConfig()
    local game_mode = GameRules:GetGameModeEntity()
    -- 设置一天的时间
    GameRules:SetTimeOfDay(0.251)
    -- 设置信使
    game_mode:SetFreeCourierModeEnabled(true)
    -- 偷塔保护
    game_mode:SetTowerBackdoorProtectionEnabled(true)
    -- 神符规则
    game_mode:SetUseDefaultDOTARuneSpawnLogic(true)

    GameRules:BeginTemporaryNight(90)
end
