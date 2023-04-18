-- 从kv中预加载
-- @param context 上下文
-- @param kv_files array kv文件,{"kv1.txt","kv2.txt"}
function FiveCloudSDK:PrecacheEveryThingFromKV(context, kv_files)
    for _, kv in pairs(kv_files) do
        local kvs = LoadKeyValues(kv)
        if kvs then
            FiveCloudSDK:PrecacheEverythingFromTable(context, kvs)
        end
    end
end

-- 从table中预加载
-- @param context 上下文
-- @param kvtable table
function FiveCloudSDK:PrecacheEverythingFromTable(context, kvtable)
    for key, value in pairs(kvtable) do
        if type(value) == "table" then
            FiveCloudSDK:PrecacheEverythingFromTable( context, value )
        else
            if string.find(value, "vpcf") then
                PrecacheResource("particle", value, context)
            end
            if string.find(value, "vmdl") then
                PrecacheResource("model", value, context)
            end
            if string.find(value, "vsndevts") then
                PrecacheResource("soundfile", value, context)
            end
        end
    end
end
