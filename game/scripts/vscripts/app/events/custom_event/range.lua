
-- 防御塔白天视野
function AppEvent:TowerDayVisionRange(e)
    local towers = Entities:FindAllByClassname("npc_dota_tower")

    if e.checked == 1 then
        for _, v in pairs(towers) do
            if IsValidEntity(v) and v:IsAlive() then
                local particle = ParticleManager:CreateParticleForPlayer("particles/ui_mouseactions/range_display.vpcf",
                    PATTACH_ABSORIGIN_FOLLOW, v, PlayerResource:GetPlayer(e.playerid))
                ParticleManager:SetParticleControl(particle, 1, Vector(v:GetDayTimeVisionRange(), 1, 1))
                table.insert(AppEvent.TowerDayVisionRangeParticle, particle)
            end
        end
    else
        for k, v in pairs(AppEvent.TowerDayVisionRangeParticle) do
            ParticleManager:DestroyParticle(AppEvent.TowerDayVisionRangeParticle[k], true)
            ParticleManager:ReleaseParticleIndex(AppEvent.TowerDayVisionRangeParticle[k])
            AppEvent.TowerDayVisionRangeParticle[k] = nil
        end
    end
    CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
        name = "TowerDayVisionRange",
        data = e.checked
    })
end

-- 防御塔夜间视野
function AppEvent:TowerNightVisionRange(e)
    local towers = Entities:FindAllByClassname("npc_dota_tower")

    if e.checked == 1 then
        for _, v in pairs(towers) do
            if IsValidEntity(v) and v:IsAlive() then
                local particle = ParticleManager:CreateParticleForPlayer("particles/ui_mouseactions/range_display.vpcf",
                    PATTACH_ABSORIGIN_FOLLOW, v, PlayerResource:GetPlayer(e.playerid))
                ParticleManager:SetParticleControl(particle, 1, Vector(v:GetNightTimeVisionRange(), 1, 1))
                table.insert(AppEvent.TowerNightVisionRangeParticle, particle)
            end
        end
    else
        for k, v in pairs(AppEvent.TowerNightVisionRangeParticle) do
            ParticleManager:DestroyParticle(AppEvent.TowerNightVisionRangeParticle[k], true)
            ParticleManager:ReleaseParticleIndex(AppEvent.TowerNightVisionRangeParticle[k])
            AppEvent.TowerNightVisionRangeParticle[k] = nil
        end
    end
    CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
        name = "TowerNightVisionRange",
        data = e.checked
    })
end

-- 防御塔仇恨范围
function AppEvent:TowerHateRange(e)
    local towers = Entities:FindAllByClassname("npc_dota_tower")

    if e.checked == 1 then
        for _, v in pairs(towers) do
            if IsValidEntity(v) and v:IsAlive() then
                local particle = ParticleManager:CreateParticleForPlayer("particles/ui_mouseactions/range_display.vpcf",
                    PATTACH_ABSORIGIN_FOLLOW, v, PlayerResource:GetPlayer(e.playerid))
                ParticleManager:SetParticleControl(particle, 1, Vector(500, 1, 1))
                table.insert(AppEvent.TowerHateRangeParticle, particle)
            end
        end
    else
        FiveCloudSDK:Print(AppEvent.TowerHateRangeParticle)
        for k, v in pairs(AppEvent.TowerHateRangeParticle) do
            ParticleManager:DestroyParticle(AppEvent.TowerHateRangeParticle[k], true)
            ParticleManager:ReleaseParticleIndex(AppEvent.TowerHateRangeParticle[k])
            AppEvent.TowerHateRangeParticle[k] = nil
        end
    end
    CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
        name = "TowerHateRange",
        data = e.checked
    })
end