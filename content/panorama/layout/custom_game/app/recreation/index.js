'use strict';

let HideSkill = () => {
    let panel = $('#HideSkill')
    GameUI.FiveCloudSDK.SendCustomGameEvent('app_event', { event: 'HideSkill', checked: panel.checked })
}

let ShowHideSkillOption = () => {
    GameUI.FiveCloudLayer.Toggle('hideskilloption', 'center')
    GameUI.FiveCloudConfig.mouseClickListen = true
}

let ShowAddWoodenStake = () => {
    GameUI.FiveCloudLayer.Toggle('woodenstake', 'center')
    GameUI.FiveCloudConfig.mouseClickListen = true
}

let AddCustomAbility = (ability_name) => {
    GameUI.FiveCloudSDK.SendCustomGameEvent('app_event', { event: 'AddCustomAbility', ability_name: ability_name })
}

(function () {
    GameUI.FiveCloudLayer.HoverDOTATooltip($('#AddCunstomAbility1'), '#AddCunstomAbility1Describe')
    GameUI.FiveCloudLayer.HoverDOTATooltip($('#AddCunstomAbility2'), '#AddCunstomAbility2Describe')
})();
