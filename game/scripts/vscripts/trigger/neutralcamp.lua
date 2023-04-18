function OnStartTouch(e)
    local unit = e.activator
    local trigger = e.caller

    local triggerName = trigger:GetName()
    local targetName = string.gsub(triggerName, "custemTrigger", "regionEntity")

    if CheckForNeutralcamp(unit) then
        local target = Entities:FindByName(null, targetName)
        local num = AddUnitToNeutralcampList(trigger)
        -- FiveCloudSDK:Print(num, "OnStartTouch")
        if target and num == 1 then
            target:SetRenderColor(255, 0, 0)
        end

    end
end

function OnEndTouch(e)
    local unit = e.activator
    local trigger = e.caller
    local triggerName = trigger:GetName()
    local targetName = string.gsub(triggerName, "custemTrigger", "regionEntity")
    local target = Entities:FindByName(null, targetName)
    local num

    if CheckForNeutralcamp(unit) then
        num = RemoveUnitToNeutralcampList(trigger)
        -- FiveCloudSDK:Print(num, "OnEndTouch")
        if target and num == 0 then
            target:SetRenderColor(100, 149, 237)
        end
    end

end

function CheckForNeutralcamp(unit)
    local result = true

    if unit == nil then
        return true
    end

    local unitName = unit:GetName()

    -- FiveCloudSDK:Print(unitName, "野怪检测框GetName")
    -- FiveCloudSDK:Print(unit:GetClassname(), "野怪检测框GetClassname")

    local fiterUnitName = {'npc_dota_courier', -- 信使
    'npc_dota_beastmaster_hawk', -- 兽王战鹰
    'npc_dota_techies_land_mine', -- 炸弹 地雷
    'npc_dota_elder_titan_ancestral_spirit', -- 大牛魂
    'npc_dota_broodmother_web', -- 蜘蛛网子
    'npc_dota_templar_assassin_psionic_trap', -- TA陷阱
    'npc_dota_clinkz_skeleton_archer', -- 克林克兹骷髅弓箭手
    -- 'npc_dota_wraith_king_skeleton_warrior', -- 骷髅王骷髅兵
    'npc_dota_wisp_spirit', -- 小精灵幽魂
    'dota_death_prophet_exorcism_spirit', -- 死亡先知大招鬼魂
    'dota_item_drop', -- 地上的物品
    'npc_dota_base', -- 发条照明火箭等
    'npc_dota_earth_spirit_stone', -- 土猫石头
    'npc_dota_treant_eyes', -- 树眼
    'npc_dota_base_additive', -- 老奶奶大招等
    'npc_dota_thinker', 'neutralcamp_good_1_regionEntity', 'neutralcamp_good_2_regionEntity',
                           'neutralcamp_good_3_regionEntity', 'neutralcamp_good_4_regionEntity',
                           'neutralcamp_good_5_regionEntity', -- 'neutralcamp_good_6_regionEntity', 
    'neutralcamp_good_7_regionEntity', 'neutralcamp_good_8_regionEntity', 'neutralcamp_good_9_regionEntity',
                           'neutralcamp_evil_1_regionEntity', 'neutralcamp_evil_2_regionEntity',
                           'neutralcamp_evil_3_regionEntity', 'neutralcamp_evil_4_regionEntity',
                           'neutralcamp_evil_5_regionEntity', 'neutralcamp_evil_6_regionEntity',
    -- 'neutralcamp_evil_7_regionEntity',
                           'neutralcamp_evil_8_regionEntity', 'neutralcamp_evil_9_regionEntity'}

    for i = 1, #fiterUnitName do
        if fiterUnitName[i] == unitName then
            result = false
        end
    end
    -- FiveCloudSDK:Print(result, "result1")

    if unitName == 'npc_dota_hero_monkey_king' then
        local modifier = unit:FindModifierByName("modifier_monkey_king_fur_army_soldier")
        if modifier then
            result = false
        end
    end
    -- FiveCloudSDK:Print(result, "result2")

    if unitName == '' then
        local unitClassName = unit:GetClassname()
        if unitClassName == 'npc_dota_thinker' or unitClassName == 'npc_dota_base' or unitClassName == 'dota_item_drop' or
            unitClassName == 'dota_death_prophet_exorcism_spirit' then
            result = false
        end
    end
    -- FiveCloudSDK:Print(result, "result3")

    if unitName == 'npc_dota_creep_neutral' then
        local unitKvName = unit:GetUnitName()
        -- FiveCloudSDK:Print(unitKvName, "野怪检测框GetUnitName")
        if unitKvName == 'npc_dota_wraith_king_skeleton_warrior' then
            result = false
        end
    end
    -- FiveCloudSDK:Print(result, "result4")

    if unitName == 'npc_dota_base_additive' then
        local unitKvName = unit:GetUnitName()
        -- FiveCloudSDK:Print(unitKvName, "野怪检测框GetUnitName")
        if unitKvName == 'npc_dota_pugna_nether_ward_1' or unitKvName == 'npc_dota_pugna_nether_ward_2' or unitKvName ==
            'npc_dota_pugna_nether_ward_3' or unitKvName == 'npc_dota_pugna_nether_ward_4' or unitKvName ==
            'npc_dota_item_wraith_pact_totem' then
            result = true
        end
    end
    -- FiveCloudSDK:Print(result, "result5")

    return result

end

function AddUnitToNeutralcampList(trigger)
    if trigger == nil then
        return nil
    end
    if trigger.neutralcampList == nil then
        trigger.neutralcampList = 0
    end

    trigger.neutralcampList = trigger.neutralcampList + 1

    return trigger.neutralcampList
end

function RemoveUnitToNeutralcampList(trigger)
    if trigger == nil then
        return nil
    end
    if trigger.neutralcampList == nil then
        return nil
    end

    trigger.neutralcampList = trigger.neutralcampList - 1

    return trigger.neutralcampList
end

