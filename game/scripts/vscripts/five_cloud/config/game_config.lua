function FiveCloud:GameConfig()
    local game_mode = GameRules:GetGameModeEntity()
    if FiveCloudConfig["rpgConfig"] then
        -- 是否开启第一滴血
        GameRules:SetFirstBloodActive(false)
        -- 设置根据时间的金钱奖励
        GameRules:SetGoldPerTick(0)
        -- 设置金钱奖励时间
        GameRules:SetGoldTickTime(-1)
        -- 设置起始金钱                    
        GameRules:SetStartingGold(0)
        -- 设置一天的时间                
        GameRules:SetTimeOfDay(0.251)
        -- 是否开启英雄重生
        GameRules:SetHeroRespawnEnabled(false)
        -- 是否允许选择相同英雄       
        GameRules:SetSameHeroSelectionEnabled(true)
        -- 设置选择英雄时间   
        GameRules:SetHeroSelectionTime(1)
        -- 设置决策时间             
        GameRules:SetStrategyTime(0)
        -- 设置展示时间                   
        GameRules:SetShowcaseTime(0)
        -- 设置游戏开始前准备的时间
        GameRules:SetPreGameTime(0)
        -- 是否隐藏击杀提示
        GameRules:SetHideKillMessageHeaders(true)
        -- 设置游戏结束后停留的时间
        GameRules:SetPostGameTime(180)
        -- 设置树木再生时间
        GameRules:SetTreeRegrowTime(60)
        -- 是否使用默认的击杀奖励              
        GameRules:SetUseBaseGoldBountyOnHeroes(false)
        -- 是否没有在神秘商店也可以买到神秘商店的物品
        GameRules:SetUseUniversalShopMode(false)
        -- 胜利消息持续时间    
        GameRules:SetCustomVictoryMessageDuration(5)
        -- 允许使用战斗音乐
        GameRules:SetCustomGameAllowBattleMusic(false)
        -- 允许使用选择英雄音乐
        GameRules:SetCustomGameAllowHeroPickMusic(false)
        -- 允许使用游戏开始的音乐
        GameRules:SetCustomGameAllowMusicAtGameStart(false)
        -- 设置近战格挡几率
        GameRules:GetGameModeEntity():SetInnateMeleeDamageBlockPercent(0)

        -- 设置队伍人数
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_FIRST, 0) -- 观战队伍
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, 4) -- 天辉
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 0) -- 夜魇
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_NEUTRALS, 0) -- 野怪
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_1, 0) -- 自定义队伍1
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_2, 0) -- 自定义队伍2
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_3, 0) -- 自定义队伍3
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_4, 0) -- 自定义队伍4
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_5, 0) -- 自定义队伍5
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_6, 0) -- 自定义队伍6
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_7, 0) -- 自定义队伍7
        GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_8, 0) -- 自定义队伍8

        -- BOT设定
        game_mode:SetBotThinkingEnabled(false)
        -- 英雄选择界面超时未选择英雄的金币减少惩罚
        game_mode:SetSelectionGoldPenaltyEnabled(false)
        -- 返回是否关闭/开启储藏处购买功能。如果该功能被关闭，英雄必须在商店范围内购买物品                 
        game_mode:SetStashPurchasingDisabled(true)
        -- 是否禁用天气特效
        game_mode:SetWeatherEffectsDisabled(true)
        -- 总是显示玩家名字                       
        game_mode:SetAlwaysShowPlayerNames(false)
        -- 总是显示玩家的仓库，无论选择任何单位                       
        game_mode:SetAlwaysShowPlayerInventory(false)
        -- 是否禁用播音员              
        game_mode:SetAnnouncerDisabled(true)
        -- 是否开启买活                          
        game_mode:SetBuybackEnabled(false)
        -- 是否开启买活CD                            
        game_mode:SetCustomBuybackCooldownEnabled(false)
        -- 是否开启买活需要消耗金币              
        game_mode:SetCustomBuybackCostEnabled(true)
        -- 设置默认镜头高度，不建议在这里设置，在Javascript中使用GameUI.SetCameraDistance()设置                      
        -- game_mode:SetCameraDistanceOverride(1635)  
        -- 强制玩家选择英雄                      
        -- game_mode:SetCustomGameForceHero('npc_dota_hero_wisp')  
        -- 设置固定的复活时间         
        -- game_mode:SetFixedRespawnTime(5) 
        -- 是否禁用战争迷雾                             
        game_mode:SetFogOfWarDisabled(false)
        -- 是否开启黑色迷雾，开启后地图一开始是全黑的，需要探索后才会显示                            
        game_mode:SetUnseenFogOfWarEnabled(true)
        -- 设置泉水回复魔法值的速率                        
        -- game_mode:SetFountainConstantManaRegen(1)  
        -- 设置泉水回复生命值的速率                   
        -- game_mode:SetFountainPercentageHealthRegen(1)  
        -- 设置泉水回复魔法值百分比               
        -- game_mode:SetFountainPercentageManaRegen(1)  
        -- 是否禁用金币掉落的音效                 
        game_mode:SetGoldSoundDisabled(false)
        -- 是否英雄死亡损失金币                          
        game_mode:SetLoseGoldOnDeath(false)
        -- 设置最大攻击速度                         
        game_mode:SetMaximumAttackSpeed(2500)
        -- 设置最小攻击速度                           
        game_mode:SetMinimumAttackSpeed(10)
        -- 是否禁用物品推荐                         
        game_mode:SetRecommendedItemsDisabled(true)
        -- 当幻象死亡后是否删除                    
        game_mode:SetRemoveIllusionsOnDeath(true)
        -- 是否开启双倍神符                     
        game_mode:SetRuneEnabled(DOTA_RUNE_DOUBLEDAMAGE, false)
        -- 是否开启加速神符         
        game_mode:SetRuneEnabled(DOTA_RUNE_HASTE, false)
        -- 是否开启幻象神符                  
        game_mode:SetRuneEnabled(DOTA_RUNE_ILLUSION, false)
        -- 是否开启隐身神符           
        game_mode:SetRuneEnabled(DOTA_RUNE_INVISIBILITY, false)
        -- 是否开启恢复神符            
        game_mode:SetRuneEnabled(DOTA_RUNE_REGENERATION, false)
        -- 是否开启赏金神符           
        game_mode:SetRuneEnabled(DOTA_RUNE_BOUNTY, false)
        -- 隐藏置顶物品在快速购买                 
        game_mode:SetStickyItemDisabled(true)
        -- 禁止显示死亡消息                        
        game_mode:SetHudCombatEventsDisabled(true)
        -- 设置相机Z范围
        game_mode:SetCameraZRange(-1, 4000)
        -- 是否关闭中立物品
        game_mode:SetNeutralStashTeamViewOnlyEnabled(true)

        -- 是否使用自定义英雄等级                         
        game_mode:SetUseCustomHeroLevels(true)

        -- 是否使用自定义经验值，开启之后调用SetCustomXPRequiredToReachNextLevel设置每级经验差，否则可能引起崩溃
        GameRules:SetUseCustomHeroXPValues(true)

        -- 经验表,对应js中的经验表
        local hero_exp_table = {0}
        -- 设置英雄最高等级
        local custom_hero_max_level = 101
        -- 设置自定义英雄最大等级
        game_mode:SetCustomHeroMaxLevel(custom_hero_max_level)

        -- 设置每级经验差
        -- lua数组索引从1开始

        for i = 2, custom_hero_max_level do
            hero_exp_table[i] = math.floor(hero_exp_table[i - 1] * 1.15 + 50 + 20 * (i - 2))
        end

        game_mode:SetCustomXPRequiredToReachNextLevel(hero_exp_table)

    end
end
