if not FiveCloudConfig then
    FiveCloudConfig = {
        ["gameName"] = "dota_sendbox", -- 项目名称
        ["rpgConfig"] = false, -- 为rpg预设的游戏设置
        ["isCloudMode"] = true, -- 是否开启云平台
        ["isDebugMode"] = true, -- 调试模式
        ["isTestMap"] = true, -- 是否测试地图

        ["profiling"] = true, -- 性能测试
        ["profilingNum"] = 10, -- 性能测试报告显示数量
        ["profilingReportInterval"] = 120, -- 性能测试报告打印间隔

        ["isIllusionInheritAbility"] = true, -- 幻象继承技能
        ["EasyBuy"] = 1, -- 简易购买模式 1 开启 0 关闭
        ["HeroFastRespawn"] = 1, -- 快速复活模式 1 开启 0 关闭
        ["HeroSituRespawn"] = 1, -- 原地复活模式 1 开启 0 关闭
        ["IsDedicatedServer"] = IsDedicatedServer(), -- 是否官方服务器

        ["heroMaxAbilityNum"] = 35, -- 官方原生的最大技能数量
        ["heroMaxInventoryNum"] = 17, -- 官方原生的物品栏数量

    }

    if FiveCloudConfig["isCloudMode"] then

        if FiveCloudConfig["isTestMap"] then
            FiveCloudConfig["appid"] = "116584138633471"
            FiveCloudConfig["appsecret"] = "D4E11AC4DE8BF26151FBBD1DC0E2003E"
            FiveCloudConfig["requestKey"] = "fiveCloud"
        else
            FiveCloudConfig["appid"] = "116584138695681"
            FiveCloudConfig["appsecret"] = "C14222DEAE367DBE0612650D0CE9C1C5"
            FiveCloudConfig["requestKey"] = "fiveCloud"
        end

        FiveCloudConfig["baseUrl"] = "https://api.holemystery.com/fivecloud" -- 服务器地址
        FiveCloudConfig["debugOnline"] = true -- 上传错误日志
        FiveCloudConfig["keyStatusCompleted"] = true -- 服务器是否已接收到DedicatedServerKey
        FiveCloudConfig["gameStartTime"] = 0 -- 初始化时从服务器获取时间戳
        FiveCloudConfig["serveMode"] = false -- 初始化时通过服务器获取服务器状态

    end
end
