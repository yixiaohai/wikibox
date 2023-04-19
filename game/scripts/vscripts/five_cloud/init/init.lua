function FiveCloud:InitGameMode()

    FiveCloud:GameConfig()

    if FiveCloudConfig["isDebugMode"] then
        SendToServerConsole("sv_cheats true")
    end

    if FiveCloudConfig["isCloudMode"] and FiveCloudConfig["IsDedicatedServer"] then
        if FiveCloudConfig["keyStatusCompleted"] then
            FiveCloudSDK:FiveCloudInit()
        else
            FiveCloudSDK:SetKey()
        end
    end

    ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(FiveCloudGameEvent, "OnGameRulesStateChange"),
        FiveCloudGameEvent) -- 监听游戏进程
    ListenToGameEvent("player_chat", Dynamic_Wrap(FiveCloudGameEvent, "OnPlayerChat"), FiveCloudGameEvent) -- 聊天
    ListenToGameEvent("npc_spawned", Dynamic_Wrap(FiveCloudGameEvent, "OnNPCSpawned"), FiveCloudGameEvent) -- 监听单位生成
    ListenToGameEvent("entity_killed", Dynamic_Wrap(FiveCloudGameEvent, "OnEntityKilled"), FiveCloudGameEvent) -- 监听单位死亡
    ListenToGameEvent("player_disconnect", Dynamic_Wrap(FiveCloudGameEvent, "OnPlayerDisconnect"), FiveCloudGameEvent) -- 断线
    ListenToGameEvent("player_reconnected", Dynamic_Wrap(FiveCloudGameEvent, "OnPlayerReconnected"), FiveCloudGameEvent) -- 重连

    CustomGameEventManager:RegisterListener("five_cloud_custom_event", Dynamic_Wrap(FiveCloudCustomEvent, "Index"))
    CustomGameEventManager:RegisterListener("five_cloud_system_event", Dynamic_Wrap(FiveCloudSystemEvent, "Index"))

    if IsInToolsMode() then
        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("collectgarbage"), function()
            local m = collectgarbage('count')
            FiveCloudSDK:Print(string.format("%.3f KB  %.3f MB", m, m / 1024), "Lua Memory")
            return 60
        end, 0)

        if FiveCloudConfig["profiling"] then
            -- 仅生成耗时百分比大于1%的报告
            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("profiling"), function()
                FiveCloudSDK:ProfilingReadReport()
                return FiveCloudConfig["profilingReportInterval"]
            end, 0)
        end
    end
end

