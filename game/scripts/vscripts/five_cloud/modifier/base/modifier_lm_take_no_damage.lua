modifier_lm_take_no_damage = class({
    IsHidden = function(self)
        return true
    end,
    IsPurgable = function(self)
        return false
    end,
    IsDebuff = function(self)
        return false
    end,
    RemoveOnDeath = function(self)
        return false
    end,
    GetTexture = function(self)
        return "modifier_invulnerable"
    end,
    DeclareFunctions = function(self)
        local funcs = {MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL, MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
                       MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE}
        return funcs
    end,
    GetAbsoluteNoDamageMagical = function(self)
        return 1
    end,
    GetAbsoluteNoDamagePhysical = function(self)
        return 1
    end,
    GetAbsoluteNoDamagePure = function(self)
        return 1
    end
})

local public = modifier_lm_take_no_damage

function public:OnCreated()
    if IsServer() then
        local parent = self:GetParent()
        local particle = ParticleManager:CreateParticle(
            "panorama/layout/custom_game/five_cloud/particles/custom/custom_glyph_creeps_tube.vpcf",
            PATTACH_ABSORIGIN_FOLLOW, parent)
        self.particle = particle
        ParticleManager:SetParticleControl(particle, 2, Vector(parent:GetModelScale(), 0, 0))
    end
end

function public:OnRemoved()
    if IsServer() then
        local particle = self.particle
        ParticleManager:DestroyParticle(particle, true)
        ParticleManager:ReleaseParticleIndex(particle)
    end
end
