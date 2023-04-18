'use strict';

(function () {

    GameUI.FiveCloudDialog.Init('FindAllInSphere', {
        title: '#FindAllInSphere',
        defaultValue: 0,
        rule: 'number',
        describe: '#FindAllInSphereDescribe',
        ok_function: function () {
            let v = Number(this.GetInput())
            GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'FindAllInSphere', v: v })
        }
    })

})();
