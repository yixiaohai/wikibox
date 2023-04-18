if not FiveCloudSystemEvent then
    FiveCloudSystemEvent = class({})
end

require("five_cloud.events.system_event.feedback")
require("five_cloud.events.system_event.mail")
require("five_cloud.events.system_event.other")

function FiveCloudSystemEvent:Index(e)
    FiveCloudSDK:Print(e,"FiveCloudSystemEvent")
    if type(FiveCloudSystemEvent[e.event]) == "function" then
        FiveCloudSystemEvent[e.event](self, e)
    else
        FiveCloudSDK:Message("#NoFunction event : " .. e.event, e.playerid, "info")
    end
end


