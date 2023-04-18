local profiling = {}
local function ProfilingReport(funcinfo)
    local name = funcinfo.name or 'anonymous'
    local line = funcinfo.linedefined or 0
    local source = funcinfo.short_src or 'C_FUNC'
    local key = name .. source .. line

    local report = profiling.debug_profiling_report_key[key]
    if not report then
        report = {
            funcinfo = funcinfo,
            callcount = 0,
            totaltime = 0
        }
        profiling.debug_profiling_report_key[key] = report
        table.insert(profiling.debug_profiling_report, report)
    end
    return report
end

local function ProfilingTitle(funcinfo)
    local name = funcinfo.name or 'anonymous'
    local line = string.format("%d", funcinfo.linedefined or 0)
    local source = funcinfo.short_src or 'C_FUNC'
    return string.format("%-30s | %s: %s", name, source, line)
end

local function ProfilingCall(funcinfo)
    local report = ProfilingReport(funcinfo)
    report.calltime = GetSystemTimeMS()
    report.callcount = report.callcount + 1
end

local function ProfilingReturn(funcinfo)
    local stoptime = GetSystemTimeMS()
    local report = ProfilingReport(funcinfo)
    if report.calltime and report.calltime > 0 then
        report.totaltime = report.totaltime + (stoptime - report.calltime)
        report.calltime = 0
    end
end

local function ProfilingHandler(hooktype)
    local funcinfo = debug.getinfo(2, 'nS')
    if hooktype == "call" then
        ProfilingCall(funcinfo)
    elseif hooktype == "return" then
        ProfilingReturn(funcinfo)
    end
end

-- 开始性能分析
function FiveCloudSDK:ProfilingStart()
    profiling.debug_profiling_report = profiling.debug_profiling_report or {}
    profiling.debug_profiling_report_key = profiling.debug_profiling_report_key or {}
    profiling.debug_profiling_start_time = profiling.debug_profiling_start_time or GetSystemTimeMS()
    debug.sethook(ProfilingHandler, 'cr', 0)
end

-- 结束性能分析
function FiveCloudSDK:ProfilingStop()
    debug.sethook()

    self:ProfilingReadReport()
end

-- 打印性能分析报考
function FiveCloudSDK:ProfilingReadReport()
    local totaltime = GetSystemTimeMS() - profiling.debug_profiling_start_time

    table.sort(profiling.debug_profiling_report, function(a, b)
        if a.totaltime ~= b.totaltime then
            return a.totaltime > b.totaltime
        end
        if a.callcount ~= b.callcount then
            return a.callcount > b.callcount
        end
        return false
    end)

    FiveCloudSDK:Print(
        "--------------------------------------------- profiling report start ---------------------------------------------",
        nil, false)
    FiveCloudSDK:Print(string.format("%10s | %6s | %10s | %-30s | %s", "totaltime", "percent", "callcount", "function",
        "source"), nil, false)
    local num = FiveCloudConfig.profilingNum
    local n = 0
    for _, report in ipairs(profiling.debug_profiling_report) do
        local percent = 0
        if report.totaltime > 0 and n < num and report.funcinfo.name then
            percent = (report.totaltime / totaltime) * 100
            n = n + 1
            FiveCloudSDK:Print(string.format("%8.3fms | %6.2f%% | %10d | %s", report.totaltime, percent,
                report.callcount, ProfilingTitle(report.funcinfo)), nil, false)
        end
    end

    FiveCloudSDK:Print(
        "---------------------------------------------- profiling report end ----------------------------------------------",
        nil, false)

end
