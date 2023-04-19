-- 显示范围
function FiveCloudCustomEvent:ShowRangeDialog(e)
    local v = e.v
    local playerid = e.playerid
    local player = PlayerResource:GetPlayer(playerid)
    local hero = player:GetAssignedHero()
    local index = FiveCloudCustomEvent.ShowRangeDialogList[playerid]
    if index then
        ParticleManager:DestroyParticle(index, true)
        ParticleManager:ReleaseParticleIndex(index)
    end
    if v > 0 then
        local particle = ParticleManager:CreateParticleForPlayer("particles/ui_mouseactions/range_display.vpcf",
            PATTACH_ABSORIGIN_FOLLOW, hero, player)
        ParticleManager:SetParticleControl(particle, 1, Vector(v, 1, 1))
        FiveCloudCustomEvent.ShowRangeDialogList[playerid] = particle
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
        FiveCloudSDK:Message("#GetDistance " .. Length2D, e.playerid)
    else
        FiveCloudSDK:Message("#GetDistanceDescribe", e.playerid, "error")
    end
end


