'use strict';

let ShowTopMenu = () => {

    if (GameUI.FiveCloudConfig.isDebugMode){
        GameUI.FiveCloudSDK.AddTopMenu(
            'file://{resources}/layout/custom_game/five_cloud/images/toolcommon.png',
            'toolCommonButton',
            () => { GameUI.FiveCloudLayer.Toggle('toolcommon', 'left') },
            10
        )
    
        if (Game.IsInToolsMode()) {
            GameUI.FiveCloudSDK.AddTopMenu(
                'file://{resources}/layout/custom_game/five_cloud/images/tooldeveloper.png',
                'toolDeveloperButton',
                () => { GameUI.FiveCloudLayer.Toggle('tooldeveloper', 'left') },
                20
            )
        }
    }

    if (GameUI.FiveCloudConfig.isCloudMode && GameUI.FiveCloudConfig.IsDedicatedServer) {
        GameUI.FiveCloudSDK.AddTopMenu(
            'file://{resources}/layout/custom_game/five_cloud/images/feedback.png',
            'feedbackButton',
            () => { GameUI.FiveCloudLayer.Toggle('feedback', 'center') },
            30
        )

        GameUI.FiveCloudSDK.AddTopMenu(
            'file://{resources}/layout/custom_game/five_cloud/images/mailbox.png',
            'mailboxButton',
            () => { GameUI.FiveCloudLayer.Toggle('mailbox', 'center') },
            40
        )
    }

    GameUI.FiveCloudSDK.DrawTopMenu()

    $.Schedule(2, function () {
        GameUI.FiveCloudLayer.Open('topmenu', 'topmenu')
    })
}

(function () {
    GameEvents.Subscribe('ShowTopMenu', ShowTopMenu)
})();
