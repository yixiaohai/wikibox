function App:Init()
    App:GameConfig()
    
    ListenToGameEvent("entity_killed", Dynamic_Wrap(GameEvent, "OnEntityKilled"), GameEvent) -- 监听单位死亡
    ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(GameEvent, "OnGameRulesStateChange"), GameEvent) -- 监听游戏进程

    CustomGameEventManager:RegisterListener("app_event", Dynamic_Wrap(AppEvent, "Index"))
    GameRules:GetGameModeEntity():SetModifierGainedFilter(Dynamic_Wrap(Filter, "ModifierGainedFilter"), Filter)
end

function App:Precache(context)
    local kv_files = {"scripts/npc/npc_units_custom.txt", "scripts/npc/npc_abilities_custom.txt",
                        "scripts/npc/npc_heroes_custom.txt", "scripts/npc/npc_items_custom.txt",
                        "scripts/npc/npc_heroes.txt", "scripts/npc/npc_abilities.txt"}

    FiveCloudSDK:PrecacheEveryThingFromKV(context, kv_files)
end

