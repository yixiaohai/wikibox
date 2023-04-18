function FiveCloudCustomEvent:OnJsCompleted(e)
    local data = {
        isCloudMode = FiveCloudConfig["isCloudMode"],
        isDebugMode = FiveCloudConfig["isDebugMode"],
        IsDedicatedServer = FiveCloudConfig["IsDedicatedServer"],
        heroMaxAbilityNum = FiveCloudConfig["heroMaxAbilityNum"],
        heroMaxInventoryNum = FiveCloudConfig["heroMaxInventoryNum"],
        loadingImage = FiveCloudConfig["loadingImage"],
    }
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(e.playerid), "FiveCloud_UpdateConfig", data)

    if GameRules:IsCheatMode() then
        local v = FiveCloudConfig["EasyBuy"]
        SendToServerConsole("dota_easybuy " .. v)
        CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
            name = "EasyBuy",
            data = v
        })
    end

    if Convars:GetBool("dota_selection_groups") then
        CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
            name = "SelectionGroups",
            data = true
        })
    end

    if Convars:GetBool("dota_player_smart_multiunit_cast") then
        CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
            name = "SmartMultiunitCast",
            data = true
        })
    end

    if Convars:GetBool("dota_minimap_disable_rightclick") then
        CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
            name = "MinimapDisableRightclick",
            data = true
        })
    end

    if Convars:GetBool("dota_ability_debug") then
        CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
            name = "FreeSpells",
            data = true
        })
    end
    
    
    FiveCloudCustomEvent:HeroFastRespawn({checked = FiveCloudConfig["HeroFastRespawn"]})
    FiveCloudCustomEvent:HeroSituRespawn({checked = FiveCloudConfig["HeroSituRespawn"]})
end

-- 发送控制台命令
function FiveCloudCustomEvent:SendToServerConsole(e)
    if GameRules:IsCheatMode() then
        SendToServerConsole(e.command)
    else
        FiveCloudSDK:Message("#NotIsCheatMode", e.playerid, "error")
    end
end
