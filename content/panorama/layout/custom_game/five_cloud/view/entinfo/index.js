'use strict';

let ent = null
let prevEnt = null
let schedule = null



let UpdateServerStatus = (data) => {
	if (data && data.name == 'EntInfoButton') {
		if (data.data) {
			EntInfoStart()
		} else {
			if (schedule) {
				$.CancelScheduled(schedule)
				schedule = null
			}
		}
	}
}

let EntInfoStart = () => {
	UpdateEnt()
	schedule = $.Schedule(0, EntInfoStart)
}

let UpdateEnt = () => {
	ent = Players.GetLocalPlayerPortraitUnit()
	if (ent != prevEnt) {
		prevEnt = ent
		GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'GetEntInfoStart', ent: ent, updateServerStatus: false })
		GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'GetAbilityList', ent: ent })
	}
}

let UpdateEntInfo = (data) => {
	UpdateEnt()
	if (data && ent && ent != -1) {
		$('#entId').text = ent
		$('#GetBaseDamage').text = data['GetBaseDamageMin'] + ' - ' + data['GetBaseDamageMax']
		$('#Health').text = data['GetHealth'] + ' / ' + data['GetMaxHealth']
		$('#Mana').text = data['GetMana'] + ' / ' + data['GetMaxMana']
		for (const key in data) {
			let panel = $('#' + key + '')
			if (panel) {
				let v = data[key]
				if (typeof v == 'number') {
					v = v.toFixed(2)
				}
				if (key == 'GetAbsOrigin') {
					let t = data[key].split(' ')
					v = parseFloat(t[0]).toFixed(2) + ' | ' + parseFloat(t[1]).toFixed(2) + ' | ' + parseFloat(t[2]).toFixed(2)
				}
				if (key == 'HasFlyingVision' || key == 'CanBeSeenByAnyOpposingTeam') {
					if (v == 1) {
						v = '#True'
					} else {
						v = '#False'
					}
				}

				$('#' + key + '').text = GameUI.FiveCloudLocalize.CustomLocalize(v)
			}
		}

		UpdateBuffs(ent)
	}
}

let Close = () => {
	GameUI.FiveCloudLayer.Close('entinfo', 'right')
}

let RefreshServerAbility = (data) => {
	let abilityList = data.abilityList
	ClearAbilityPanel()
	let i = 0
	for (const key in abilityList) {
		if (Object.hasOwnProperty.call(abilityList, key)) {
			const abilityid = abilityList[key];
			let ability = $('#Abilities').GetChild(i)
			i++
			if (ability) {
				if (abilityid == -1) {
					ability.visible = false
				} else {
					let abilityImg = ability.GetChild(0)
					let abilityButton = ability.GetChild(1)
					let abilityName = Abilities.GetAbilityName(abilityid)
					abilityImg.contextEntityIndex = abilityid
					if (abilityName == "") {
						ability.visible = false
					} else {
						ability.visible = true
						abilityImg.SetPanelEvent('onmouseover', function () {
							$.DispatchEvent('DOTAShowAbilityTooltip', abilityImg, abilityName)
						})
						abilityImg.SetPanelEvent('onmouseout', function () {
							$.DispatchEvent('DOTAHideAbilityTooltip')
						})
						abilityImg.SetPanelEvent('onactivate', function () {
							GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', {
								event: 'GetEntKV',
								abilityName: abilityName,
								kvType: 2,
								updateServerStatus: true
							})
							Close()
							GameUI.FiveCloudLayer.Toggle('entkv', 'right')
						})
						abilityButton.SetPanelEvent('onactivate', function () {
							GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', {
								event: 'GetEntKV',
								ent: ent,
								abilityName: abilityName,
								kvType: 2,
								updateServerStatus: false
							})
							GameUI.FiveCloudLayer.Toggle('editkv', 'center')
						})
					}
				}
			}
		}
	}
}

let ClearAbilityPanel = () => {
	for (let i = 0; i < GameUI.FiveCloudConfig.heroMaxAbilityNum - 1; i++) {
		let ability = $("#Abilities").GetChild(i)
		ability.visible = false
	}
}


let UpdateBuffs = (ent) => {

	var num = Entities.GetNumBuffs(ent)
	var BuffList = $('#BuffList');
	$('#Modifiers').text = 'Modifiers ( ' + num + ' )'

	$('#BuffList').RemoveAndDeleteChildren()

	for (var i = 0; i < num; i++) {
		var buffSerial = Entities.GetBuff(ent, i);
		if (buffSerial == -1)
			continue;

		let buff = $.CreatePanel('Panel', BuffList, '');
		buff.AddClass('fc-info-row')
		let buffLabel = $.CreatePanel('Label', buff, '');
		buffLabel.AddClass('fc-info-cow-right')

		let buffName = Buffs.GetName(ent, buffSerial);
		let buffLabelText = buffName;
		let GetStackCount = Buffs.GetStackCount(ent, buffSerial);
		if (GetStackCount > 0) {
			buffLabelText += ' (' + GetStackCount + ')';
		}
		let GetDuration = Buffs.GetDuration(ent, buffSerial);
		let GetRemainingTime = Buffs.GetRemainingTime(ent, buffSerial).toFixed(2);

		if (GetDuration > 0) {
			buffLabelText += ' | ' + GetRemainingTime;
		}

		buffLabel.text = buffLabelText

		buff.SetPanelEvent('onactivate', function () {
			GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', {
				event: 'Say',
				v: buffLabelText
			})
		})
	}
}

let OnOpen = () => {
	let ent = Players.GetLocalPlayerPortraitUnit()
	GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'GetEntInfoStart', ent: ent, updateServerStatus: true })
	GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'GetAbilityList', ent: ent })
}

let OnClose = () => {
	GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'GetEntInfoEnd' })
}

(function () {
	let context_panel = $.GetContextPanel()
	context_panel.onopen = OnOpen
	context_panel.onclose = OnClose

	// 初始化技能面板
	for (let i = 0; i < GameUI.FiveCloudConfig.heroMaxAbilityNum - 1; i++) {
		let AbilityPanel = $.CreatePanel('Panel', $('#Abilities'), '')
		AbilityPanel.AddClass('fc-info-ability')
		AbilityPanel.BLoadLayoutSnippet('ability')
		AbilityPanel.visible = false
	}

	GameEvents.Subscribe('UpdateServerStatus', UpdateServerStatus)
	GameEvents.Subscribe('UpdateEntInfo', UpdateEntInfo)
	GameEvents.Subscribe("RefreshServerAbility", RefreshServerAbility)
})();


