-- 创建幻象
function FiveCloudSystemEvent:OnIllusionSpawn(unit)
    if FiveCloudConfig["isIllusionInheritAbility"] then
        local owner = unit:GetPlayerOwner():GetAssignedHero()
        local abilityConut = FiveCloudConfig["heroMaxAbilityNum"]
        for i = 0, abilityConut - 1 do
            local unitAbility = unit:GetAbilityByIndex(i)
            local ownerAbility = owner:GetAbilityByIndex(i)
            if unitAbility and not unitAbility:IsNull() then
                local unitAbilityName = unitAbility:GetAbilityName()
                if unitAbilityName ~= "dawnbreaker_luminosity" then
                    Omg:SetAbilityDiable(unitAbility)
                    Omg:RemoveAbilityModifier(unit, unitAbility)
                    unit:RemoveAbility(unitAbilityName)
                end
            end
            if ownerAbility and not ownerAbility:IsNull() then
                local ownerAbilityName = ownerAbility:GetAbilityName()
                if ownerAbilityName ~= "dawnbreaker_luminosity" then
                    unit:AddAbility(ownerAbilityName)
                end
            end
        end
    end
end
