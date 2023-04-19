if not IsInToolsMode() and FiveCloudConfig["isCloudMode"] and FiveCloudConfig["IsDedicatedServer"] and
    FiveCloudConfig["debugOnline"] then
    FiveCloudSDK:DebugOnline()
end
