-- 开关野区刷怪刷新范围
function AppEvent:NeutralcampRefreshRange(e)
    local v = "Disable"
    if e.checked == 1 then
        v = "Enable"
    end

    local neutralcampList = {"neutralcamp_good_1_regionEntity", "neutralcamp_good_2_regionEntity",
                             "neutralcamp_good_3_regionEntity", "neutralcamp_good_4_regionEntity",
                             "neutralcamp_good_5_regionEntity", "neutralcamp_good_7_regionEntity",
                             "neutralcamp_good_8_regionEntity", "neutralcamp_good_9_regionEntity",
                             "neutralcamp_good_10_regionEntity", "neutralcamp_good_11_regionEntity",
                             "neutralcamp_good_12_regionEntity", "neutralcamp_good_13_regionEntity",
                             "neutralcamp_good_14_regionEntity", "neutralcamp_good_15_regionEntity",
                             "neutralcamp_evil_1_regionEntity", "neutralcamp_evil_2_regionEntity",
                             "neutralcamp_evil_3_regionEntity", "neutralcamp_evil_4_regionEntity",
                             "neutralcamp_evil_5_regionEntity", "neutralcamp_evil_6_regionEntity",
                             "neutralcamp_evil_8_regionEntity", "neutralcamp_evil_9_regionEntity",
                             "neutralcamp_evil_10_regionEntity", "neutralcamp_evil_11_regionEntity",
                             "neutralcamp_evil_12_regionEntity", "neutralcamp_evil_13_regionEntity",
                             "neutralcamp_evil_14_regionEntity", "neutralcamp_evil_15_regionEntity"}

    for i = 1, #neutralcampList do
        DoEntFire(neutralcampList[i], v, "", 0, {}, {})
    end

    CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
        name = "NeutralcampRefreshRange",
        data = e.checked
    })
end

-- 停止刷新小兵 禁止出兵
function AppEvent:NoSpawnCreeps(e)
    if GameRules:IsCheatMode() then
        if e.checked == 1 then
            SendToServerConsole("dota_kill_creeps radiant")
            SendToServerConsole("dota_kill_creeps dire")
            SendToServerConsole("dota_creeps_no_spawning 1")
        else
            SendToServerConsole("dota_creeps_no_spawning 0")
            SendToServerConsole("dota_spawn_creeps")
        end
        CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
            name = "NoSpawnCreeps",
            data = e.checked
        })
    else
        FiveCloudSDK:Message("#NotIsCheatMode", e.playerid, "error")
    end
end

-- 移除野怪
function AppEvent:KillNeutrals(e)
    local neutrals = Entities:FindAllByClassname("npc_dota_creep_neutral")
    if neutrals then
        for k, ent in pairs(neutrals) do
            ent:Destroy()
        end
    end
end

-- 刷新树木
function AppEvent:RegrowTrees(e)
    GridNav:RegrowAllTrees()
end

-- 移除树木
function AppEvent:RemoveTrees(e)
    GameRules:SetTreeRegrowTime(36000)
    local trees = Entities:FindAllByClassname("ent_dota_tree")
    if trees then
        for k, ent in pairs(trees) do
            ent:CutDown(-1)
        end
    end
end

-- 隐藏前哨
function AppEvent:WatchTowerHidden(e)
    local towers = Entities:FindAllByClassname("npc_dota_watch_tower")
    local buildings = {}
    for _, v in pairs(towers) do
        table.insert(buildings, v)
    end

    for _, v in pairs(buildings) do
        if e.checked == 1 then
            v:AddNewModifier(v, nil, "modifier_generic_hidden", {})
        else
            v:RemoveModifierByName("modifier_generic_hidden")
        end
    end
    CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
        name = "WatchTowerHidden",
        data = e.checked
    })
end

-- 获取所有建筑
function AppEvent:GetBuilding()
    local towers = Entities:FindAllByClassname("npc_dota_tower")
    local buildings = {}
    for _, v in pairs(towers) do
        table.insert(buildings, v)
    end
    for _, v in pairs(Entities:FindAllByClassname("npc_dota_building")) do
        table.insert(buildings, v)
    end
    for _, v in pairs(Entities:FindAllByClassname("npc_dota_barracks")) do
        table.insert(buildings, v)
    end
    for _, v in pairs(Entities:FindAllByClassname("npc_dota_fort")) do
        table.insert(buildings, v)
    end
    for _, v in pairs(Entities:FindAllByClassname("npc_dota_filler")) do
        table.insert(buildings, v)
    end

    return buildings
end

-- 隐藏建筑
function AppEvent:BuildHidden(e)
    local buildings = AppEvent:GetBuilding()
    for _, v in pairs(buildings) do
        if e.checked == 1 then
            v:AddNewModifier(v, nil, "modifier_generic_hidden", {})
        else
            v:RemoveModifierByName("modifier_generic_hidden")
        end
    end
    CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
        name = "BuildHidden",
        data = e.checked
    })
end

-- 建筑无敌
function AppEvent:BuildingInvulnerability(e)
    local buildings = AppEvent:GetBuilding()

    if e.checked == 1 then
        for _, v in pairs(buildings) do
            if IsValidEntity(v) and v:IsAlive() then
                v:AddNewModifier(v, nil, "modifier_fountain_glyph", {
                    duration = -1
                })
            end
        end
    else
        for _, v in pairs(buildings) do
            if IsValidEntity(v) and v:IsAlive() then
                v:RemoveModifierByName("modifier_fountain_glyph")
            end
        end
    end
    CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
        name = "BuildingInvulnerability",
        data = e.checked
    })
end

-- 建筑满血
function AppEvent:BuildingHeal(e)
    local buildings = AppEvent:GetBuilding()
    for _, v in pairs(buildings) do
        if IsValidEntity(v) and v:IsAlive() then
            v:SetHealth(v:GetMaxHealth())
        end
    end
end

-- 移除眼
function AppEvent:RemoveWards(e)
    local wards = Entities:FindAllByClassname("npc_dota_ward_base")
    local sentries = Entities:FindAllByClassname("npc_dota_ward_base_truesight")
    if wards then
        for k, ent in pairs(wards) do
            ent:RemoveSelf()
        end
    end
    if sentries then
        for k, ent in pairs(sentries) do
            ent:RemoveSelf()
        end
    end
end

function AppEvent:SaveState(e)
    if FiveCloudConfig["isCloudMode"] and FiveCloudConfig["IsDedicatedServer"] then
        local uploadData = ""

        uploadData = uploadData .. e.data.EasyBuy
        uploadData = uploadData .. e.data.FreeSpells
        uploadData = uploadData .. e.data.HeroFastRespawn
        uploadData = uploadData .. e.data.HeroSituRespawn
        uploadData = uploadData .. e.data.PassiveGold
        uploadData = uploadData .. e.data.NoFogOfWar
        uploadData = uploadData .. e.data.NoSpawnCreeps
        uploadData = uploadData .. e.data.WatchTowerHidden
        uploadData = uploadData .. e.data.BuildHidden
        uploadData = uploadData .. e.data.BuildingInvulnerability
        uploadData = uploadData .. "|"

        local hero = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
        local wards = Entities:FindAllByClassname("npc_dota_ward_base")
        local sentries = Entities:FindAllByClassname("npc_dota_ward_base_truesight")
        local dummys = Entities:FindAllByClassname("npc_dota_hero_target_dummy")

        local data_wards = "{"
        if wards then
            for k, ent in pairs(wards) do
                local modifier = ent:FindModifierByName("modifier_item_buff_ward")
                if modifier then
                    data_wards = data_wards .. "{" .. ent:GetOrigin().x .. "," .. ent:GetOrigin().y .. "," ..
                                     ent:GetOrigin().z .. ","
                    data_wards = data_wards .. ent:GetTeam() .. ","
                    data_wards = data_wards .. ent:FindModifierByName("modifier_item_buff_ward"):GetDuration() .. "},"
                end
            end
        end
        data_wards = data_wards .. "}|"
        uploadData = uploadData .. data_wards

        local data_sentries = "{"
        if sentries then
            for k, ent in pairs(sentries) do
                local modifier = ent:FindModifierByName("modifier_item_buff_ward")
                if modifier then
                    data_sentries = data_sentries .. "{" .. ent:GetOrigin().x .. "," .. ent:GetOrigin().y .. "," ..
                                        ent:GetOrigin().z .. ","
                    data_sentries = data_sentries .. ent:GetTeam() .. ","
                    data_sentries = data_sentries .. ent:FindModifierByName("modifier_item_buff_ward"):GetDuration() ..
                                        "},"
                end
            end
        end
        data_sentries = data_sentries .. "}|"
        uploadData = uploadData .. data_sentries

        local data_dummys = "{"
        if dummys then
            for k, ent in pairs(dummys) do
                data_dummys = data_dummys .. "{" .. ent:GetOrigin().x .. "," .. ent:GetOrigin().y .. "," ..
                                  ent:GetOrigin().z .. "},"
            end
        end
        data_dummys = data_dummys .. "}|"
        uploadData = uploadData .. data_dummys

        uploadData =
            uploadData .. "{" .. hero:GetOrigin().x .. "," .. hero:GetOrigin().y .. "," .. hero:GetOrigin().z .. "}"

        FiveCloudSDK:HttpPostWithSign("/dota2/map/SaveState", e.playerid, {
            Content = uploadData
        }, function(res)
            if res then
                if res.code == 200 then
                    FiveCloudSDK:Message("#SaveStateOK", e.playerid)
                end
            end
        end)
    else
        FiveCloudSDK:Message("#NotIsCloudMode", e.playerid, "error")
    end
end

function AppEvent:RestoreState(e)
    if FiveCloudConfig["isCloudMode"] and FiveCloudConfig["IsDedicatedServer"] then
        local func = function(res)
            if res then
                if res.code == 200 then
                    local hero = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
                    local content = res.data.content
                    local arr = FiveCloudSDK:Split(content, "|")
                    local togglebutton = arr[1]
                    local wards = json.decode(arr[2])
                    local sentries = json.decode(arr[3])
                    local dummys = json.decode(arr[4])
                    local heroinfo = json.decode(arr[5])

                    local EasyBuy = tonumber(string.sub(togglebutton, 1, 1))
                    local FreeSpells = tonumber(string.sub(togglebutton, 2, 2))
                    local HeroFastRespawn = tonumber(string.sub(togglebutton, 3, 3))
                    local HeroSituRespawn = tonumber(string.sub(togglebutton, 4, 4))
                    local PassiveGold = tonumber(string.sub(togglebutton, 5, 5))
                    local NoFogOfWar = tonumber(string.sub(togglebutton, 6, 6))
                    local NoSpawnCreeps = tonumber(string.sub(togglebutton, 7, 7))
                    local WatchTowerHidden = tonumber(string.sub(togglebutton, 8, 8))
                    local BuildHidden = tonumber(string.sub(togglebutton, 9, 9))
                    local BuildingInvulnerability = tonumber(string.sub(togglebutton, 10, 10))

                    e.checked = EasyBuy
                    FiveCloudCustomEvent:EasyBuy(e)
                    e.checked = FreeSpells
                    FiveCloudCustomEvent:FreeSpells(e)
                    e.checked = HeroFastRespawn
                    FiveCloudCustomEvent:HeroFastRespawn(e)
                    e.checked = HeroSituRespawn
                    FiveCloudCustomEvent:HeroSituRespawn(e)
                    e.checked = PassiveGold
                    FiveCloudCustomEvent:PassiveGold(e)
                    e.checked = NoFogOfWar
                    FiveCloudCustomEvent:NoFogOfWar(e)
                    e.checked = NoSpawnCreeps
                    AppEvent:NoSpawnCreeps(e)
                    e.checked = WatchTowerHidden
                    AppEvent:WatchTowerHidden(e)
                    e.checked = BuildHidden
                    AppEvent:BuildHidden(e)
                    e.checked = BuildingInvulnerability
                    AppEvent:BuildingInvulnerability(e)

                    AppEvent:RemoveWards(e)

                    local current_dummys = Entities:FindAllByClassname("npc_dota_hero_target_dummy")
                    if current_dummys then
                        for k, ent in pairs(current_dummys) do
                            ent:RemoveSelf()
                        end
                    end

                    for i, v in ipairs(wards) do
                        local unit = CreateUnitByName("npc_dota_observer_wards", Vector(v[1], v[2], v[3]), true, nil,
                            nil, v[4])
                        unit:AddNewModifier(hero, nil, "modifier_item_buff_ward", {
                            duration = v[5]
                        })
                    end

                    for i, v in ipairs(sentries) do
                        local unit = CreateUnitByName("npc_dota_sentry_wards", Vector(v[1], v[2], v[3]), true, nil, nil,
                            v[4])
                        unit:AddNewModifier(hero, nil, "modifier_item_buff_ward", {
                            duration = v[5]
                        })
                    end

                    for i, v in ipairs(dummys) do
                        local unit = CreateUnitByName("npc_dota_hero_target_dummy", Vector(v[1], v[2], v[3]), true, nil,
                            nil, DOTA_TEAM_NEUTRALS)

                            unit:SetControllableByPlayer(e.playerid, false)
                    end

                    hero:SetOrigin(Vector(heroinfo[1], heroinfo[2], heroinfo[3]))

                    FiveCloudSDK:Message("#RestoreStateOK", e.playerid)

                    local player = PlayerResource:GetPlayer(e.playerid)
                    CustomGameEventManager:Send_ServerToPlayer(player, "MoveCameraToHero", {})
                end
            end
        end
        FiveCloudSDK:HttpPostWithSign("/dota2/map/RestoreState", e.playerid, {}, func)
    else
        FiveCloudSDK:Message("#NotIsCloudMode", e.playerid, "error")
    end
end
