if dawnbreaker_luminosity_cunstom == nil then
    dawnbreaker_luminosity_cunstom = class({})
end

function dawnbreaker_luminosity_cunstom:GetIntrinsicModifierName()
    return "modifier_dawnbreaker_luminosity_custom"
end

LinkLuaModifier( "modifier_dawnbreaker_luminosity_custom", "app/abilities/dawnbreaker_luminosity_custom", LUA_MODIFIER_MOTION_NONE )

modifier_dawnbreaker_luminosity_custom = class({
    IsHidden = function(self)
        return false
    end,
    IsPurgable = function(self)
        return false
    end,
    IsDebuff = function(self)
        return false
    end
})

function modifier_dawnbreaker_luminosity_custom:OnRefresh()
    if IsServer() then
        local parent = self:GetParent()
        local ability = self:GetAbility()
        
        if parent:HasModifier("modifier_dawnbreaker_luminosity") then
            return
        end
            
        parent:AddNewModifier(parent, ability, "modifier_dawnbreaker_luminosity",{})

        self.parent = parent
    end
end

function modifier_dawnbreaker_luminosity_custom:OnDestroy(e)
    if IsServer() then
        local parent = self.parent
        local modifier = parent:FindModifierByName("modifier_dawnbreaker_luminosity")
        if modifier then
            modifier:Destroy()
        end
    end
end
