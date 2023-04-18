-- 显示范围
function FiveCloudCustomEvent:ShowRangeDialog(e)
    if GameRules:IsCheatMode() then
        SendToServerConsole("dota_range_display " .. e.v)
    else
        FiveCloudSDK:Message("#NotIsCheatMode", e.playerid, "error")
    end
end

function FiveCloudCustomEvent:GetDistance(e)
    local num = 0
    local origin = {}
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if ent then
            num = num + 1
            table.insert(origin, ent:GetOrigin())
        end
    end
    if num == 2 then
        local Length2D = (origin[1] - origin[2]):Length2D()
        FiveCloudSDK:Message("#GetDistance "..Length2D, e.playerid)
    else
        FiveCloudSDK:Message("#GetDistanceDescribe", e.playerid, "error")
    end
end

-- 显示边界体积
function FiveCloudCustomEvent:ShowBoundingRadius(e)
    if GameRules:IsCheatMode() then
        SendToServerConsole("dota_unit_show_bounding_radius " .. e.checked)
        CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
            name = "ShowBoundingRadius",
            data = e.checked
        })
    else
        FiveCloudSDK:Message("#NotIsCheatMode", e.playerid, "error")
    end

end

-- 显示选择体积
function FiveCloudCustomEvent:ShowSelectionBoxes(e)
    if GameRules:IsCheatMode() then
        SendToServerConsole("dota_unit_show_selection_boxes " .. e.checked)
        CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
            name = "ShowSelectionBoxes",
            data = e.checked
        })
    else
        FiveCloudSDK:Message("#NotIsCheatMode", e.playerid, "error")
    end
end