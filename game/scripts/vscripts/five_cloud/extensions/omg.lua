if Omg == nil then
    Omg = class({})
end

local public = Omg

function public:Init()
    -- 绑定子技能
    public.bindingAbility = {}

    public.bindingAbility["elder_titan_ancestral_spirit"] = {}
    table.insert(public.bindingAbility["elder_titan_ancestral_spirit"], "elder_titan_move_spirit")
    table.insert(public.bindingAbility["elder_titan_ancestral_spirit"], "elder_titan_return_spirit")

    public.bindingAbility["shredder_chakram"] = {}
    table.insert(public.bindingAbility["shredder_chakram"], "shredder_return_chakram")
    table.insert(public.bindingAbility["shredder_chakram"], "shredder_chakram_2")
    table.insert(public.bindingAbility["shredder_chakram"], "shredder_return_chakram_2")

    public.bindingAbility["phoenix_sun_ray"] = {}
    table.insert(public.bindingAbility["phoenix_sun_ray"], "phoenix_sun_ray_toggle_move")
    table.insert(public.bindingAbility["phoenix_sun_ray"], "phoenix_sun_ray_stop")

    public.bindingAbility["phoenix_fire_spirits"] = {}
    table.insert(public.bindingAbility["phoenix_fire_spirits"], "phoenix_launch_fire_spirit")

    public.bindingAbility["phoenix_icarus_dive"] = {}
    table.insert(public.bindingAbility["phoenix_icarus_dive"], "phoenix_icarus_dive_stop")

    public.bindingAbility["rattletrap_hookshot"] = {}
    table.insert(public.bindingAbility["rattletrap_hookshot"], "rattletrap_overclocking")

    public.bindingAbility["life_stealer_infest"] = {}
    table.insert(public.bindingAbility["life_stealer_infest"], "life_stealer_consume")

    public.bindingAbility["earth_spirit_magnetize"] = {}
    table.insert(public.bindingAbility["earth_spirit_magnetize"], "earth_spirit_petrify")

    public.bindingAbility["tiny_tree_grab"] = {}
    table.insert(public.bindingAbility["tiny_tree_grab"], "tiny_toss_tree")

    public.bindingAbility["tiny_grow"] = {}
    table.insert(public.bindingAbility["tiny_grow"], "tiny_tree_channel")

    public.bindingAbility["tusk_walrus_punch"] = {}
    table.insert(public.bindingAbility["tusk_walrus_punch"], "tusk_walrus_kick")

    public.bindingAbility["pudge_dismember"] = {}
    table.insert(public.bindingAbility["pudge_dismember"], "pudge_eject")

    public.bindingAbility["kunkka_x_marks_the_spot"] = {}
    table.insert(public.bindingAbility["kunkka_x_marks_the_spot"], "kunkka_return")

    public.bindingAbility["kunkka_torrent"] = {}
    table.insert(public.bindingAbility["kunkka_torrent"], "kunkka_torrent_storm")

    public.bindingAbility["treant_overgrowth"] = {}
    table.insert(public.bindingAbility["treant_overgrowth"], "treant_eyes_in_the_forest")

    public.bindingAbility["alchemist_unstable_concoction"] = {}
    table.insert(public.bindingAbility["alchemist_unstable_concoction"], "alchemist_unstable_concoction_throw")

    public.bindingAbility["alchemist_chemical_rage"] = {}
    table.insert(public.bindingAbility["alchemist_chemical_rage"], "alchemist_berserk_potion")

    public.bindingAbility["lycan_shapeshift"] = {}
    table.insert(public.bindingAbility["lycan_shapeshift"], "lycan_wolf_bite")

    public.bindingAbility["primal_beast_onslaught"] = {}
    table.insert(public.bindingAbility["primal_beast_onslaught"], "primal_beast_onslaught_release")

    public.bindingAbility["snapfire_mortimer_kisses"] = {}
    table.insert(public.bindingAbility["snapfire_mortimer_kisses"], "snapfire_gobble_up")
    table.insert(public.bindingAbility["snapfire_mortimer_kisses"], "snapfire_spit_creep")

    public.bindingAbility["dawnbreaker_celestial_hammer"] = {}
    table.insert(public.bindingAbility["dawnbreaker_celestial_hammer"], "dawnbreaker_converge")

    public.bindingAbility["wisp_tether"] = {}
    table.insert(public.bindingAbility["wisp_tether"], "wisp_tether_break")

    public.bindingAbility["wisp_spirits"] = {}
    table.insert(public.bindingAbility["wisp_spirits"], "wisp_spirits_in")
    table.insert(public.bindingAbility["wisp_spirits"], "wisp_spirits_out")

    public.bindingAbility["juggernaut_omni_slash"] = {}
    table.insert(public.bindingAbility["juggernaut_omni_slash"], "juggernaut_swift_slash")

    public.bindingAbility["clinkz_wind_walk"] = {}
    table.insert(public.bindingAbility["clinkz_wind_walk"], "clinkz_burning_army")

    public.bindingAbility["nyx_assassin_vendetta"] = {}
    table.insert(public.bindingAbility["nyx_assassin_vendetta"], "nyx_assassin_burrow")
    table.insert(public.bindingAbility["nyx_assassin_vendetta"], "nyx_assassin_unburrow")

    public.bindingAbility["templar_assassin_psionic_trap"] = {}
    table.insert(public.bindingAbility["templar_assassin_psionic_trap"], "templar_assassin_trap_teleport")
    table.insert(public.bindingAbility["templar_assassin_psionic_trap"], "templar_assassin_trap")

    public.bindingAbility["naga_siren_song_of_the_siren"] = {}
    table.insert(public.bindingAbility["naga_siren_song_of_the_siren"], "naga_siren_song_of_the_siren_cancel")

    public.bindingAbility["spectre_haunt"] = {}
    table.insert(public.bindingAbility["spectre_haunt"], "spectre_reality")
    table.insert(public.bindingAbility["spectre_haunt"], "spectre_haunt_single")

    public.bindingAbility["antimage_mana_void"] = {}
    table.insert(public.bindingAbility["antimage_mana_void"], "antimage_mana_overload")

    public.bindingAbility["hoodwink_sharpshooter"] = {}
    table.insert(public.bindingAbility["hoodwink_sharpshooter"], "hoodwink_sharpshooter_release")
    table.insert(public.bindingAbility["hoodwink_sharpshooter"], "hoodwink_hunters_boomerang")

    public.bindingAbility["morphling_replicate"] = {}
    table.insert(public.bindingAbility["morphling_replicate"], "morphling_morph_replicate")

    public.bindingAbility["terrorblade_metamorphosis"] = {}
    table.insert(public.bindingAbility["terrorblade_metamorphosis"], "terrorblade_terror_wave")

    public.bindingAbility["ember_spirit_fire_remnant"] = {}
    table.insert(public.bindingAbility["ember_spirit_fire_remnant"], "ember_spirit_activate_fire_remnant")

    public.bindingAbility["pangolier_rollup"] = {}
    table.insert(public.bindingAbility["pangolier_rollup"], "pangolier_rollup_stop")

    public.bindingAbility["pangolier_gyroshell"] = {}
    table.insert(public.bindingAbility["pangolier_gyroshell"], "pangolier_gyroshell_stop")

    public.bindingAbility["meepo_divided_we_stand"] = {}
    table.insert(public.bindingAbility["meepo_divided_we_stand"], "meepo_petrify")

    public.bindingAbility["broodmother_spin_web"] = {}
    table.insert(public.bindingAbility["broodmother_spin_web"], "broodmother_sticky_snare")

    public.bindingAbility["faceless_void_time_walk"] = {}
    table.insert(public.bindingAbility["faceless_void_time_walk"], "faceless_void_time_walk_reverse")

    public.bindingAbility["bloodseeker_thirst"] = {}
    table.insert(public.bindingAbility["bloodseeker_thirst"], "bloodseeker_blood_mist")

    public.bindingAbility["monkey_king_tree_dance"] = {}
    table.insert(public.bindingAbility["monkey_king_tree_dance"], "monkey_king_primal_spring")
    table.insert(public.bindingAbility["monkey_king_tree_dance"], "monkey_king_primal_spring_early")

    public.bindingAbility["monkey_king_mischief"] = {}
    table.insert(public.bindingAbility["monkey_king_mischief"], "monkey_king_untransform")

    public.bindingAbility["tinker_rearm"] = {}
    table.insert(public.bindingAbility["tinker_rearm"], "tinker_keen_teleport")

    public.bindingAbility["keeper_of_the_light_spirit_form"] = {}
    table.insert(public.bindingAbility["keeper_of_the_light_spirit_form"], "keeper_of_the_light_blinding_light")
    table.insert(public.bindingAbility["keeper_of_the_light_spirit_form"], "keeper_of_the_light_will_o_wisp")

    public.bindingAbility["keeper_of_the_light_illuminate"] = {}
    table.insert(public.bindingAbility["keeper_of_the_light_illuminate"], "keeper_of_the_light_illuminate_end")
    table.insert(public.bindingAbility["keeper_of_the_light_illuminate"], "keeper_of_the_light_spirit_form_illuminate")
    table.insert(public.bindingAbility["keeper_of_the_light_illuminate"],
        "keeper_of_the_light_spirit_form_illuminate_end")

    public.bindingAbility["grimstroke_soul_chain"] = {}
    table.insert(public.bindingAbility["grimstroke_soul_chain"], "grimstroke_dark_portrait")

    public.bindingAbility["zuus_lightning_bolt"] = {}
    table.insert(public.bindingAbility["zuus_lightning_bolt"], "zuus_cloud")

    public.bindingAbility["puck_illusory_orb"] = {}
    table.insert(public.bindingAbility["puck_illusory_orb"], "puck_ethereal_jaunt")

    public.bindingAbility["dazzle_bad_juju"] = {}
    table.insert(public.bindingAbility["dazzle_bad_juju"], "dazzle_good_juju")

    public.bindingAbility["leshrac_pulse_nova"] = {}
    table.insert(public.bindingAbility["leshrac_pulse_nova"], "leshrac_greater_lightning_storm")

    public.bindingAbility["rubick_telekinesis"] = {}
    table.insert(public.bindingAbility["rubick_telekinesis"], "rubick_telekinesis_land")
    table.insert(public.bindingAbility["rubick_telekinesis"], "rubick_telekinesis_land_self")

    public.bindingAbility["shadow_demon_shadow_poison"] = {}
    table.insert(public.bindingAbility["shadow_demon_shadow_poison"], "shadow_demon_shadow_poison_release")

    public.bindingAbility["crystal_maiden_freezing_field"] = {}
    table.insert(public.bindingAbility["crystal_maiden_freezing_field"], "crystal_maiden_freezing_field_stop")

    public.bindingAbility["invoker_invoke"] = {}
    table.insert(public.bindingAbility["invoker_invoke"], "invoker_cold_snap")
    table.insert(public.bindingAbility["invoker_invoke"], "invoker_ghost_walk")
    table.insert(public.bindingAbility["invoker_invoke"], "invoker_tornado")
    table.insert(public.bindingAbility["invoker_invoke"], "invoker_emp")
    table.insert(public.bindingAbility["invoker_invoke"], "invoker_alacrity")
    table.insert(public.bindingAbility["invoker_invoke"], "invoker_chaos_meteor")
    table.insert(public.bindingAbility["invoker_invoke"], "invoker_sun_strike")
    table.insert(public.bindingAbility["invoker_invoke"], "invoker_forge_spirit")
    table.insert(public.bindingAbility["invoker_invoke"], "invoker_ice_wall")
    table.insert(public.bindingAbility["invoker_invoke"], "invoker_deafening_blast")

    public.bindingAbility["oracle_false_promise"] = {}
    table.insert(public.bindingAbility["oracle_false_promise"], "oracle_rain_of_destiny")

    public.bindingAbility["bane_nightmare"] = {}
    table.insert(public.bindingAbility["bane_nightmare"], "bane_nightmare_end")

    public.bindingAbility["visage_summon_familiars"] = {}
    table.insert(public.bindingAbility["visage_summon_familiars"], "visage_stone_form_self_cast")
    table.insert(public.bindingAbility["visage_summon_familiars"], "visage_silent_as_the_grave")
    table.insert(public.bindingAbility["visage_summon_familiars"], "visage_summon_familiars_stone_form")

    public.bindingAbility["ancient_apparition_ice_blast"] = {}
    table.insert(public.bindingAbility["ancient_apparition_ice_blast"], "ancient_apparition_ice_blast_release")

    public.bindingAbility["dark_willow_bedlam"] = {}
    table.insert(public.bindingAbility["dark_willow_bedlam"], "dark_willow_terrorize")

    public.bindingAbility["ogre_magi_multicast"] = {}
    table.insert(public.bindingAbility["ogre_magi_multicast"], "ogre_magi_unrefined_fireblast")

    public.bindingAbility["enchantress_impetus"] = {}
    table.insert(public.bindingAbility["enchantress_impetus"], "enchantress_bunny_hop")

    -- A仗技能
    public.bindingAghanimsAbility = {}

    table.insert(public.bindingAghanimsAbility, "shredder_chakram")
    public.bindingAghanimsAbility["shredder_chakram"] = {}
    table.insert(public.bindingAghanimsAbility["shredder_chakram"], "shredder_chakram_2")

    table.insert(public.bindingAghanimsAbility, "rattletrap_hookshot")
    public.bindingAghanimsAbility["rattletrap_hookshot"] = {}
    table.insert(public.bindingAghanimsAbility["rattletrap_hookshot"], "rattletrap_overclocking")

    table.insert(public.bindingAghanimsAbility, "earth_spirit_magnetize")
    public.bindingAghanimsAbility["earth_spirit_magnetize"] = {}
    table.insert(public.bindingAghanimsAbility["earth_spirit_magnetize"], "earth_spirit_petrify")

    table.insert(public.bindingAghanimsAbility, "tiny_grow")
    public.bindingAghanimsAbility["tiny_grow"] = {}
    table.insert(public.bindingAghanimsAbility["tiny_grow"], "tiny_tree_channel")

    table.insert(public.bindingAghanimsAbility, "tusk_walrus_punch")
    public.bindingAghanimsAbility["tusk_walrus_punch"] = {}
    table.insert(public.bindingAghanimsAbility["tusk_walrus_punch"], "tusk_walrus_kick")
    -- table.insert(public.bindingAghanimsAbility["tusk_walrus_punch"], "tusk_frozen_sigil")

    table.insert(public.bindingAghanimsAbility, "kunkka_torrent")
    public.bindingAghanimsAbility["kunkka_torrent"] = {}
    table.insert(public.bindingAghanimsAbility["kunkka_torrent"], "kunkka_torrent_storm")

    table.insert(public.bindingAghanimsAbility, "treant_overgrowth")
    public.bindingAghanimsAbility["treant_overgrowth"] = {}
    table.insert(public.bindingAghanimsAbility["treant_overgrowth"], "treant_eyes_in_the_forest")

    table.insert(public.bindingAghanimsAbility, "alchemist_chemical_rage")
    public.bindingAghanimsAbility["alchemist_chemical_rage"] = {}
    table.insert(public.bindingAghanimsAbility["alchemist_chemical_rage"], "alchemist_berserk_potion")

    table.insert(public.bindingAghanimsAbility, "lycan_shapeshift")
    public.bindingAghanimsAbility["lycan_shapeshift"] = {}
    table.insert(public.bindingAghanimsAbility["lycan_shapeshift"], "lycan_wolf_bite")

    table.insert(public.bindingAghanimsAbility, "snapfire_mortimer_kisses")
    public.bindingAghanimsAbility["snapfire_mortimer_kisses"] = {}
    table.insert(public.bindingAghanimsAbility["snapfire_mortimer_kisses"], "snapfire_gobble_up")
    table.insert(public.bindingAghanimsAbility["snapfire_mortimer_kisses"], "snapfire_spit_creep")

    table.insert(public.bindingAghanimsAbility, "juggernaut_omni_slash")
    public.bindingAghanimsAbility["juggernaut_omni_slash"] = {}
    table.insert(public.bindingAghanimsAbility["juggernaut_omni_slash"], "juggernaut_swift_slash")

    table.insert(public.bindingAghanimsAbility, "clinkz_wind_walk")
    public.bindingAghanimsAbility["clinkz_wind_walk"] = {}
    table.insert(public.bindingAghanimsAbility["clinkz_wind_walk"], "clinkz_burning_army")

    table.insert(public.bindingAghanimsAbility, "nyx_assassin_vendetta")
    public.bindingAghanimsAbility["nyx_assassin_vendetta"] = {}
    table.insert(public.bindingAghanimsAbility["nyx_assassin_vendetta"], "nyx_assassin_burrow")

    table.insert(public.bindingAghanimsAbility, "templar_assassin_psionic_trap")
    public.bindingAghanimsAbility["templar_assassin_psionic_trap"] = {}
    table.insert(public.bindingAghanimsAbility["templar_assassin_psionic_trap"], "templar_assassin_trap_teleport")

    table.insert(public.bindingAghanimsAbility, "spectre_haunt")
    public.bindingAghanimsAbility["spectre_haunt"] = {}
    table.insert(public.bindingAghanimsAbility["spectre_haunt"], "spectre_haunt_single")

    table.insert(public.bindingAghanimsAbility, "antimage_mana_void")
    public.bindingAghanimsAbility["antimage_mana_void"] = {}
    table.insert(public.bindingAghanimsAbility["antimage_mana_void"], "antimage_mana_overload")

    table.insert(public.bindingAghanimsAbility, "hoodwink_sharpshooter")
    public.bindingAghanimsAbility["hoodwink_sharpshooter"] = {}
    table.insert(public.bindingAghanimsAbility["hoodwink_sharpshooter"], "hoodwink_hunters_boomerang")

    table.insert(public.bindingAghanimsAbility, "terrorblade_metamorphosis")
    public.bindingAghanimsAbility["terrorblade_metamorphosis"] = {}
    table.insert(public.bindingAghanimsAbility["terrorblade_metamorphosis"], "terrorblade_terror_wave")

    table.insert(public.bindingAghanimsAbility, "meepo_divided_we_stand")
    public.bindingAghanimsAbility["meepo_divided_we_stand"] = {}
    table.insert(public.bindingAghanimsAbility["meepo_divided_we_stand"], "meepo_petrify")

    table.insert(public.bindingAghanimsAbility, "broodmother_spin_web")
    public.bindingAghanimsAbility["broodmother_spin_web"] = {}
    table.insert(public.bindingAghanimsAbility["broodmother_spin_web"], "broodmother_sticky_snare")

    table.insert(public.bindingAghanimsAbility, "bloodseeker_thirst")
    public.bindingAghanimsAbility["bloodseeker_thirst"] = {}
    table.insert(public.bindingAghanimsAbility["bloodseeker_thirst"], "bloodseeker_blood_mist")

    table.insert(public.bindingAghanimsAbility, "keeper_of_the_light_spirit_form")
    public.bindingAghanimsAbility["keeper_of_the_light_spirit_form"] = {}
    table.insert(public.bindingAghanimsAbility["keeper_of_the_light_spirit_form"], "keeper_of_the_light_will_o_wisp")

    table.insert(public.bindingAghanimsAbility, "grimstroke_soul_chain")
    public.bindingAghanimsAbility["grimstroke_soul_chain"] = {}
    table.insert(public.bindingAghanimsAbility["grimstroke_soul_chain"], "grimstroke_dark_portrait")

    table.insert(public.bindingAghanimsAbility, "zuus_lightning_bolt")
    public.bindingAghanimsAbility["zuus_lightning_bolt"] = {}
    table.insert(public.bindingAghanimsAbility["zuus_lightning_bolt"], "zuus_cloud")

    table.insert(public.bindingAghanimsAbility, "leshrac_pulse_nova")
    public.bindingAghanimsAbility["leshrac_pulse_nova"] = {}
    table.insert(public.bindingAghanimsAbility["leshrac_pulse_nova"], "leshrac_greater_lightning_storm")

    table.insert(public.bindingAghanimsAbility, "oracle_false_promise")
    public.bindingAghanimsAbility["oracle_false_promise"] = {}
    table.insert(public.bindingAghanimsAbility["oracle_false_promise"], "oracle_rain_of_destiny")

    table.insert(public.bindingAghanimsAbility, "visage_summon_familiars")
    public.bindingAghanimsAbility["visage_summon_familiars"] = {}
    table.insert(public.bindingAghanimsAbility["visage_summon_familiars"], "visage_silent_as_the_grave")

    table.insert(public.bindingAghanimsAbility, "ogre_magi_multicast")
    public.bindingAghanimsAbility["ogre_magi_multicast"] = {}
    table.insert(public.bindingAghanimsAbility["ogre_magi_multicast"], "ogre_magi_unrefined_fireblast")

    table.insert(public.bindingAghanimsAbility, "enchantress_impetus")
    public.bindingAghanimsAbility["enchantress_impetus"] = {}
    table.insert(public.bindingAghanimsAbility["enchantress_impetus"], "enchantress_bunny_hop")

    -- setAbilityLevel
    public.setAbilityLevel = {}

    table.insert(public.setAbilityLevel, "hoodwink_hunters_boomerang")
    table.insert(public.setAbilityLevel, "snapfire_gobble_up")
    table.insert(public.setAbilityLevel, "snapfire_spit_creep")
    table.insert(public.setAbilityLevel, "juggernaut_swift_slash")
    table.insert(public.setAbilityLevel, "nyx_assassin_burrow")
    table.insert(public.setAbilityLevel, "terrorblade_terror_wave")
    table.insert(public.setAbilityLevel, "broodmother_sticky_snare")
    table.insert(public.setAbilityLevel, "bloodseeker_blood_mist")
    table.insert(public.setAbilityLevel, "keeper_of_the_light_will_o_wisp")
    table.insert(public.setAbilityLevel, "grimstroke_dark_portrait")
    table.insert(public.setAbilityLevel, "rubick_telekinesis_land")
    table.insert(public.setAbilityLevel, "rubick_telekinesis_land_self")
    table.insert(public.setAbilityLevel, "oracle_rain_of_destiny")
    table.insert(public.setAbilityLevel, "enchantress_bunny_hop")

end

function public:AddAbility(playerid, replaceHeroid, abilityName)
    local hero = EntIndexToHScript(replaceHeroid)

    if not hero.RemoveEmptyAbility then
        public:RemoveEmptyAbility(hero)
    end

    -- 女锤熠熠生辉
    if abilityName == "dawnbreaker_luminosity" then
        FiveCloudSDK:Message("#AbilityDisabled", playerid, "error")
        return
    end

    local ability = hero:FindAbilityByName(abilityName)
    if ability == nil then

        local getAbility = hero:AddAbility(abilityName)
        public:RemoveBindingModifier(hero, getAbility)
        public:SetAbilityLevel(hero, abilityName, getAbility)
        if public.bindingAbility[abilityName] then
            for i = 1, #public.bindingAbility[abilityName] do
                local childAbilityName = public.bindingAbility[abilityName][i]
                local childAbility = hero:FindAbilityByName(childAbilityName)
                if childAbility == nil then
                    local getChildAbility = hero:AddAbility(childAbilityName)
                    if getChildAbility then
                        public:RemoveBindingModifier(hero, getChildAbility)
                        public:SetAbilityLevel(hero, childAbilityName, getChildAbility)
                    end
                end
            end
        end
    else
        FiveCloudSDK:Message("#HasAbility", playerid, "error")
        return
    end

    if hero:HasModifier("modifier_item_aghanims_shard") then
        local m = hero:FindModifierByName("modifier_item_aghanims_shard")
        hero:RemoveModifierByName("modifier_item_aghanims_shard")
        hero:AddNewModifier(hero, nil, "modifier_item_aghanims_shard", {})
    end

    Omg:ShowScepterAbility(hero)

end

function public:RemoveEmptyAbility(hero)
    local abilityCount = hero:GetAbilityCount()
    for i = abilityCount - 1, 0, -1 do
        local ability = hero:GetAbilityByIndex(i)
        if ability then
            if ability:GetAbilityName() == "generic_hidden" then
                hero:RemoveAbilityByHandle(ability)
            end
        end
    end
    hero.RemoveEmptyAbility = true
end

function public:RemoveAbility(playerid, replaceHeroid, abilityName)
    local hero = EntIndexToHScript(replaceHeroid)
    local ability = hero:FindAbilityByName(abilityName)
    if ability then

        if abilityName == "monkey_king_wukongs_command" then
            local heroName = hero:GetClassname()
            FiveCloudSDK:Print(heroName)
            local ents = Entities:FindAllByClassname(heroName)
            for k, ent in pairs(ents) do
                if ent:HasModifier("modifier_monkey_king_fur_army_soldier") then
                    ent:RemoveSelf()
                end
            end
        end

        local level = ability:GetLevel()
        local points = hero:GetAbilityPoints()
        local index = ability:GetAbilityIndex()
        public:SetAbilityDiable(ability)
        hero:SetAbilityPoints(points + level)
        public:RemoveAbilityModifier(hero, ability)
        ability:RemoveSelf()
        if public.bindingAbility[abilityName] then
            for i = 1, #public.bindingAbility[abilityName] do
                local childAbilityName = public.bindingAbility[abilityName][i]
                local childAbility = hero:FindAbilityByName(childAbilityName)
                if childAbility then
                    public:SetAbilityDiable(childAbility)
                    public:RemoveAbilityModifier(hero, childAbility)
                    childAbility:RemoveSelf()
                end
            end
        end
    end
end

function public:RemoveAbilityModifier(hero, ability)
    local modifiers = hero:FindAllModifiers()
    for i = 1, #modifiers do
        local modifier = modifiers[i]
        if modifier:GetAbility() == ability then
            modifier:Destroy()
        end
    end
end

function public:SetAbilityDiable(ability)
    if ability:IsChanneling() then
        ability:SetChanneling(false)
    end
    if ability:GetToggleState() then
        ability:ToggleAbility()
    end
    if ability:GetAutoCastState() then
        ability:ToggleAutoCast()
    end
    ability:SetLevel(0)
    ability:SetHidden(true)
    ability:OnChannelFinish(true)
end

function public:SetAbilityLevel(hero, abilityName, getAbility)
    if public.setAbilityLevel then
        for i = 1, #public.setAbilityLevel do
            local CheckAbilityName = public.setAbilityLevel[i]
            if CheckAbilityName == abilityName then
                getAbility:SetLevel(1)
            end
        end
    end
end

function public:RemoveBindingModifier(hero, ability)
    local modifier_name = ability:GetIntrinsicModifierName()
    local modifier = hero:FindModifierByName(modifier_name)
    if modifier then
        modifier:Destroy()
    end
end

function public:ShowScepterAbility(hero)
    local hsaScepter = false
    if hero:HasModifier("modifier_item_ultimate_scepter") or
        hero:HasModifier("modifier_item_ultimate_scepter_consumed_alchemist") then
            hsaScepter = true
    end
    if public.bindingAghanimsAbility then
        for i = 1, #public.bindingAghanimsAbility do
            local AbilityName = public.bindingAghanimsAbility[i]
            local Ability = hero:FindAbilityByName(AbilityName)
            if Ability then
                for n = 1, #public.bindingAghanimsAbility[AbilityName] do
                    local childAbilityName = public.bindingAghanimsAbility[AbilityName][n]
                    local childAbility = hero:FindAbilityByName(childAbilityName)
                    if childAbility then
                        if hsaScepter then
                            childAbility:SetHidden(false)
                        else
                            childAbility:SetHidden(true)
                        end
                    end
                end
            end
        end
    end
end

public:Init()
