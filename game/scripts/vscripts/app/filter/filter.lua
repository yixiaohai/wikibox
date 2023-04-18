if not Filter then
    Filter = class({})
end

function Filter:ModifierGainedFilter(e)
    local parent = EntIndexToHScript(e.entindex_parent_const)
    if parent:IsHero() then
        Omg:ShowScepterAbility(parent)
    end
    return true
end