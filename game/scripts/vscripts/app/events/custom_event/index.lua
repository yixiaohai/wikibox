if AppEvent == nil then
    AppEvent = class({})
    AppEvent.TowerDayVisionRangeParticle = {}
    AppEvent.TowerNightVisionRangeParticle = {}
    AppEvent.TowerHateRangeParticle = {}
end

require("app.events.custom_event.map")
require("app.events.custom_event.recreation")
require("app.events.custom_event.range")
require("app.events.custom_event.quickCommands")
require("app.events.custom_event.system")

function AppEvent:Index(e)
    if type(AppEvent[e.event]) == "function" then
        AppEvent[e.event](self, e)
    else
        FiveCloudSDK:Message("#NoFunction event : " .. e.event, e.playerid, "info")
    end
end

