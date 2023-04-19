function AppEvent:OnJsCompleted(e)
    if not Convars:GetBool("dota_selection_groups") then
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
end