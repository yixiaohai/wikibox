-- 重置英雄
function FiveCloudCustomEvent:ResetHero(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if ent:IsHero() and ent:IsAlive() and not ent:IsClone() then
            FiveCloudCustomEvent:DoResetHero(ent)
        end
    end
    FiveCloudCustomEvent:GetAbilityList(e)
end

-- 重置英雄技能
function FiveCloudCustomEvent:DoResetHero(unit)
    PlayerResource:ReplaceHeroWithNoTransfer(unit:GetPlayerID(), PlayerResource:GetSelectedHeroName(unit:GetPlayerID()),
        PlayerResource:GetGold(unit:GetPlayerID()), 0)
    FiveCloudCustomEvent:RemoveHero(unit)
end

-- 复活英雄
function FiveCloudCustomEvent:RespawnHero(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if ent:IsHero() and not ent:IsClone() then
            if ent:IsAlive() then
                FiveCloudSDK:Message("#RespawnHeroError1", e.playerid, "error")
            else
                ent:RespawnHero(false, false)
            end
        else
            FiveCloudSDK:Message("#RespawnHeroError2", e.playerid, "error")
        end
    end
end

-- 更换英雄
function FiveCloudCustomEvent:ReplaceHero(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if ent:IsHero() and not ent:IsClone() then
            local hero = PlayerResource:ReplaceHeroWith(ent:GetPlayerID(),
                "npc_dota_hero_" .. DOTAGameManager:GetHeroNameByID(e.heroid), PlayerResource:GetGold(e.playerid), 0)
        end
    end
    FiveCloudCustomEvent:GetAbilityList(e)
end

-- 设置金钱
function FiveCloudCustomEvent:SetGold(e)
    PlayerResource:SetGold(e.playerid, e.v, false)
    PlayerResource:SetGold(e.playerid, 0, true)
end

-- 添加英雄
function FiveCloudCustomEvent:AddHero(e)
    local player = PlayerResource:GetPlayer(e.playerid)
    local heroName = "npc_dota_hero_" .. DOTAGameManager:GetHeroNameByID(e.heroid)
    local team = PlayerResource:GetTeam(e.playerid)
    local hero = player:GetAssignedHero()
    local team_target = team
    if e.isFriend == 0 then
        if team == DOTA_TEAM_GOODGUYS then
            team_target = DOTA_TEAM_BADGUYS
        end
        if team == DOTA_TEAM_BADGUYS then
            team_target = DOTA_TEAM_GOODGUYS
        end
    end

    DebugCreateUnit(player, heroName, team_target, false, function(unit)
        unit:SetControllableByPlayer(e.playerid, false)
    end)
end

-- 清空物品
function FiveCloudCustomEvent:ClearInventory(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if ent then
            for i = 0, FiveCloudConfig["heroMaxInventoryNum"] - 1 do
                local item = ent:GetItemInSlot(i)
                if item then
                    ent:RemoveItem(item)
                end
            end
        end
    end
end

-- 升一级
function FiveCloudCustomEvent:LevelUp(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if ent and ent:IsHero() then
            ent:HeroLevelUp(true)
        end
    end
end

-- 升到满级
function FiveCloudCustomEvent:MaxLevelUp(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if ent then
            HeroMaxLevel(ent)
        end
    end
end

-- 获取技能点
function FiveCloudCustomEvent:GetAbilityPoint(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if ent and ent:IsHero() then
            local points = ent:GetAbilityPoints()
            ent:SetAbilityPoints(points + 1)
        end
    end
end

-- 移除技能点
function FiveCloudCustomEvent:RemoveAbilityPoint(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if ent and ent:IsHero() then
            local points = ent:GetAbilityPoints()
            if points > 0 then
                ent:SetAbilityPoints(points - 1)
            else
                FiveCloudSDK:Message("#RemoveAbilityPointError", e.playerid, "error")
            end
        end
    end
end

-- 添加技能
function FiveCloudCustomEvent:AddAbility(e)
    Omg:AddAbility(e.playerid, e.replaceHeroid, e.abilityname)
    FiveCloudCustomEvent:GetAbilityList(e)
end

-- 删除技能
function FiveCloudCustomEvent:RemoveAbility(e)
    Omg:RemoveAbility(e.playerid, e.replaceHeroid, e.abilityname)
    FiveCloudCustomEvent:GetAbilityList(e)

end

-- 交换技能
function FiveCloudCustomEvent:SwapAbility(e)
    local hero = EntIndexToHScript(e.replaceHeroid)
    hero:SwapAbilities(e.ability1, e.ability2, true, true)
    FiveCloudCustomEvent:GetAbilityList(e)
end

function FiveCloudCustomEvent:RemoveHero(unit)
    if unit:HasAbility("monkey_king_wukongs_command") then
        local heroName = unit:GetClassname()
        local ents = Entities:FindAllByClassname(heroName)
        for k, ent in pairs(ents) do
            if ent:HasModifier("modifier_monkey_king_fur_army_soldier") then
                ent:RemoveSelf()
            end
        end
    end
    unit:Destroy()
end

