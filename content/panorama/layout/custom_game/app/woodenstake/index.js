'use strict';

let AddWoodenStake = (heroname, abilityName) => {
    GameUI.FiveCloudLayer.Close('woodenstake', 'center')
    GameUI.FiveCloudSDK.SendCustomGameEvent('app_event', { event: 'AddWoodenStake', heroname: heroname, abilityName: abilityName })
}

function AddWoodenStakeOther(type) {
    GameUI.FiveCloudLayer.Close('woodenstake', 'center')
    GameUI.FiveCloudSDK.SendCustomGameEvent('app_event', { event: 'AddWoodenStakeOther', type: type })
}


(function () {

})();
