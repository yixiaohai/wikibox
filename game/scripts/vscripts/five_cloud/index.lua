if not FiveCloud then
    FiveCloud = class({})
end

require("five_cloud.sdk.index")
require("five_cloud.config.index")
require("five_cloud.extensions.index")
require("five_cloud.init.index")
require("five_cloud.modifier.index")
require("five_cloud.events.index")

FiveCloudSDK:Print("\n----------------------------------------------------------------------------------\n", nil, false)
FiveCloudSDK:Print(" ______  _                  _____  _                    _    _", nil, false)
FiveCloudSDK:Print("|  ____|(_)                / ____|| |                  | |  | |", nil, false)
FiveCloudSDK:Print("| |__    _ __   __  ___   | |     | |  ___   _   _   __| |  | |      _   _   __ _ ", nil, false)
FiveCloudSDK:Print("|  __|  | |\\ \\ / / / _ \\  | |     | | / _ \\ | | | | / _` |  | |     | | | | / _` |", nil, false)
FiveCloudSDK:Print("| |     | | \\ V / |  __/  | |____ | || (_) || |_| || (_| |  | |____ | |_| || (_| |", nil, false)
FiveCloudSDK:Print("|_|     |_|  \\_/   \\___|   \\_____||_| \\___/  \\__,_| \\__,_|  |______| \\__,_| \\__,_|", nil, false)
FiveCloudSDK:Print("\n----------------------------------------------------------------------------------\n", nil, false)
