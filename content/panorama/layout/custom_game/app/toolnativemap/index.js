'use strict';

let SaveState = () => {
    let data = {}
    data.EasyBuy = GameUI.FiveCloudToggleButton.GetToggleButton('EasyBuy').checked
    data.FreeSpells = GameUI.FiveCloudToggleButton.GetToggleButton('FreeSpells').checked
    data.HeroFastRespawn = GameUI.FiveCloudToggleButton.GetToggleButton('HeroFastRespawn').checked
    data.HeroSituRespawn = GameUI.FiveCloudToggleButton.GetToggleButton('HeroSituRespawn').checked
    data.PassiveGold = GameUI.FiveCloudToggleButton.GetToggleButton('PassiveGold').checked
    data.NoFogOfWar = GameUI.FiveCloudToggleButton.GetToggleButton('NoFogOfWar').checked
    data.NoSpawnCreeps = GameUI.FiveCloudToggleButton.GetToggleButton('NoSpawnCreeps').checked
    data.WatchTowerHidden = GameUI.FiveCloudToggleButton.GetToggleButton('WatchTowerHidden').checked
    data.BuildHidden = GameUI.FiveCloudToggleButton.GetToggleButton('BuildHidden').checked
    data.BuildingInvulnerability = GameUI.FiveCloudToggleButton.GetToggleButton('BuildingInvulnerability').checked  

    
    GameUI.FiveCloudSDK.SendCustomGameEvent('app_event',{ event: 'SaveState' , data : data})
}

let MoveCameraToHero = () => {
    GameUI.MoveCameraToEntity( Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer()) )
}


(function () {

    GameUI.FiveCloudDialog.Init('RoshanUpgradeRate', {
        title: '#RoshanUpgradeRate',
        defaultValue: 0,
        rule: 'number',
        describe: '#RoshanUpgradeRateDescribe',
        ok_function: function () {
            let v = Number(this.GetInput())
            GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'SendToServerConsole', command: 'dota_roshan_upgrade_rate ' + v })
        }
    })

    GameUI.FiveCloudToggleButton.Start()

    GameUI.FiveCloudLayer.HoverDOTATooltip($('#NeutralcampRefreshRange'), '#NeutralcampRefreshRangeDescribe')
    GameUI.FiveCloudLayer.HoverDOTATooltip($('#DotaSpawnNeutrals'), '#DotaSpawnNeutralsDescribe')
    GameUI.FiveCloudLayer.HoverDOTATooltip($('#NoSpawnCreeps'), '#NoSpawnCreepsDescribe')
    GameUI.FiveCloudLayer.HoverDOTATooltip($('#ForceGameStart'), '#ForceGameStartDescribe')
   
    GameEvents.Subscribe('MoveCameraToHero', MoveCameraToHero)

})();
