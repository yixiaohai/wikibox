-- 控制台输出
-- @param content any 内容
-- @param identifier string 标识符
-- @param showMetatable bool 输出额外内容
function FiveCloudSDK:Print(content, identifier, extra)
    if IsInToolsMode() then
        if extra == nil then
            extra = true
        end
        local result = ""
        if extra then
            if IsClient() then
                result = result .. "客户端 | "
            end
            if IsServer() then
                result = result .. "服务端 | "
            end
        end
        if identifier then
            result = result .. identifier .. " : "
        end
        local content_string = tostring(content)
        result = result .. content_string
        if type(content) == "table" then
            result = result .. "\n----------------- " .. content_string .. " start -----------------"
            local temp_str = ""
            for k, v in pairs(content) do
                result = result .. "\n" .. string.format("%-20s", k) .. " = " .. tostring(v) .. " (" .. type(v) .. ")"
            end
            result = result .. "\n------------------ " .. content_string .. " end ------------------\n"
        end
        print(result)
    end
end

-- 控制台开始计时
-- @param identifier string 标识符
function FiveCloudSDK:TimeStart(identifier)
    identifier = identifier or "default"
    if not self.debug_time then
        self.debug_time = {}
    end
    self.debug_time[identifier] = GetSystemTimeMS()
end

-- 控制台结束
-- @param identifier string 标识符
function FiveCloudSDK:TimeEnd(identifier)
    identifier = identifier or "default"
    if not self.debug_time or not self.debug_time[identifier] then
        FiveCloudSDK:Print("未设置开始时间", "计时器错误")
        return
    end
    FiveCloudSDK:Print(identifier .. " 耗时 : " .. string.format("%.2f", GetSystemTimeMS() - self.debug_time[identifier]) .. "ms")
end

-- 上传错误日志
function FiveCloudSDK:DebugOnline()
    debug.traceback = function(thread, message, level)
        if thread then
            local e = tostring(thread)
            FiveCloudSDK:Print(e,"e")
            FiveCloudSDK:httpPostWithSign("/dota2/log/edit", nil, {
                Content = e
            }, nil)
        end
    end
end