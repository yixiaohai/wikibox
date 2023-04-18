if not App then
    App = class({})
end

require("app.config.index")
require("app.init.index")
require("app.filter.index")
require("app.events.index")
require("app.modifier.index")