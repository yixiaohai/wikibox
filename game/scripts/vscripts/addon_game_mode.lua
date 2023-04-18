require("five_cloud.index") -- core
require("app.index")


-- 预载入
function Precache(context)
	App:Precache(context)
end

-- 入口
function Activate()
    FiveCloud:InitGameMode()
    App:Init()
end