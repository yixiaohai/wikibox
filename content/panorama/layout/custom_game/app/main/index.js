'use strict';


(function () {

	let path_game = 'app/'

	GameUI.FiveCloudSDK.CreateRouter('hideskilloption', 'center', path_game)
	GameUI.FiveCloudSDK.CreateRouter('woodenstake', 'center', path_game)
	GameUI.FiveCloudSDK.CreateRouter('recreation', 'left', path_game)
	GameUI.FiveCloudSDK.CreateRouter('quickcommands', 'left', path_game)
	GameUI.FiveCloudSDK.CreateRouter('toolnativemap', 'left', path_game)

	GameUI.FiveCloudSDK.AddTopMenu(
		's2r://panorama/images/hud/reborn/icon_combat_log_psd.vtex',
		'CombatLogButton',
		()=>{$.DispatchEvent('DOTAHUDToggleCombatLog')},
		0,
		'#DOTA_HUD_CombatLog'
	)

	GameUI.FiveCloudSDK.AddTopMenu(
		'file://{resources}/layout/custom_game/app/images/toolnativemap.png',
		'toolNativeMapButton',
		()=>{GameUI.FiveCloudLayer.Toggle('toolnativemap', 'left')},
		21
	)

	if (!GameUI.FiveCloudConfig.IsDedicatedServer){
		GameUI.FiveCloudSDK.AddTopMenu(
			'file://{resources}/layout/custom_game/app/images/quickcommands.png',
			'quickCommandsButton',
			()=>{GameUI.FiveCloudLayer.Toggle('quickcommands', 'left')},
			22
		)
    }

	GameUI.FiveCloudSDK.AddTopMenu(
		'file://{resources}/layout/custom_game/app/images/recreation.png',
		'recreationButton',
		()=>{GameUI.FiveCloudLayer.Toggle('recreation', 'left')},
		23
	)

	GameUI.FiveCloudSDK.AddTopMenu(
        'file://{resources}/layout/custom_game/five_cloud/images/wiki.png',
        'wikiButton',
        () => { $.DispatchEvent('ExternalBrowserGoToURL', 'http://dota.huijiwiki.com/p/140255') },
        50
    )

	GameUI.FiveCloudSDK.DrawTopMenu()
})();
