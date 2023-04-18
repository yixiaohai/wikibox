
LinkLuaModifier("modifier_ogre_magi_multicast_custom", "app/abilities/ogre_magi_multicast_custom",
    LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ogre_magi_multicast_custom_buff", "app/abilities/ogre_magi_multicast_custom",
    LUA_MODIFIER_MOTION_NONE)

if ogre_magi_multicast_custom == nil then
    ogre_magi_multicast_custom = class({})
end

function ogre_magi_multicast_custom:GetIntrinsicModifierName()
    return "modifier_ogre_magi_multicast_custom"
end

modifier_ogre_magi_multicast_custom = class({
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
    end
})

function modifier_ogre_magi_multicast_custom:DeclareFunctions()
    local funcs = {MODIFIER_EVENT_ON_ABILITY_FULLY_CAST}

    return funcs
end

function modifier_ogre_magi_multicast_custom:OnCreated()
    if IsServer() then
        local parent = self:GetParent()
        local ability = self:GetAbility()
        local level = ability:GetLevel()
        local x2 = ability:GetLevelSpecialValueFor("multicast_2_times", level)
        local x3 = ability:GetLevelSpecialValueFor("multicast_3_times", level)
        local x4 = ability:GetLevelSpecialValueFor("multicast_4_times", level)

        self.parent = parent
        self.x2 = x2
        self.x3 = x3
        self.x4 = x4

    end
end

function modifier_ogre_magi_multicast_custom:OnAbilityFullyCast(e)
    if e.unit ~= self:GetCaster() then
        return
    end

    local parent = self.parent
    local ability = e.ability

    local casts = 1
    if RollPercentage(self.x2) then
        casts = 2
    end
    if RollPercentage(self.x3) then
        casts = 3
    end
    if RollPercentage(self.x4) then
        casts = 4
    end

    if casts > 1 then
        local target = e.target
        if target then
            target = target:entindex()
        end

        parent:AddNewModifier(parent, nil, "modifier_ogre_magi_multicast_custom_buff", -- modifier name
        {
            ability = ability:entindex(),
            target = target,
            multicast = casts
        })
    end
end

modifier_ogre_magi_multicast_custom_buff = class({
    IsHidden = function(self)
        return true
    end,
    IsPurgable = function(self)
        return false
    end,
    IsDebuff = function(self)
        return false
    end,
    IsBuff = function(self)
        return true
    end,
    RemoveOnDeath = function(self)
        return false
    end
})

function modifier_ogre_magi_multicast_custom_buff:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_ogre_magi_multicast_custom_buff:OnCreated(kv)
    if not IsServer() then
        return
    end
    local parent = self:GetParent()
    local ability = EntIndexToHScript(kv.ability)
    local target = kv.target
    local multicast = kv.multicast
    local buffer_range = 300

    if target then
        target = EntIndexToHScript(target)
    end

    self:SetStackCount(multicast)

    self.parent = parent
    self.ability = ability
    self.target = target
    self.casts = 1
    self.multicast = multicast

    if bit.band(tonumber(tostring(ability:GetBehavior())), DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ==
        DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
        self.team = parent:GetTeamNumber()
        self.cast_range = ability:GetCastRange(target:GetOrigin(), target) + buffer_range
        self.target_team = ability:GetAbilityTargetTeam()
        self.target_type = ability:GetAbilityTargetType()
        self.target_flags = ability:GetAbilityTargetFlags()
    end

    self:StartIntervalThink(0.3)
end

function modifier_ogre_magi_multicast_custom_buff:OnIntervalThink()
    local parent = self.parent
    local ability = self.ability
    local multicast = self.multicast

    if bit.band(tonumber(tostring(ability:GetBehavior())), DOTA_ABILITY_BEHAVIOR_NO_TARGET) ==
        DOTA_ABILITY_BEHAVIOR_NO_TARGET then
        ability:OnSpellStart()
        self:PlayEffects(self.casts)
        self.casts = self.casts + 1
        if self.casts >= multicast then
            self:StartIntervalThink(-1)
            self:Destroy()
        end
    end

    if bit.band(tonumber(tostring(ability:GetBehavior())), DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ==
        DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
        local target = self.target
        if target and target:IsAlive() then
        else
            local units = FindUnitsInRadius(self.team, -- int, your team number
            parent:GetOrigin(), -- point, center point
            nil, -- handle, cacheUnit. (not known)
            self.cast_range, -- float, radius. or use FIND_UNITS_EVERYWHERE
            self.target_team, -- int, team filter
            self.target_type, -- int, type filter
            self.target_flags, -- int, flag filter
            FIND_CLOSEST, -- int, order filter
            false -- bool, can grow cache
            )
            for _, unit in pairs(units) do
                if ability:CastFilterResultTarget(unit) == UF_SUCCESS then
                    target = unit
                    break
                end
            end
        end
        if not target then
            self:StartIntervalThink(-1)
            self:Destroy()
            return
        end
        parent:SetCursorCastTarget(target)
        ability:OnSpellStart()
        self:PlayEffects(self.casts)
        self.casts = self.casts + 1
        if self.casts >= multicast then
            self:StartIntervalThink(-1)
            self:Destroy()
        end
    end

    if bit.band(tonumber(tostring(ability:GetBehavior())), DOTA_ABILITY_BEHAVIOR_POINT) == DOTA_ABILITY_BEHAVIOR_POINT then
        parent:SetCursorPosition(parent:GetOrigin())
        ability:OnSpellStart()
        self:PlayEffects(self.casts)
        self.casts = self.casts + 1
        if self.casts >= multicast then
            self:StartIntervalThink(-1)
            self:Destroy()
        end
    end

end

function modifier_ogre_magi_multicast_custom_buff:PlayEffects(value)
    local particle_cast = "particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf"

    local counter_speed = 2
    if value == self.multicast then
        counter_speed = 1
    end

    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_OVERHEAD_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(value, counter_speed, 0))
    ParticleManager:ReleaseParticleIndex(effect_cast)

    -- Create Sound
    local sound = math.min(value - 1, 3)
    local sound_cast = "Hero_OgreMagi.Fireblast.x" .. sound
    if sound > 0 then
        EmitSoundOn(sound_cast, self.parent)
    end
end
