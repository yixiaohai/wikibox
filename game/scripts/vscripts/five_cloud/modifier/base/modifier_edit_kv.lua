modifier_edit_kv = class({
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
        return "ad_psd"
    end,
    DeclareFunctions = function(self)
        local funcs = {MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL, MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE}
        return funcs
    end
})

local public = modifier_edit_kv

function public:GetModifierOverrideAbilitySpecial(e)
    local parent = self:GetParent()
    if not parent or not e.ability then
        return 0
    end

    local ability_name = e.ability:GetAbilityName()

    local five_cloud_data = CustomNetTables:GetTableValue("edit_kv", ability_name.."_"..tostring(parent:GetEntityIndex()))

    if five_cloud_data  then
        local special_value_name = e.ability_special_value
        if five_cloud_data[special_value_name] then
            return 1
        end
    end

    return 0
end

function public:GetModifierOverrideAbilitySpecialValue(e)
    local parent = self:GetParent()
    local ability_name = e.ability:GetAbilityName()
    local special_value_name = e.ability_special_value
    local base = e.ability:GetLevelSpecialValueNoOverride(special_value_name, e.ability_special_level)
    local five_cloud_data = CustomNetTables:GetTableValue("edit_kv", ability_name.."_"..tostring(parent:GetEntityIndex()))
    if five_cloud_data then
        if five_cloud_data[special_value_name] then
            return five_cloud_data[special_value_name]
        end
    end

    return base
end
