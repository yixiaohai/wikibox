'use strict';

let ent = null
let prevEnt = null
let schedule = null


let UpdateServerStatus = (data) => {
	if (data && data.name == 'EntKVButton') {
		if (data.data) {
			if (data.kvType == 2){
				ent = Players.GetLocalPlayerPortraitUnit()
				prevEnt = ent
			}
			EntKVStart()
		} else {
			if (schedule) {
				$.CancelScheduled(schedule)
				schedule = null
			}
		}
	}
}

let EntKVStart = () => {
	UpdateEnt()
	schedule = $.Schedule(0, EntKVStart)
}

let UpdateEnt = () => {
	ent = Players.GetLocalPlayerPortraitUnit()
	if (ent != prevEnt) {
		prevEnt = ent
		GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'GetEntKV', ent: ent })
	}
}

let Close = () => {
	GameUI.FiveCloudLayer.Close('entkv', 'right')
}

let UpdateEntKV = (data) => {

	let kv = data

	let ordered = {}
	Object.keys(kv).sort((a, b) => {
		if (typeof (kv[a]) == 'object') {
			return 1
		} else if (typeof (kv[b]) == 'object') {
			return -1
		} else {
			return GameUI.FiveCloudSDK.Compare(a, b)
		}
	}).forEach(function (key) {
		ordered[key] = kv[key];
	})

	$('#EntKVContet').RemoveAndDeleteChildren()

	let cowCenter = $.CreatePanel('Label', $('#EntKVContet'), '')
	cowCenter.AddClass('fc-info-kv-cow-center')
	cowCenter.text = data.FiveCloud_Title

	for (let key in ordered) {
		if (key != 'FiveCloud_Title') {
			CreateShowKVPanel(key, kv[key], $('#EntKVContet'))
		}
	}
}

let CreateShowKVPanel = (k, v, panel) => {
	if (typeof (v) == 'object') {
		let row = $.CreatePanel('Panel', panel, '')
		row.AddClass('fc-info-kv-object')
		let cowCenter = $.CreatePanel('Label', row, '')
		cowCenter.AddClass('fc-info-kv-cow-center')
		cowCenter.text = k
		for (let key in v) {
			CreateShowKVPanel(key, v[key], row)
		}
	} else {
		let cow = $.CreatePanel('Panel', panel, '')
		cow.AddClass('fc-info-kv-cow')
		let cow_left = $.CreatePanel('Label', cow, '')
		cow_left.AddClass('fc-info-kv-cow-left')
		cow_left.text = k
		let cow_right = $.CreatePanel('Label', cow, '')
		cow_right.AddClass('fc-info-kv-cow-right')
		cow_right.text = v
	}
}

let OnClose = () => {
	GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'GetEntKVEnd' })
}

(function () {
	let context_panel = $.GetContextPanel()
	context_panel.onclose = OnClose

	GameEvents.Subscribe('UpdateServerStatus', UpdateServerStatus)
	GameEvents.Subscribe('UpdateEntKV', UpdateEntKV)
})();
