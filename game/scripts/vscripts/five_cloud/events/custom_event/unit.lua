-- 获取详细数据开启
function FiveCloudCustomEvent:GetEntInfoStart(e)
    local ent = EntIndexToHScript(e.ent)
    if ent then
        GameRules:GetGameModeEntity():SetContextThink("GetEntInfo", function()
            return FiveCloudCustomEvent:GetEntInfo(e, 0)
        end, 0)
        if e.updateServerStatus == 1 then
            CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(e.playerid), "UpdateServerStatus", {
                name = "EntInfoButton",
                data = true
            })
        end
    end
end

-- 获取详细数据关闭
function FiveCloudCustomEvent:GetEntInfoEnd(e)
    GameRules:GetGameModeEntity():SetContextThink("GetEntInfo", function()
        return FiveCloudCustomEvent:GetEntInfo()
    end, 0)
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(e.playerid), "UpdateServerStatus", {
        name = "EntInfoButton",
        data = false
    })
end

-- 获取详细数据
function FiveCloudCustomEvent:GetEntInfo(e, i)
    if e and e.ent then
        local ent = EntIndexToHScript(e.ent)
        if ent then
            local entinfo = {}
            entinfo.GetUnitName = ent:GetUnitName()
            entinfo.GetClassname = ent:GetClassname()
            entinfo.GetAbsOrigin = ent:GetAbsOrigin()
            entinfo.GetDayTimeVisionRange = ent:GetDayTimeVisionRange()
            entinfo.GetNightTimeVisionRange = ent:GetNightTimeVisionRange()
            entinfo.GetBaseAttackTime = ent:GetBaseAttackTime()
            entinfo.GetAttackSpeed = ent:GetAttackSpeed()
            entinfo.GetAttacksPerSecond = ent:GetAttacksPerSecond()
            entinfo.GetSecondsPerAttack = ent:GetSecondsPerAttack()
            entinfo.HasFlyingVision = ent:HasFlyingVision()
            entinfo.GetProjectileSpeed = ent:GetProjectileSpeed()
            entinfo.GetAttackAnimationPoint = ent:GetAttackAnimationPoint()
            entinfo.GetCastPoint = ent:GetCastPoint(true)
            entinfo.GetPaddedCollisionRadius = ent:GetPaddedCollisionRadius()
            entinfo.GetHullRadius = ent:GetHullRadius()
            entinfo.GetIdealSpeed = ent:GetIdealSpeed()
            entinfo.GetCooldownReduction = ent:GetCooldownReduction()
            entinfo.GetBaseDamageMax = ent:GetBaseDamageMax()
            entinfo.GetBaseDamageMin = ent:GetBaseDamageMin()
            entinfo.GetAverageTrueAttackDamage = ent:GetAverageTrueAttackDamage(nil)
            entinfo.GetAttackRangeBuffer = ent:GetAttackRangeBuffer()
            entinfo.Script_GetAttackRange = ent:Script_GetAttackRange()
            entinfo.GetMagicalArmorValue = ent:Script_GetMagicalArmorValue(false, nil)
            entinfo.GetPhysicalArmorValue = ent:GetPhysicalArmorValue(false)
            entinfo.GetStatusResistance = ent:GetStatusResistance()
            entinfo.GetEvasion = ent:GetEvasion()
            entinfo.GetSpellAmplification = ent:GetSpellAmplification(false)
            entinfo.GetCastRangeBonus = ent:GetCastRangeBonus()
            entinfo.GetHealth = ent:GetHealth()
            entinfo.GetMaxHealth = ent:GetMaxHealth()
            entinfo.GetMana = ent:GetMana()
            entinfo.GetMaxMana = ent:GetMaxMana()
            entinfo.GetDeathXP = ent:GetDeathXP()
            entinfo.GetGoldBounty = ent:GetGoldBounty()
            entinfo.GetAngles = ent:GetAngles()[2]
            entinfo.CanBeSeenByAnyOpposingTeam = ent:CanBeSeenByAnyOpposingTeam()

            CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(e.playerid), "UpdateEntInfo", entinfo)

        end
    end
    return i
end

-- 刷新状态
function FiveCloudCustomEvent:RefreshStatus(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if not ent:IsNull() then
            FiveCloudCustomEvent:RefreshUnit(ent)
            if ent:GetClassname() == "npc_dota_hero_meepo" and not ent:IsClone() then
                for k, clone in pairs(Entities:FindAllByClassname("npc_dota_hero_meepo")) do
                    if clone:IsClone() and clone:GetCloneSource() == ent then
                        FiveCloudCustomEvent:RefreshUnit(clone)
                    end
                end
            end
        end
    end
end

-- 刷新单位状态
function FiveCloudCustomEvent:RefreshUnit(ent)
    if ent:IsAlive() then
        ent:SetHealth(ent:GetMaxHealth())
        ent:SetMana(ent:GetMaxMana())
        FiveCloudCustomEvent:RefreshUnitCooldowns(ent)
    end
end

-- 刷新技能冷却
function FiveCloudCustomEvent:RefreshUnitCooldowns(ent)
    for i = 0, FiveCloudConfig["heroMaxInventoryNum"] do
        local item = ent:GetItemInSlot(i)
        if item then
            item:EndCooldown()
        end
    end
    local max_ability_count = ent:GetAbilityCount()
    for i = 0, max_ability_count - 1 do
        local ability = ent:GetAbilityByIndex(i)
        if ability and ability:GetLevel() > 0 then
            ability:EndCooldown()
            ability:RefreshCharges()
        end
    end
end

-- 添加傀儡
function FiveCloudCustomEvent:AddDummy(e)
    local hero = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
    local origin = hero:GetAbsOrigin() + RandomVector(150)
    local Dummy = CreateUnitByName("npc_dota_hero_target_dummy", origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
    Dummy:SetControllableByPlayer(e.playerid, false)
end

-- 创建单位
function FiveCloudCustomEvent:CreateUnit(e)
    local player = PlayerResource:GetPlayer(e.playerid)
    local unit = e.unit
    local team = PlayerResource:GetTeam(e.playerid)
    local hero = player:GetAssignedHero()
    local teamid = team
    if e.isFriend == 0 then
        if team == DOTA_TEAM_GOODGUYS then
            teamid = DOTA_TEAM_BADGUYS
        end
        if team == DOTA_TEAM_BADGUYS then
            teamid = DOTA_TEAM_GOODGUYS
        end
    end

    local unit = CreateUnitByName(unit, hero:GetAbsOrigin() + RandomVector(150), true, nil, nil, teamid)

    unit:SetControllableByPlayer(e.playerid, false)

end

-- 删除单位
function FiveCloudCustomEvent:RemoveUnit(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if (ent and not ent:IsNull() and ent ~= PlayerResource:GetSelectedHeroEntity(e.playerid)) then
            if ent:IsHero() and not ent:IsClone() and ent:GetPlayerOwner() and ent:GetPlayerOwnerID() ~= 0 then
                DisconnectClient(ent:GetPlayerID(), true)
            else
                FiveCloudCustomEvent:RemoveHero(ent)
            end
        else
            FiveCloudSDK:Message("#RemoveUnitError", e.playerid, "error")
        end
    end
end

-- 自残
function FiveCloudCustomEvent:SelfMutilation(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if ent then
            ent:SetHealth(1)
        end
    end
end

-- 移动至指定位置
function FiveCloudCustomEvent:MoveToPoint(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        local point = GetGroundPosition(Vector(e.pos.x, e.pos.y, e.pos.z), nil)
        FindClearSpaceForUnit(ent, point, false)
    end
end

-- 无敌
function FiveCloudCustomEvent:Invulnerability(e)
    local hero = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()

    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if ent then
            if e.checked == 1 then
                ent:AddNewModifier(hero, nil, "modifier_lm_take_no_damage", nil)
            else
                ent:RemoveModifierByName("modifier_lm_take_no_damage")
            end
        end
    end
end

-- 设置角度
function FiveCloudCustomEvent:SetAngle(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if ent then
            ent:Stop()
            ent:SetAngles(0, e.v, 0)
        end
    end
end

-- 获取当前技能
function FiveCloudCustomEvent:GetAbilityList(e)
    local ent = e.ent
    local unit
    if ent then
        unit = EntIndexToHScript(ent)
    else
        unit = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
    end
    local count = unit:GetAbilityCount()
    local abilityList = {}
    for i = 0, count - 1 do
        local ability = unit:GetAbilityByIndex(i)
        if ability then
            local entindex = ability:GetEntityIndex()
            table.insert(abilityList, entindex)
        end
    end
    GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("GetAbilityList"), function()
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(e.playerid), "RefreshServerAbility", {
            abilityList = abilityList
        })
    end, 0.3)
end

function FiveCloudCustomEvent:EditKv(e)

    local unit = EntIndexToHScript(e.ent)
    local title = e.data.five_cloud_title
    local modifier = unit:FindModifierByName("modifier_edit_kv")
    if not modifier then
        modifier = unit:AddNewModifier(unit, nil, "modifier_edit_kv", {})
    end

    local five_cloud_data = {}

    for k, v in pairs(e.data) do
        if k ~= "five_cloud_title" then
            five_cloud_data[k] = tonumber(v)
        end
    end

    local ability = unit:FindAbilityByName(title)
    if ability then
        local modifier_name = ability:GetIntrinsicModifierName()
        local modifier = unit:FindModifierByName(modifier_name)
        if modifier then
            local level = ability:GetLevel()
            ability:SetLevel(0)
            modifier:Destroy()
            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("collectgarbage"), function()
                ability:SetLevel(level)
                return nil
            end, 0)
        end
    end

    CustomNetTables:SetTableValue("edit_kv", title.."_"..tostring(e.ent), five_cloud_data)
end
