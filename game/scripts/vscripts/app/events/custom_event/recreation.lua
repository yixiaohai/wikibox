function AppEvent:RecreationInit()
    self.HideSkillStatus = false
    self.kunnkaX = false

    self.invis = 2
    self.blink = 2
    self.delay = 1

    self.HideSkillList = {}

    self.HideSkillList[1] = {}

    table.insert(self.HideSkillList[1], {"legion_commander", 1})
    self.HideSkillList[1]["legion_commander"] = {"legion_commander_duel"}

    table.insert(self.HideSkillList[1], {"skeleton_king", 1})
    self.HideSkillList[1]["skeleton_king"] = {"skeleton_king_hellfire_blast"}

    table.insert(self.HideSkillList[1], {"centaur", 1})
    self.HideSkillList[1]["centaur"] = {"centaur_hoof_stomp"}

    table.insert(self.HideSkillList[1], {"tiny", 1})
    self.HideSkillList[1]["tiny"] = {"tiny_avalanche"}

    table.insert(self.HideSkillList[1], {"axe", 1})
    self.HideSkillList[1]["axe"] = {"axe_berserkers_call"}

    table.insert(self.HideSkillList[1], {"slardar", 1})
    self.HideSkillList[1]["slardar"] = {"slardar_slithereen_crush"}

    table.insert(self.HideSkillList[1], {"sven", 1})
    self.HideSkillList[1]["sven"] = {"sven_storm_bolt"}

    table.insert(self.HideSkillList[1], {"sand_king", 1})
    self.HideSkillList[1]["sand_king"] = {"sandking_burrowstrike"}

    table.insert(self.HideSkillList[1], {"tidehunter", 1})
    self.HideSkillList[1]["tidehunter"] = {"tidehunter_ravage"}

    table.insert(self.HideSkillList[1], {"huskar", 1})
    self.HideSkillList[1]["huskar"] = {"huskar_life_break"}

    table.insert(self.HideSkillList[1], {"magnataur", 1})
    self.HideSkillList[1]["magnataur"] = {"magnataur_reverse_polarity"}

    table.insert(self.HideSkillList[1], {"riki", 1})
    self.HideSkillList[1]["riki"] = {"riki_poison_dart"}

    table.insert(self.HideSkillList[1], {"nyx_assassin", 1})
    self.HideSkillList[1]["nyx_assassin"] = {"nyx_assassin_impale"}

    table.insert(self.HideSkillList[1], {"dazzle", 1})
    self.HideSkillList[1]["dazzle"] = {"dazzle_poison_touch"}

    table.insert(self.HideSkillList[1], {"lina", 1})
    self.HideSkillList[1]["lina"] = {"lina_light_strike_array"}

    table.insert(self.HideSkillList[1], {"lion", 1})
    self.HideSkillList[1]["lion"] = {"lion_impale"}

    table.insert(self.HideSkillList[1], {"windrunner", 1})
    self.HideSkillList[1]["windrunner"] = {"windrunner_shackleshot"}

    table.insert(self.HideSkillList[1], {"vengefulspirit", 1})
    self.HideSkillList[1]["vengefulspirit"] = {"vengefulspirit_magic_missile"}

    table.insert(self.HideSkillList[1], {"ogre_magi", 1})
    self.HideSkillList[1]["ogre_magi"] = {"ogre_magi_fireblast", "ogre_magi_unrefined_fireblast"}

    table.insert(self.HideSkillList[1], {"tusk", 1})
    self.HideSkillList[1]["tusk"] = {"tusk_walrus_punch", "tusk_walrus_kick"}

    table.insert(self.HideSkillList[1], {"pudge", 1})
    self.HideSkillList[1]["pudge"] = {"pudge_dismember"}

    table.insert(self.HideSkillList[1], {"disruptor", 1})
    self.HideSkillList[1]["disruptor"] = {"disruptor_glimpse"}

    self.HideSkillList[2] = {}
    table.insert(self.HideSkillList[2], {"earth_spirit", 1})
    table.insert(self.HideSkillList[2], {"kunkka", 1})
    table.insert(self.HideSkillList[2], {"chaos_knight", 1})
    table.insert(self.HideSkillList[2], {"alchemist", 1})
    table.insert(self.HideSkillList[2], {"primal_beast", 1})
    table.insert(self.HideSkillList[2], {"mars", 1})
    table.insert(self.HideSkillList[2], {"dragon_knight", 1})
    table.insert(self.HideSkillList[2], {"hoodwink", 1})
    table.insert(self.HideSkillList[2], {"faceless_void", 1})
    table.insert(self.HideSkillList[2], {"earthshaker", 1})
end

function AppEvent:HideSkillOption(e)
    FiveCloudSDK:Print(e)
    for i = 1, #AppEvent.HideSkillList[1] do
        local heroData = AppEvent.HideSkillList[1][i]
        local heroName = AppEvent.HideSkillList[1][i][1]
        if e.data[heroName] then
            AppEvent.HideSkillList[1][i][2] = e.data[heroName]
        end
    end
    for i = 1, #AppEvent.HideSkillList[2] do
        local heroData = AppEvent.HideSkillList[2][i]
        local heroName = AppEvent.HideSkillList[2][i][1]
        if e.data[heroName] then
            AppEvent.HideSkillList[2][i][2] = e.data[heroName]
        end
    end
    AppEvent.invis = e.invis
    AppEvent.blink = e.blink
    AppEvent.delay = e.delay
end

function AppEvent:HideSkill(e)
    if e.checked == 1 then
        AppEvent.HideSkillStatus = true
        local hero = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
        if not hero:HasItemInInventory("item_blink_happy") then
            hero:AddItemByName("item_blink_happy")
        end
        if not hero:HasItemInInventory("item_manta_happy") then
            hero:AddItemByName("item_manta_happy")
        end
        if not hero:HasItemInInventory("item_cyclone_happy") then
            hero:AddItemByName("item_cyclone_happy")
        end
        if not hero:HasItemInInventory("item_sheepstick_happy") then
            hero:AddItemByName("item_sheepstick_happy")
        end
        if not hero:HasItemInInventory("item_black_king_bar_happy") then
            hero:AddItemByName("item_black_king_bar_happy")
        end

        AppEvent:CreateHideSkillHero(hero)
    else
        AppEvent.HideSkillStatus = false
    end
end

function AppEvent:CreateHideSkillHero(hero)
    AppEvent.kunnkaX = false
    local heroType = RandomInt(1, 2)
    local point = hero:GetAbsOrigin() + RandomVector(3000)
    if point[1] > 6000 then
        point[1] = 6000
    end
    if point[1] < -6000 then
        point[1] = -6000
    end
    if point[2] > 6000 then
        point[2] = 6000
    end
    if point[2] < -6000 then
        point[2] = -6000
    end
    if point[3] < 0 then
        point[3] = 0
    end
    local heroList = #self.HideSkillList[heroType]
    local heroNum = RandomInt(1, heroList)
    local HideSkillHero = self.HideSkillList[heroType][heroNum]
    local team = hero:GetTeam()
    local teamid = team
    if team == DOTA_TEAM_GOODGUYS then
        teamid = DOTA_TEAM_BADGUYS
    end
    if team == DOTA_TEAM_BADGUYS then
        teamid = DOTA_TEAM_GOODGUYS
    end
    if HideSkillHero[2] == 1 then
        local heroName = HideSkillHero[1]
        local unit = CreateUnitByName("npc_dota_hero_" .. heroName, point, true, nil, nil, teamid)
        FindClearSpaceForUnit(unit, point, true)
        local item_blink_name = "item_blink"
        if AppEvent.blink == 1 then
            item_blink_name = "item_arcane_blink"
        end
        if AppEvent.blink == 2 then
            if RandomInt(1, 2) == 1 then
                item_blink_name = "item_arcane_blink"
            end
        end
        local item_blink = CreateItem(item_blink_name, unit, unit)
        unit:AddItem(item_blink)
        unit:AddItemByName("item_ultimate_scepter")
        unit:AddItemByName("item_aghanims_shard")
        unit:AddItemByName("item_giants_ring")
        unit:SetModelScale(0.67)

        unit:AddNewModifier(unit, nil, "modifier_rune_haste", {})
        if AppEvent.invis == 0 then
            unit:AddNewModifier(unit, nil, "modifier_rune_invis", {})
        end
        if AppEvent.invis == 2 then
            if RandomInt(1, 2) == 1 then
                unit:AddNewModifier(unit, nil, "modifier_rune_invis", {})
            end
        end
        if heroType == 1 then
            local abilityList = AppEvent.HideSkillList[1][heroName]
            local abilityNum = RandomInt(1, #abilityList)
            local ability = unit:FindAbilityByName(abilityList[abilityNum])
            ability:SetLevel(1)

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("CreateHideSkillHero"), function()
                return AppEvent:HideSkillHeroThink(hero, unit, item_blink, ability)
            end, 0)

        end
        if heroType == 2 then
            AppEvent:SingleHideSkillHero(hero, unit, item_blink)
        end
    else
        AppEvent:CreateHideSkillHero(hero)
    end
end

function AppEvent:HideSkillHeroThink(hero, unit, item_blink, ability)
    if AppEvent.HideSkillStatus then
        local heroAbsOrigin = hero:GetAbsOrigin()
        local unitAbsOrigin = unit:GetAbsOrigin()
        local length2d = (heroAbsOrigin - unitAbsOrigin):Length2D()
        local GetCastRange = ability:GetCastRange()
        local GetBehavior = ability:GetBehavior()
        local blinkRangeMax = 1200
        if GetCastRange > 240 then
            blinkRangeMax = GetCastRange + 960
        end
        local blinkRange = RandomInt(1025, blinkRangeMax)
        if length2d < blinkRange then
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                Position = heroAbsOrigin,
                AbilityIndex = item_blink:entindex(),
                Queue = 0
            })
            if bit.band(GetBehavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
                    AbilityIndex = ability:entindex(),
                    TargetIndex = hero:entindex(),
                    Queue = 1
                })
            end
            if bit.band(GetBehavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
                    AbilityIndex = ability:entindex(),
                    Queue = 1
                })
            end
            if bit.band(GetBehavior, DOTA_ABILITY_BEHAVIOR_POINT) == DOTA_ABILITY_BEHAVIOR_POINT then
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    AbilityIndex = ability:entindex(),
                    Position = heroAbsOrigin,
                    Queue = 1
                })
            end

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                if unit then
                    unit:RemoveSelf()
                end
            end, 3)

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                AppEvent:CreateHideSkillHero(hero)
            end, AppEvent:GetDelay())

            return false
        else
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                Position = heroAbsOrigin,
                Queue = false
            })
            return FrameTime()
        end
    else
        unit:RemoveSelf()
        return false
    end
end

-- 个别英雄设置
function AppEvent:SingleHideSkillHero(hero, unit, item_blink)
    if unit:GetName() == "npc_dota_hero_earth_spirit" then
        local ability = unit:FindAbilityByName("earth_spirit_rolling_boulder")
        ability:SetLevel(1)
        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("RattletrapThink"), function()
            return AppEvent:EarthSpiritThink(hero, unit, ability)
        end, 0)
    end
    if unit:GetName() == "npc_dota_hero_kunkka" then
        local ability1 = unit:FindAbilityByName("kunkka_x_marks_the_spot")
        ability1:SetLevel(4)
        local ability2 = unit:FindAbilityByName("kunkka_return")
        local ability3 = unit:FindAbilityByName("kunkka_torrent")
        ability3:SetLevel(1)
        local ability4 = unit:FindAbilityByName("kunkka_ghostship")
        ability4:SetLevel(1)
        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("KunkkaThink"), function()
            return AppEvent:KunkkaThink(hero, unit, ability1, ability2, ability3, ability4)
        end, 0)
    end
    if unit:GetName() == "npc_dota_hero_chaos_knight" then
        local ability1 = unit:FindAbilityByName("chaos_knight_chaos_bolt")
        ability1:SetLevel(1)
        local ability2 = unit:FindAbilityByName("chaos_knight_reality_rift")
        ability2:SetLevel(4)
        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("ChaosKnightThink"), function()
            return AppEvent:ChaosKnightThink(hero, unit, item_blink, ability1, ability2)
        end, 0)
    end
    if unit:GetName() == "npc_dota_hero_alchemist" then
        local ability1 = unit:FindAbilityByName("alchemist_unstable_concoction")
        ability1:SetLevel(1)
        local ability2 = unit:FindAbilityByName("alchemist_unstable_concoction_throw")
        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("AlchemistThink"), function()
            return AppEvent:AlchemistThink(hero, unit, item_blink, ability1, ability2)
        end, 0)
    end
    if unit:GetName() == "npc_dota_hero_primal_beast" then
        local ability1 = unit:FindAbilityByName("primal_beast_onslaught")
        ability1:SetLevel(1)
        local ability2 = unit:FindAbilityByName("primal_beast_rock_throw")
        local ability3 = unit:FindAbilityByName("primal_beast_pulverize")
        ability3:SetLevel(1)
        local randomInt = RandomInt(1, 3)
        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("PrimalBeastThink"), function()
            return AppEvent:PrimalBeastThink(hero, unit, item_blink, ability1, ability2, ability3, randomInt)
        end, 0)
    end
    if unit:GetName() == "npc_dota_hero_mars" then
        local ability1 = unit:FindAbilityByName("mars_spear")
        ability1:SetLevel(4)
        local ability2 = unit:FindAbilityByName("mars_arena_of_blood")
        ability2:SetLevel(1)
        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("MarsThink"), function()
            return AppEvent:MarsThink(hero, unit, item_blink, ability1, ability2)
        end, 0)
    end
    if unit:GetName() == "npc_dota_hero_dragon_knight" then
        local ability1 = unit:FindAbilityByName("dragon_knight_dragon_tail")
        ability1:SetLevel(1)
        local ability2 = unit:FindAbilityByName("dragon_knight_elder_dragon_form")
        ability2:SetLevel(1)
        local randomInt = RandomInt(1, 2)
        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("DragonKnightThink"), function()
            return AppEvent:DragonKnightThink(hero, unit, item_blink, ability1, ability2, randomInt)
        end, 0)
    end

    if unit:GetName() == "npc_dota_hero_hoodwink" then
        local ability1 = unit:FindAbilityByName("hoodwink_acorn_shot")
        ability1:SetLevel(4)
        local ability2 = unit:FindAbilityByName("hoodwink_bushwhack")
        ability2:SetLevel(4)
        local ability3 = unit:FindAbilityByName("hoodwink_sharpshooter")
        ability3:SetLevel(3)
        local ability4 = unit:FindAbilityByName("hoodwink_sharpshooter_release")
        local ability5 = unit:FindAbilityByName("hoodwink_hunters_boomerang")
        local item_veil_of_discord = CreateItem("item_veil_of_discord", unit, unit)
        unit:AddItem(item_veil_of_discord)
        local item_ethereal_blade = CreateItem("item_ethereal_blade", unit, unit)
        unit:AddItem(item_ethereal_blade)
        local item_dagon = CreateItem("item_dagon_5", unit, unit)
        unit:AddItem(item_dagon)
        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HoodwinkThink"), function()
            return AppEvent:HoodwinkThink(hero, unit, item_blink, item_veil_of_discord, item_ethereal_blade, item_dagon,
                ability1, ability2, ability3, ability4, ability5)
        end, 0)
    end

    if unit:GetName() == "npc_dota_hero_faceless_void" then
        local ability1 = unit:FindAbilityByName("faceless_void_time_walk")
        ability1:SetLevel(4)
        local ability2 = unit:FindAbilityByName("faceless_void_chronosphere")
        ability2:SetLevel(1)
        local randomint = RandomInt(1, 2)
        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("FacelessVoidThink"), function()
            return AppEvent:FacelessVoidThink(hero, unit, item_blink, ability1, ability2, randomint)
        end, 0)
    end

    if unit:GetName() == "npc_dota_hero_earthshaker" then
        local ability1 = unit:FindAbilityByName("earthshaker_aftershock")
        ability1:SetLevel(4)
        local abilityList = {"earthshaker_fissure", "earthshaker_enchant_totem", "earthshaker_echo_slam"}
        local abilityNum = RandomInt(1, #abilityList)
        local ability = unit:FindAbilityByName(abilityList[abilityNum])
        ability:SetLevel(1)

        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("CreateHideSkillHero"), function()
            return AppEvent:HideSkillHeroThink(hero, unit, item_blink, ability)
        end, 0)
    end

end

function AppEvent:FacelessVoidThink(hero, unit, item_blink, ability1, ability2, randomint)
    if AppEvent.HideSkillStatus then
        local heroAbsOrigin = hero:GetAbsOrigin()
        local unitAbsOrigin = unit:GetAbsOrigin()
        local length2d = (heroAbsOrigin - unitAbsOrigin):Length2D()
        local GetCastRange = ability2:GetCastRange()
        local blinkRangeMax = 1200
        if GetCastRange > 240 then
            blinkRangeMax = GetCastRange + 960
        end
        local blinkRange = RandomInt(1025, blinkRangeMax)
        if length2d < blinkRange then
            if randomint == 1 then
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    Position = heroAbsOrigin,
                    AbilityIndex = item_blink:entindex(),
                    Queue = false
                })

            else
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    Position = heroAbsOrigin,
                    AbilityIndex = ability1:entindex(),
                    Queue = false
                })

            end
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                Position = heroAbsOrigin,
                AbilityIndex = ability2:entindex(),
                Queue = true
            })

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                if unit ~= nil then
                    unit:RemoveSelf()
                end
            end, 6)

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                AppEvent:CreateHideSkillHero(hero)
            end, AppEvent:GetDelay() + 3)

            return false
        else
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                Position = heroAbsOrigin,
                Queue = false
            })
            return 0.1
        end
    end
end

function AppEvent:HoodwinkThink(hero, unit, item_blink, item_veil_of_discord, item_ethereal_blade, item_dagon, ability1,
    ability2, ability3, ability4, ability5)
    if AppEvent.HideSkillStatus then
        local heroAbsOrigin = hero:GetAbsOrigin()
        local unitAbsOrigin = unit:GetAbsOrigin()
        local length2d = (heroAbsOrigin - unitAbsOrigin):Length2D()
        local GetCastRange = ability1:GetCastRange()
        local blinkRange = 1760
        if length2d < blinkRange then

            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                Position = heroAbsOrigin,
                AbilityIndex = item_blink:entindex(),
                Queue = false
            })

            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                Position = heroAbsOrigin,
                AbilityIndex = ability1:entindex(),
                Queue = true
            })

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_STOP,
                    Queue = 0
                })
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    Position = heroAbsOrigin,
                    AbilityIndex = ability2:entindex(),
                    Queue = 1
                })
            end, 0.4)

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_STOP,
                    Queue = 0
                })
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    Position = heroAbsOrigin,
                    AbilityIndex = ability3:entindex(),
                    Queue = true
                })
            end, 0.8)

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    Position = heroAbsOrigin,
                    AbilityIndex = item_veil_of_discord:entindex(),
                    Queue = false
                })
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
                    TargetIndex = hero:entindex(),
                    AbilityIndex = item_ethereal_blade:entindex(),
                    Queue = 1
                })
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    Position = heroAbsOrigin,
                    AbilityIndex = ability5:entindex(),
                    Queue = 1
                })
            end, 0.81)

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
                    TargetIndex = hero:entindex(),
                    AbilityIndex = item_dagon:entindex(),
                    Queue = true
                })
            end, 1)

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_STOP,
                    Queue = 0
                })
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
                    AbilityIndex = ability4:entindex(),
                    Queue = 1
                })
            end, 3.2)

            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                Position = heroAbsOrigin,
                AbilityIndex = ability2:entindex(),
                Queue = 1
            })

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                if unit ~= nil then
                    unit:RemoveSelf()
                end
            end, 6)

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                AppEvent:CreateHideSkillHero(hero)
            end, AppEvent:GetDelay() + 3)

            return false
        else
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                Position = heroAbsOrigin,
                Queue = false
            })
            return 0.1
        end
    end
end

function AppEvent:DragonKnightThink(hero, unit, item_blink, ability1, ability2, randomInt)
    if AppEvent.HideSkillStatus then
        local heroAbsOrigin = hero:GetAbsOrigin()
        local unitAbsOrigin = unit:GetAbsOrigin()
        local length2d = (heroAbsOrigin - unitAbsOrigin):Length2D()
        local blinkRange = RandomInt(1025, 1200)

        if randomInt == 1 then
            blinkRange = RandomInt(1025, 1360)
            if ability2:IsCooldownReady() then
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
                    AbilityIndex = ability2:entindex(),
                    Queue = 0
                })
            end
        end

        if length2d < blinkRange then

            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                Position = heroAbsOrigin,
                AbilityIndex = item_blink:entindex(),
                Queue = 0
            })

            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
                AbilityIndex = ability1:entindex(),
                TargetIndex = hero:entindex(),
                Queue = 1
            })

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                if unit ~= nil then
                    unit:RemoveSelf()
                end
            end, 3)

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                AppEvent:CreateHideSkillHero(hero)
            end, AppEvent:GetDelay())

            return false
        else
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                Position = heroAbsOrigin,
                Queue = false
            })
            return 0.1
        end
    end
end

function AppEvent:MarsThink(hero, unit, item_blink, ability1, ability2)
    if AppEvent.HideSkillStatus then
        local heroAbsOrigin = hero:GetAbsOrigin()
        local unitAbsOrigin = unit:GetAbsOrigin()
        local length2d = (heroAbsOrigin - unitAbsOrigin):Length2D()
        local GetCastRange = ability2:GetCastRange()
        local blinkRange = RandomInt(1360, 1910)

        if length2d < blinkRange then

            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                Position = heroAbsOrigin,
                AbilityIndex = item_blink:entindex(),
                Queue = 0
            })

            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                Position = heroAbsOrigin,
                AbilityIndex = ability1:entindex(),
                Queue = 1
            })

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_STOP,
                    Queue = 0
                })
                local AbilityOrigin = RotatePosition(unit:GetAbsOrigin(), unit:GetAngles(),
                    unit:GetAbsOrigin() + Vector(400, 0, 0))
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    Position = AbilityOrigin,
                    AbilityIndex = ability2:entindex(),
                    Queue = 1
                })
            end, 0.39)

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                if unit ~= nil then
                    unit:RemoveSelf()
                end
            end, 3)

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                AppEvent:CreateHideSkillHero(hero)
            end, AppEvent:GetDelay() + 2)

            return false
        else
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                Position = heroAbsOrigin,
                Queue = false
            })
            return 0.1
        end
    end
end

function AppEvent:PrimalBeastThink(hero, unit, item_blink, ability1, ability2, ability3, randomInt)
    if AppEvent.HideSkillStatus then
        local heroAbsOrigin = hero:GetAbsOrigin()
        local unitAbsOrigin = unit:GetAbsOrigin()
        local length2d = (heroAbsOrigin - unitAbsOrigin):Length2D()
        local GetCastRange2 = ability2:GetCastRange()
        local GetCastRange3 = ability3:GetCastRange()
        local blinkRangeMax = 1200
        if GetCastRange3 > 240 then
            blinkRangeMax = GetCastRange3 + 960
        end
        local blinkRange = RandomInt(1025, blinkRangeMax)

        if randomInt == 1 then
            if length2d < 2000 then
                if length2d < 100 then
                    GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                        if unit ~= nil then
                            unit:RemoveSelf()
                        end
                    end, 2)

                    GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                        AppEvent:CreateHideSkillHero(hero)
                    end, AppEvent:GetDelay())

                    return false
                end
                if ability1:IsCooldownReady() then
                    ExecuteOrderFromTable({
                        UnitIndex = unit:entindex(),
                        OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                        Position = heroAbsOrigin,
                        AbilityIndex = ability1:entindex(),
                        Queue = 0
                    })
                    return 0.1
                else
                    ExecuteOrderFromTable({
                        UnitIndex = unit:entindex(),
                        OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                        Position = heroAbsOrigin,
                        Queue = false
                    })
                    return 0.1
                end
            end
        end
        if randomInt == 2 then
            if length2d < GetCastRange2 and length2d > 550 then
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    Position = heroAbsOrigin,
                    AbilityIndex = ability2:entindex(),
                    Queue = 0
                })

                GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                    if unit ~= nil then
                        unit:RemoveSelf()
                    end
                end, 3)

                GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                    AppEvent:CreateHideSkillHero(hero)
                end, AppEvent:GetDelay())

                return false
            end
        end
        if randomInt == 3 then
            if length2d < blinkRange then
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    Position = heroAbsOrigin,
                    AbilityIndex = item_blink:entindex(),
                    Queue = 0
                })

                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
                    AbilityIndex = ability3:entindex(),
                    TargetIndex = hero:entindex(),
                    Queue = 1
                })

                GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                    if unit ~= nil then
                        unit:RemoveSelf()
                    end
                end, 3)

                GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                    AppEvent:CreateHideSkillHero(hero)
                end, AppEvent:GetDelay())

                return false
            end
        end

        ExecuteOrderFromTable({
            UnitIndex = unit:entindex(),
            OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
            Position = heroAbsOrigin,
            Queue = false
        })
        return 0.1
    end
end

function AppEvent:AlchemistThink(hero, unit, item_blink, ability1, ability2)
    if AppEvent.HideSkillStatus then
        local heroAbsOrigin = hero:GetAbsOrigin()
        local unitAbsOrigin = unit:GetAbsOrigin()
        local length2d = (heroAbsOrigin - unitAbsOrigin):Length2D()
        local GetCastRange = ability2:GetCastRange()
        local blinkRangeMax = 1200
        if GetCastRange > 240 then
            blinkRangeMax = GetCastRange + 960
        end
        local blinkRange = RandomInt(1025, blinkRangeMax)

        if ability1:IsCooldownReady() and not ability1:IsHidden() then
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
                AbilityIndex = ability1:entindex(),
                Queue = 0
            })
        else
            ability1:EndCooldown()
        end

        if length2d < blinkRange then

            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                Position = heroAbsOrigin,
                AbilityIndex = item_blink:entindex(),
                Queue = 0
            })

            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
                AbilityIndex = ability2:entindex(),
                TargetIndex = hero:entindex(),
                Queue = 1
            })

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                if unit ~= nil then
                    unit:RemoveSelf()
                end
            end, 3)

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                AppEvent:CreateHideSkillHero(hero)
            end, AppEvent:GetDelay())

            return false
        else
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                Position = heroAbsOrigin,
                Queue = false
            })
            return 0.1
        end
    end
end

function AppEvent:ChaosKnightThink(hero, unit, item_blink, ability1, ability2)
    if AppEvent.HideSkillStatus then
        local heroAbsOrigin = hero:GetAbsOrigin()
        local unitAbsOrigin = unit:GetAbsOrigin()
        local length2d = (heroAbsOrigin - unitAbsOrigin):Length2D()
        local GetCastRange = ability1:GetCastRange()
        local blinkRangeMax = 1200
        if GetCastRange > 240 then
            blinkRangeMax = GetCastRange + 960
        end
        local blinkRange = RandomInt(1025, blinkRangeMax)
        if length2d < blinkRange then

            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                Position = heroAbsOrigin,
                AbilityIndex = item_blink:entindex(),
                Queue = 0
            })

            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
                AbilityIndex = ability1:entindex(),
                TargetIndex = hero:entindex(),
                Queue = 1
            })

            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
                AbilityIndex = ability2:entindex(),
                TargetIndex = hero:entindex(),
                Queue = 1
            })

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                if unit ~= nil then
                    unit:RemoveSelf()
                end
            end, 3)

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                AppEvent:CreateHideSkillHero(hero)
            end, AppEvent:GetDelay())

            return false
        else
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                Position = heroAbsOrigin,
                Queue = false
            })
            return 0.1
        end
    end
end

function AppEvent:KunkkaThink(hero, unit, ability1, ability2, ability3, ability4)
    if AppEvent.HideSkillStatus then
        local heroAbsOrigin = hero:GetAbsOrigin()
        local unitAbsOrigin = unit:GetAbsOrigin()
        local length2d = (heroAbsOrigin - unitAbsOrigin):Length2D()
        local blinkRange = ability1:GetCastRange()

        if not self.kunnkaX then
            if length2d < blinkRange then
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
                    AbilityIndex = ability1:entindex(),
                    TargetIndex = hero:entindex(),
                    Queue = 0
                })
                self.kunnkaX = true
                return 0.4
            else
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                    Position = heroAbsOrigin,
                    Queue = false
                })
                return 0.1
            end
        else
            if RandomInt(1, 2) == 1 then
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    Position = heroAbsOrigin,
                    AbilityIndex = ability4:entindex(),
                    Queue = 0
                })

                GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                    ExecuteOrderFromTable({
                        UnitIndex = unit:entindex(),
                        OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
                        AbilityIndex = ability2:entindex(),
                        Queue = 0
                    })
                end, 3)

                GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                    ExecuteOrderFromTable({
                        UnitIndex = unit:entindex(),
                        OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                        Position = heroAbsOrigin,
                        AbilityIndex = ability3:entindex(),
                        Queue = 0
                    })
                end, 2.6)

            else
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    Position = heroAbsOrigin,
                    AbilityIndex = ability3:entindex(),
                    Queue = 0
                })

                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    Position = heroAbsOrigin,
                    AbilityIndex = ability4:entindex(),
                    Queue = 1
                })

                GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                    ExecuteOrderFromTable({
                        UnitIndex = unit:entindex(),
                        OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
                        AbilityIndex = ability2:entindex(),
                        Queue = 0
                    })
                end, 1.6)
            end

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                if unit ~= nil then
                    unit:RemoveSelf()
                end
            end, 5)

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                AppEvent:CreateHideSkillHero(hero)
            end, AppEvent:GetDelay() + 2)

            return false
        end
    else
        unit:RemoveSelf()
        return false
    end
end

function AppEvent:EarthSpiritThink(hero, unit, ability)
    if AppEvent.HideSkillStatus then
        local heroAbsOrigin = hero:GetAbsOrigin()
        local unitAbsOrigin = unit:GetAbsOrigin()
        local length2d = (heroAbsOrigin - unitAbsOrigin):Length2D()
        local blinkRange = RandomInt(1200, 1500)
        if length2d < blinkRange then
            local ability2 = unit:FindAbilityByName("earth_spirit_stone_caller")
            local stoneOrigin = RotatePosition(unitAbsOrigin, unit:GetAngles(), unitAbsOrigin + Vector(200, 0, 0))
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                AbilityIndex = ability:entindex(),
                Position = heroAbsOrigin,
                Queue = 0
            })

            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                AbilityIndex = ability2:entindex(),
                Position = stoneOrigin,
                Queue = 1
            })

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                if unit ~= nil then
                    unit:RemoveSelf()
                end
            end, 3)

            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HideSkillHeroThink"), function()
                AppEvent:CreateHideSkillHero(hero)
            end, AppEvent:GetDelay())

            return false

        else
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                Position = heroAbsOrigin,
                Queue = false
            })
            return 0.1
        end
    else
        unit:RemoveSelf()
        return false
    end
end

function AppEvent:GetDelay()
    local delay = RandomInt(4, 5)
    if AppEvent.delay == 1 then
        delay = RandomInt(6, 9)
    end
    if AppEvent.delay == 2 then
        delay = RandomInt(10, 15)
    end
    if AppEvent.delay == 3 then
        delay = RandomInt(4, 15)
    end
    return delay
end

function AppEvent:AddWoodenStake(e)
    local hero = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
    local point = hero:GetAbsOrigin() + RandomVector(500)
    local team = PlayerResource:GetTeam(e.playerid)
    local teamid = team
    if team == DOTA_TEAM_GOODGUYS then
        teamid = DOTA_TEAM_BADGUYS
    end
    if team == DOTA_TEAM_BADGUYS then
        teamid = DOTA_TEAM_GOODGUYS
    end

    local unit = CreateUnitByName("npc_dota_hero_" .. e.heroname, point, true, nil, nil, teamid)
    FindClearSpaceForUnit(unit, point, true)
    unit:SetControllableByPlayer(e.playerid, false)
    local abilityName = e.abilityName
    local ability = unit:FindAbilityByName(abilityName)
    ability:SetLevel(1)
    unit:AddItemByName("item_heart")
    unit:AddItemByName("item_heart")
    unit:AddItemByName("item_heart")
    unit:AddItemByName("item_heart")
    unit:AddItemByName("item_heart")
    unit:AddItemByName("item_heart")
    unit.prevHealth = unit:GetHealth()
    unit.ability = ability
    unit.active = false

    unit:SetThink("WoodenStakeThink", AppEvent, "WoodenStakeThink", 0)

end

function AppEvent:WoodenStakeThink(unit)
    local ability = unit.ability
    if not unit.active then
        if unit:GetHealth() < unit.prevHealth then
            unit.active = true
        end
        if unit:HasModifier("modifier_naga_siren_song_of_the_siren") then
            unit.active = true
        end
        if unit:HasModifier("modifier_shadow_demon_disruption") then
            unit.active = true
        end
        if unit:HasModifier("modifier_obsidian_destroyer_astral_imprisonment_prison") then
            unit.active = true
        end
    end

    if unit.active then
        if not ability:IsCooldownReady() then
            ability:EndCooldown()
            unit:SetMana(unit:GetMaxMana())
        end
        local GetBehavior = ability:GetBehavior()
        if bit.band(GetBehavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 then
            local hero = AICore:RandomEnemyHeroInRange(unit, ability:GetCastRange(), false, false)
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
                AbilityIndex = ability:entindex(),
                TargetIndex = hero:entindex(),
                Queue = false
            })
        end
        if bit.band(GetBehavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
                AbilityIndex = ability:entindex(),
                Queue = false
            })
        end
        if bit.band(GetBehavior, DOTA_ABILITY_BEHAVIOR_POINT) ~= 0 then
            local orgin = unit:GetAbsOrigin() + RandomVector(700)
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                AbilityIndex = ability:entindex(),
                Position = orgin,
                Queue = false
            })
        end
        unit.active = false
    end
    unit.prevHealth = unit:GetHealth()
    return 0
end

function AppEvent:AddWoodenStakeOther(e)
    local hero = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
    local point = hero:GetAbsOrigin() + RandomVector(500)
    local team = PlayerResource:GetTeam(e.playerid)
    local teamid = team
    if team == DOTA_TEAM_GOODGUYS then
        teamid = DOTA_TEAM_BADGUYS
    end
    if team == DOTA_TEAM_BADGUYS then
        teamid = DOTA_TEAM_GOODGUYS
    end
    if e.type == 1 then
        local unit = CreateUnitByName("npc_dota_hero_ursa", point, true, nil, nil, teamid)
        FindClearSpaceForUnit(unit, point, true)
        unit:SetControllableByPlayer(e.playerid, false)
        local item_blink = CreateItem("item_blink", unit, unit)
        unit:AddItem(item_blink)
        unit:AddItemByName("item_aegis")
        unit:AddItemByName("item_heart")
        unit:AddItemByName("item_heart")
        unit:AddItemByName("item_heart")
        unit:AddItemByName("item_heart")
        unit.active = false
        unit.godie = false
        unit.blink = item_blink

        unit:SetThink("WoodenStakeUrsaThink", AppEvent, "WoodenStakeUrsaThink", 0)
    end
    if e.type == 2 then
        local unit = CreateUnitByName("npc_dota_hero_skeleton_king", point, true, nil, nil, teamid)
        FindClearSpaceForUnit(unit, point, true)
        unit:SetControllableByPlayer(e.playerid, false)
        local item_blink = CreateItem("item_blink", unit, unit)
        unit:AddItem(item_blink)
        unit:AddItemByName("item_heart")
        unit:AddItemByName("item_heart")
        unit:AddItemByName("item_heart")
        unit:AddItemByName("item_heart")
        unit:AddItemByName("item_heart")
        local ability = unit:FindAbilityByName("skeleton_king_reincarnation")
        ability:SetLevel(1)
        unit.active = false
        unit.godie = false
        unit.blink = item_blink
        unit.ability = ability

        unit:SetThink("WoodenStakeSkeletonKingThink", AppEvent, "WoodenStakeSkeletonKingThink", 0)
    end
end

function AppEvent:WoodenStakeUrsaThink(unit)
    if not unit.active then
        if not unit:HasItemInInventory("item_aegis") then
            unit:AddItemByName("item_aegis")
        end
        if not unit:IsNull() and unit:IsAlive() and not unit.godie then
            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("WoodenStakeUrsaThink"), function()
                ApplyDamage {
                    victim = unit,
                    attacker = unit,
                    damage = unit:GetHealth(),
                    damage_type = DAMAGE_TYPE_PURE
                }
                unit.active = true
            end, 3)
            unit.godie = true
        end
    else
        if unit:IsAlive() then
            local orgin = unit:GetAbsOrigin() + RandomVector(700)
            local item_blink = unit.blink
            if not item_blink:IsCooldownReady() then
                item_blink:EndCooldown()
            end
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                AbilityIndex = item_blink:entindex(),
                Position = orgin,
                Queue = false
            })
            unit.active = false
            unit.godie = false
        end
    end
    return 0
end

function AppEvent:WoodenStakeSkeletonKingThink(unit)
    if not unit.active then
        local ability = unit.ability
        if not ability:IsCooldownReady() then
            ability:EndCooldown()
        end
        if not unit:IsNull() and unit:IsAlive() and not unit.godie then
            GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("WoodenStakeSkeletonKingThink"), function()
                ApplyDamage {
                    victim = unit,
                    attacker = unit,
                    damage = unit:GetHealth(),
                    damage_type = DAMAGE_TYPE_PURE
                }
                unit.active = true
            end, 3)
            unit.godie = true
        end
    else
        if unit:IsAlive() then
            local orgin = unit:GetAbsOrigin() + RandomVector(700)
            local item_blink = unit.blink
            if not item_blink:IsCooldownReady() then
                item_blink:EndCooldown()
            end
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                AbilityIndex = item_blink:entindex(),
                Position = orgin,
                Queue = false
            })
            unit.active = false
            unit.godie = false
        end
    end
    return 0
end

function AppEvent:AddCustomAbility(e)
    local player = PlayerResource:GetPlayer(e.playerid)
    local hero = player:GetAssignedHero()
    hero:AddAbility(e.ability_name)
end

AppEvent:RecreationInit()

