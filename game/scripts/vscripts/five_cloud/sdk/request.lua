local md5 = require("five_cloud.utils.md5")

local function MakeData(playerid, data)
    local timestamp = FiveCloudConfig["gameStartTime"] + math.floor(Time() + 0.5)
    local params = {
        Appid = FiveCloudConfig["appid"],
        Noncestr = FiveCloudSDK:RandomStr(16),
        Timestamp = timestamp
    }
    if playerid then
        params["Dotaid"] = PlayerResource:GetSteamAccountID(playerid)
    else
        params["Dotaid"] = 0
    end

    for k, v in pairs(data) do
        k = string.gsub(k, "^%l", string.upper)
        params[k] = v
    end

    return params
end

local function MakeSign(data)
    local str = ""
    local keys = {}
    local signature = ""

    for k in pairs(data) do
        table.insert(keys, k)
    end

    table.sort(keys)

    for _, k in pairs(keys) do
        local v = data[k]
        if str == "" then
            str = str .. k .. "=" .. tostring(v)
        else
            str = str .. "&" .. k .. "=" .. tostring(v)
        end
    end

    signature = md5.sumhexa(str .. "&key=" .. GetDedicatedServerKeyV3(FiveCloudConfig["requestKey"]))

    data["signature"] = signature

    return data
end

-- 发送http请求，有时候超时httpcode会获取到0，自动重发
-- @param methon string 请求方法
-- @param url string 请求地址
-- @param data table 请求数据
-- @param callback function 回调函数
-- @param retry int
-- @param kv_files array kv文件,{"kv1.txt","kv2.txt"}
local function Request(methon, url, data, callback, retry)
    local str = DoUniqueString("request") .." | ".. url
    retry = retry or 0
    if string.sub(url, 1, 4) ~= "http" then
        url = FiveCloudConfig["baseUrl"] .. url
    end
    FiveCloudSDK:TimeStart(str)
    FiveCloudSDK:Print(url, "开始发送请求")
    local req = CreateHTTPRequestScriptVM(methon, url)
    req:SetHTTPRequestHeaderValue('Content-Type', 'application/json;charset=uft-8')
    if methon == "POST" then
        req:SetHTTPRequestRawPostBody('application/json;charset=utf-8', json.encode(data))
    end
    req:SetHTTPRequestAbsoluteTimeoutMS(3000)
    req:Send(function(res)
        FiveCloudSDK:Print(res)
        FiveCloudSDK:TimeEnd(str)
        if res.StatusCode == 0 and retry < 5 then
            GameRules:GetGameModeEntity():SetContextThink(str, function()
                return Request(methon, url, data, callback, retry + 1)
            end, 3)
        end
        if res.StatusCode == 200 then
            local data = json.decode(res.Body)
            if callback then
                callback(data)
            end
        end
    end)
end

function FiveCloudSDK:HttpGet(url, callback)
    Request("GET", url, nil, callback)
end

function FiveCloudSDK:HttpPost(url, data, callback)
    Request("POST", url, data, callback)
end

-- 会自动上传dotaid
function FiveCloudSDK:HttpPostWithSign(url, playerid, data, callback)
    local MakeData = MakeData(playerid, data)
    local MakeSign = MakeSign(MakeData)
    self:HttpPost(url, MakeSign, callback)
end

