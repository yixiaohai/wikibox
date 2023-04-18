function FiveCloudCustomEvent:GetEntKV(e)
    local kvType = e.kvType or 1
    local data = {}
    local ent_name = nil
    local kv = FiveCloudCustomEvent.unitListKV
    if kvType == 1 then
        local ent = EntIndexToHScript(e.ent)
        if ent then
            if ent:IsHero() then
                kv = FiveCloudCustomEvent.heroListKV
            end
            ent_name = ent:GetUnitName()
        end
    end

    if kvType == 2 then
        ent_name = e.abilityName
        kv = FiveCloudCustomEvent.abilityListKV
    end

    if ent_name then
        for k, v in pairs(kv) do
            if type(v) == "table" then
                if k == ent_name then
                    for k1, v1 in pairs(v) do
                        data[k1] = v1
                    end
                    break
                end
            end
        end
        data["FiveCloud_Title"] = ent_name
        data["FiveCloud_Ent"] = e.ent
        if e.updateServerStatus == 1 then
            CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(e.playerid), "UpdateServerStatus", {
                name = "EntKVButton",
                data = true,
                kvType = kvType
            })
        end

        FiveCloudSDK:Print(data, 'UpdateEntKV')
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(e.playerid), "UpdateEntKV", data)
    end
end

-- 同步状态
function FiveCloudCustomEvent:GetEntKVEnd(e)
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(e.playerid), "UpdateServerStatus", {
        name = "EntKVButton",
        data = false
    })
end

function FiveCloudCustomEvent:GetHeroKVByHeroId(e)
    FiveCloudCustomEvent.heroListById = {}
    for k, v in pairs(FiveCloudCustomEvent.heroListKV) do
        if string.find(k, "npc_dota_hero_base") == nil and type(v) == "table" then
            if v['HeroID'] == e.heroid then
                for k1, v1 in pairs(v) do
                    FiveCloudCustomEvent.heroListById[k1] = v1
                end
                break
            end
        end
    end

    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(e.playerid), "ToHeroKVById", {
        data = FiveCloudCustomEvent.heroListById
    })

end
