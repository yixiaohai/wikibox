'use strict';

(function () {

    GameUI.FiveCloudDialog.Init('MinimapMisclickTime', {
        title: '#MinimapMisclickTime',
        defaultValue: 0,
        rule: 'number',
        describe: '#MinimapMisclickTimeDescribe',
        ok_function: function () {
            let v = Number(this.GetInput())
            GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'SendToServerConsole', command: 'dota_minimap_misclick_time ' + v })
        }
    })
   
})();
