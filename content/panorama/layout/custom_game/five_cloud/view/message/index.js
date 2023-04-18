'use strict';

let CustomHUDError = (data) => {
	GameUI.FiveCloudLayer.Error(data.v, '')
}

(function () {
	GameEvents.Subscribe('CustomHUDError', CustomHUDError)
})();
