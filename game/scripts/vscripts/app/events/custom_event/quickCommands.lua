-- tab选中单位设置
function AppEvent:SelectionGroups(e)
    if e.checked == 1 then
        SendToConsole("dota_selection_groups false")
    else
        SendToConsole("dota_selection_groups true")
    end

end

-- 克隆操作
function AppEvent:SmartMultiunitCast(e)
    if e.checked == 1 then
        SendToConsole("dota_player_smart_multiunit_cast 1")
    else
        SendToConsole("dota_player_smart_multiunit_cast 0")
    end
end

-- 小地图右键
function AppEvent:MinimapDisableRightclick(e)
    if e.checked == 1 then
        SendToConsole("dota_minimap_disable_rightclick 1")
    else
        SendToConsole("dota_minimap_disable_rightclick 0")
    end
end


