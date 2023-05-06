-- 双倍神符
function FiveCloudCustomEvent:SpawnRuneDoubleDamagePressed(e)
    local hero = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
    FiveCloudCustomEvent:SpawnRuneInFrontOfUnit(hero, DOTA_RUNE_DOUBLEDAMAGE)
end

-- 加速神符
function FiveCloudCustomEvent:SpawnRuneHastePressed(e)
    local hero = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
    FiveCloudCustomEvent:SpawnRuneInFrontOfUnit(hero, DOTA_RUNE_HASTE)
end

-- 幻象神符
function FiveCloudCustomEvent:SpawnRuneIllusionPressed(e)
    local hero = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
    FiveCloudCustomEvent:SpawnRuneInFrontOfUnit(hero, DOTA_RUNE_ILLUSION)
end

-- 隐身神符
function FiveCloudCustomEvent:SpawnRuneInvisibilityPressed(e)
    local hero = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
    FiveCloudCustomEvent:SpawnRuneInFrontOfUnit(hero, DOTA_RUNE_INVISIBILITY)
end

-- 恢复神符
function FiveCloudCustomEvent:SpawnRuneRegenerationPressed(e)
    local hero = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
    FiveCloudCustomEvent:SpawnRuneInFrontOfUnit(hero, DOTA_RUNE_REGENERATION)
end

-- 奥术神符
function FiveCloudCustomEvent:SpawnRuneArcanePressed(e)
    local hero = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
    FiveCloudCustomEvent:SpawnRuneInFrontOfUnit(hero, DOTA_RUNE_ARCANE)
end

-- 护盾神符
function FiveCloudCustomEvent:SpawnRuneShieldPressed(e)
    local hero = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
    FiveCloudCustomEvent:SpawnRuneInFrontOfUnit(hero, DOTA_RUNE_SHIELD)
end

-- 刷神符
function FiveCloudCustomEvent:SpawnRuneInFrontOfUnit(unit, runeType)
    if unit == nil then
        return
    end

    local fDistance = 200.0
    local fMinSeparation = 50.0
    local fRingOffset = fMinSeparation + 20.0
    local vDir = unit:GetForwardVector()
    local vInitialTarget = unit:GetAbsOrigin() + vDir * fDistance
    vInitialTarget.z = GetGroundHeight(vInitialTarget, nil)
    local vTarget = vInitialTarget
    local nRemainingAttempts = 100
    local fAngle = 2 * math.pi
    local fOffset = 0.0
    local bDone = false

    local vecRunes = Entities:FindAllByClassname("dota_item_rune")
    while (not bDone and nRemainingAttempts > 0) do
        bDone = true
        for i = 1, #vecRunes do
            if (vecRunes[i]:GetAbsOrigin() - vTarget):Length() < fMinSeparation then
                bDone = false
                break
            end
        end
        if not GridNav:CanFindPath(unit:GetAbsOrigin(), vTarget) then
            bDone = false
        end
        if not bDone then
            fAngle = fAngle + 2 * math.pi / 8
            if fAngle >= 2 * math.pi then
                fOffset = fOffset + fRingOffset
                fAngle = 0
            end
            vTarget = vInitialTarget + fOffset * Vector(math.cos(fAngle), math.sin(fAngle), 0.0)
            vTarget.z = GetGroundHeight(vTarget, nil)
        end
        nRemainingAttempts = nRemainingAttempts - 1
    end

    CreateRune(vTarget, runeType)
end

-- 昼夜变换
function FiveCloudCustomEvent:DayNightCycle(e)
    if GameRules:IsDaytime() then
        GameRules:SetTimeOfDay(0.751)
    else
        GameRules:SetTimeOfDay(0.251)
    end
end

-- 暂停昼夜变换
function FiveCloudCustomEvent:PauseDayNightCycle(e)
    local mode = GameRules:GetGameModeEntity()
    if e.checked == 1 then
        mode:SetDaynightCycleDisabled(true)
    else
        mode:SetDaynightCycleDisabled(false)
    end
    CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
        name = "PauseDayNightCycle",
        data = e.checked
    })
end

-- 简易购买模式
function FiveCloudCustomEvent:EasyBuy(e)
    if GameRules:IsCheatMode() then
        SendToServerConsole("dota_easybuy " .. e.checked)
        CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
            name = "EasyBuy",
            data = e.checked
        })
    else
        FiveCloudSDK:Message("#NotIsCheatMode", e.playerid, "error")
    end
end

-- 无限技能
function FiveCloudCustomEvent:FreeSpells(e)
    if GameRules:IsCheatMode() then
        if e.checked == 1 then
            SendToServerConsole("dota_ability_debug 1")
            FiveCloudCustomEvent:RefreshStatus(e)
        else
            SendToServerConsole("dota_ability_debug 0")
        end
        CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
            name = "FreeSpells",
            data = e.checked
        })
    else
        FiveCloudSDK:Message("#NotIsCheatMode", e.playerid, "error")
    end

end

-- 快速复活
function FiveCloudCustomEvent:HeroFastRespawn(e)
    local mode = GameRules:GetGameModeEntity()
    if e.checked == 1 then
        mode:SetFixedRespawnTime(3)
    else
        mode:SetFixedRespawnTime(-1)
    end
    CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
        name = "HeroFastRespawn",
        data = e.checked
    })
end

-- 原地复活
function FiveCloudCustomEvent:HeroSituRespawn(e)
    if e.checked == 1 then
        FiveCloudConfig["HeroSituRespawnMode"] = true
    else
        FiveCloudConfig["HeroSituRespawnMode"] = false
    end
    CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
        name = "HeroSituRespawn",
        data = e.checked
    })
end

-- 禁用每秒获得金钱
function FiveCloudCustomEvent:PassiveGold(e)
    local mode = GameRules:GetGameModeEntity()
    if e.checked == 1 then
        GameRules:SetGoldPerTick(0)
    else
        GameRules:SetGoldPerTick(1)
    end
    CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
        name = "PassiveGold",
        data = e.checked
    })
end

-- 战争迷雾
function FiveCloudCustomEvent:NoFogOfWar(e)
    local mode = GameRules:GetGameModeEntity()
    if e.checked == 1 then
        mode:SetFogOfWarDisabled(true)
    else
        mode:SetFogOfWarDisabled(false)
    end
    CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
        name = "NoFogOfWar",
        data = e.checked
    })
end
