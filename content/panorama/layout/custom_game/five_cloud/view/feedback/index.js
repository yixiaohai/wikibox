'use strict';

let Ok = () => {
	let content = $('#feedbackInput').text

	GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_system_event', { event: 'Feedback', content: content })
	Reset()
	Close()
}

function Reset() {
	$('#feedbackInput').text = ''
}

let Close = () => {
	$.DispatchEvent('DropInputFocus')
	GameUI.FiveCloudLayer.Close('feedback', 'center')
}

(function () {

})();
