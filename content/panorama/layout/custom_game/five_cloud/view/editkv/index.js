'use strict';

let ent = null
let five_cloud_title = ''

let Close = () => {
	GameUI.FiveCloudLayer.Close('editkv', 'center')
}

let Ok = () => {
	let edit_data = {}
	edit_data.five_cloud_title = five_cloud_title
	let count = $('#EditKVContent').GetChildCount()
	for (let index = 0; index < count; index++) {
		const element = $('#EditKVContent').GetChild(index)
		edit_data[element.GetChild(0).key] = element.GetChild(1).text
	}
	GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'EditKv', ent: ent, data: edit_data })
	Close()
}

let UpdateEntKV = (data) => {
	ent = data.FiveCloud_Ent
	five_cloud_title = data.FiveCloud_Title

	$('#Title').text = $.Localize('#DOTA_Tooltip_ability_' + data.FiveCloud_Title, $('#Title'))
	$('#EditKVContent').RemoveAndDeleteChildren()

	for (const key in data) {
		if (Object.hasOwnProperty.call(data, key)) {
			const element = data[key]

			if (key == 'FiveCloud_Ent' || key == 'ID' || key == 'HasScepterUpgrade' || key == 'HasShardUpgrade' || key == 'FightRecapLevel') {
				continue
			}
			if (typeof element != 'object') {
				CreateInput(key, element)
			}

			if (key == 'AbilityValues' || key == 'AbilitySpecial') {
				for (const key2 in element) {
					if (Object.hasOwnProperty.call(element, key2)) {
						const element2 = element[key2]
						if (typeof element2 == 'object') {
							if (element2.value) {
								if (key2 == '01') {
									CreateInput('value', element2.value)
								} else {
									CreateInput(key2, element2.value)
								}
							}
							for (const key3 in element2) {
								if (Object.hasOwnProperty.call(element2, key3)) {
									const element3 = element2[key3]
									if (key3 != 'value' && String(key3).indexOf("Tooltip") == -1
										&& key3 != 'var_type' && key3 != 'LinkedSpecialBonus'
										&& key3 != 'RequiresScepter' && key3 != 'RequiresShard'
										&& key3 != 'ad_linked_abilities') {
										CreateInput(key3, element3)
									}
								}
							}
						} else {
							CreateInput(key2, element2)
						}
					}
				}
			}
		}
	}
}

let CreateInput = (k, v) => {
	let value
	let five_cloud_data = CustomNetTables.GetTableValue('edit_kv', five_cloud_title + '_' + ent)
	if (five_cloud_data && five_cloud_data[k]) {
		value = five_cloud_data[k]
	} else {
		if (typeof v == 'number') {
			value = v
		} else {
			let arr = v.split(' ')
			value = Number(arr[arr.length - 1])
		}
		if (String(value).indexOf(".") > -1) {
			value = value.toFixed(2)
		}
		value = Number(value)
	}


	if (typeof value == 'number' && !isNaN(value)) {
		let KVPanel = $.CreatePanel('Panel', $('#EditKVContent'), '')
		KVPanel.AddClass('fc-editkv-panel')
		KVPanel.BLoadLayoutSnippet('kvinput')
		KVPanel.GetChild(0).key = k
		let str = k
		if (k == 'AbilityCastPoint' || k == 'AbilityChannelTime' || k == 'AbilityManaCost' || k == 'AbilityCastRange' || k == 'AbilityCooldown') {
			str = GameUI.FiveCloudLocalize.CustomLocalize('#' + k)
		} else {
			str = $.Localize('#DOTA_Tooltip_ability_' + k, KVPanel.GetChild(0))
		}
		if (str[0] == '#') {
			str = $.Localize('#DOTA_Tooltip_ability_' + five_cloud_title + '_' + k, KVPanel.GetChild(0))
		}
		if (str[0] == '#') {
			str = str.replace('#DOTA_Tooltip_ability_', '')
			str = str.replace(five_cloud_title + '_', '')
		}

		KVPanel.GetChild(0).text = str


		KVPanel.GetChild(1).text = value
	}

}


let OnOpen = () => {

}

let OnClose = () => {
	$.DispatchEvent('DropInputFocus')
}

(function () {
	let context_panel = $.GetContextPanel()
	context_panel.onopen = OnOpen
	context_panel.onclose = OnClose

	GameEvents.Subscribe('UpdateEntKV', UpdateEntKV)
})();