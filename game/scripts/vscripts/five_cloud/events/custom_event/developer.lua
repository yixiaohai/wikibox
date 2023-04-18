function FiveCloudCustomEvent:EntOverview(e)
    local ent_all = 0
    local ent_is_null = 0
    local ent_not_is_alive = 0
    FiveCloudCustomEvent.t_ent_is_null = {}
    FiveCloudCustomEvent.t_ent_not_is_alive = {}
    for i = 0, 99999 do
        local ent = EntIndexToHScript(i)
        if ent then
            local class_name = ent:GetClassname()
            local team = ent:GetTeamNumber()
            ent_all = ent_all + 1
            if ent:IsNull() then
                ent_is_null = ent_is_null + 1
                table.insert(FiveCloudCustomEvent.t_ent_is_null, ent)
            else
                if not ent:IsAlive() then
                    ent_not_is_alive = ent_not_is_alive + 1
                    table.insert(FiveCloudCustomEvent.t_ent_not_is_alive, ent)
                end
            end
        end
    end

    local str = "EntNumber：" .. ent_all .. " IsNull：" .. ent_is_null .. " NotIsAlive:" .. ent_not_is_alive
    FiveCloudSDK:Message(str, e.playerid, "info")
    FiveCloudSDK:Print(str)

end

function FiveCloudCustomEvent:EntIsNull(e)
    if FiveCloudCustomEvent.t_ent_is_null then
        for i, v in ipairs(FiveCloudCustomEvent.t_ent_is_null) do
            if v:GetClassname() then
                FiveCloudSDK:Print(v:GetClassname(), "GetClassname")
            end
            if v:GetClassname() then
                FiveCloudSDK:Print(v:GetAbsOrigin(), "GetAbsOrigin")
            end
            if v:GetClassname() then
                FiveCloudSDK:Print(v:GetTeamNumber(), "GetTeamNumber")
            end
        end
    else
        FiveCloudSDK:Message("需要先点击实体概览统计实体", e.playerid, "info")
    end
end

function FiveCloudCustomEvent:EntNotIsAlive(e)
    if FiveCloudCustomEvent.t_ent_not_is_alive then
        for i, v in ipairs(FiveCloudCustomEvent.t_ent_not_is_alive) do
            if v:GetClassname() then
                FiveCloudSDK:Print(v:GetClassname(), "GetClassname")
            end
            if v:GetClassname() then
                FiveCloudSDK:Print(v:GetAbsOrigin(), "GetAbsOrigin")
            end
            if v:GetClassname() then
                FiveCloudSDK:Print(v:GetTeamNumber(), "GetTeamNumber")
            end
        end
    else
        FiveCloudSDK:Message("需要先点击实体概览统计实体", e.playerid, "info")
    end
end

function FiveCloudCustomEvent:FindAllInSphere(e)
    local range = e.v
    local hero = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
    local origin = hero:GetOrigin()
    local ents = Entities:FindAllInSphere(origin, range)
    FiveCloudSDK:Message("EntNumber:" .. #ents, e.playerid, "info")
    for i = 1, #ents do
        if ents[i]:GetClassname() then
            FiveCloudSDK:Print(ents[i]:GetClassname(), "GetClassname")
        end
        if ents[i]:GetClassname() then
            FiveCloudSDK:Print(ents[i]:GetAbsOrigin(), "GetAbsOrigin")
        end
        if ents[i]:GetClassname() then
            FiveCloudSDK:Print(ents[i]:GetTeamNumber(), "GetTeamNumber")
        end
        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("FindAllInSphere"), function()
            if ents[i]:IsHero() then
                local modifiers = ents[i]:FindAllModifiers()
                if modifiers then
                    for i, v in ipairs(modifiers) do
                        FiveCloudSDK:Print(v:GetName())
                    end
                end
            end
        end, 1)
    end
end

function FiveCloudCustomEvent:ProfilingReadReport(e)
    FiveCloudSDK:ProfilingReadReport()
end

function FiveCloudCustomEvent:DotaLaunchCustomGame()
    local data = {
        command = "dota_launch_custom_game " .. FiveCloudConfig["gameName"] .. " " .. GetMapName()
    }
    FiveCloudCustomEvent:SendToServerConsole(data)
end

function FiveCloudCustomEvent:ClParticleLogCreates(e)
    local data = {}
    if e.checked == 1 then
        data.command = "cl_particle_log_creates 1"
    else
        data.command = "cl_particle_log_creates 0"
    end
    FiveCloudCustomEvent:SendToServerConsole(data)
end