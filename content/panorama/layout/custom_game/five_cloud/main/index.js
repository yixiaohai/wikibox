'use strict';

(function () {
	GameUI.FiveCloudLocalize.SetPack()

	GameUI.FiveCloudSDK.CreateRouter('topmenu')
	GameUI.FiveCloudSDK.CreateRouter('message')
	GameUI.FiveCloudSDK.CreateRouter('toolcommon', 'left')
	GameUI.FiveCloudSDK.CreateRouter('tooldeveloper', 'left')
	GameUI.FiveCloudSDK.CreateRouter('heropick', 'center')
	GameUI.FiveCloudSDK.CreateRouter('unitpick', 'center')
	GameUI.FiveCloudSDK.CreateRouter('entinfo', 'right')
	GameUI.FiveCloudSDK.CreateRouter('entkv', 'right')
	GameUI.FiveCloudSDK.CreateRouter('editkv', 'center')
	GameUI.FiveCloudSDK.CreateRouter('feedback', 'center')
	GameUI.FiveCloudSDK.CreateRouter('mailbox', 'center')
	
	GameUI.FiveCloudLocalize.Start()
	GameUI.FiveCloudToggleButton.Start()

	GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'OnJsCompleted' })
})();

// 鼠标响应
GameUI.SetMouseCallback(function (eventName, arg) {
	if (GameUI.FiveCloudConfig.mouseClickListen) {
		switch (GameUI.FiveCloudConfig.currentAction) {
			case 'MoveToPoint':
				if (eventName == 'pressed') {
					// Left-click is move to position
					if (arg === 0 && GameUI.GetClickBehaviors() === 0) {
						let coordinates = GameUI.GetScreenWorldPosition(GameUI.GetCursorPosition());
						if (coordinates != null) {
							let pos = {
								x: coordinates[0],
								y: coordinates[1],
								z: coordinates[2]
							}

							GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'MoveToPoint', pos })
							GameUI.FiveCloudConfig.mouseClickListen = false
						}
					}
					// 右键
					if (arg === 1 && GameUI.GetClickBehaviors() === 0) {
						GameUI.FiveCloudConfig.currentAction = ''
						GameUI.FiveCloudConfig.mouseClickListen = false
					}
				}
				break
			default:
				if (eventName == 'pressed') {
					if (arg === 0 && GameUI.GetClickBehaviors() === 0) {
						GameUI.FiveCloudLayer.CloseAll('center')
						GameUI.FiveCloudConfig.mouseClickListen = false
					}
					// 右键
					if (arg === 1 && GameUI.GetClickBehaviors() === 0) {

					}
				}
				break
		}
	}

	return false;
})