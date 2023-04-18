'use strict';

let PickHero = (heroid) => {
	let action = GameUI.FiveCloudConfig.currentAction
	if (action == 'ReplaceHero') {
		GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'ReplaceHero', heroid: heroid })
		GameUI.FiveCloudLayer.Close('heropick', 'center')
	}
	if (action == 'AddHero_Friend') {
		GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'AddHero', isFriend: true, heroid: heroid })
		GameUI.FiveCloudLayer.Close('heropick', 'center')
	}
	if (action == 'AddHero_Enemy') {
		GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'AddHero', isFriend: false, heroid: heroid })
		GameUI.FiveCloudLayer.Close('heropick', 'center')
	}
	if (action == 'ReplaceAbility') {
		GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'GetHeroKVByHeroId', heroid: heroid })
	}
}

let OnOpen = () => {
	let action = GameUI.FiveCloudConfig.currentAction
	if (action == 'ReplaceAbility') {
		GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event',{ event: 'GetAbilityList'})
		$('#AbilityAdd').visible = true
		$('#AbilityExisting').visible = true
	} else {
		$('#AbilityAdd').visible = false
		$('#AbilityExisting').visible = false
	}
}

let replaceHeroid = -1

let ToHeroKVById = (data) => {
	let HeroKVById = data.data

	for (let i = 0; i < GameUI.FiveCloudConfig.heroMaxAbilityNum - 1; i++) {
		let tempAbility = HeroKVById['Ability' + (i + 1)]
		let ability = $("#AbilityAdd").GetChild(i)
		if (tempAbility) {
			if (tempAbility.indexOf('special_bonus_') == -1 && tempAbility != 'generic_hidden') {
				let abilityImg = ability.GetChild(0)

				abilityImg.abilityname = tempAbility
				ability.visible = true
				abilityImg.SetPanelEvent("onmouseover", function () {
					$.DispatchEvent("DOTAShowAbilityTooltip", abilityImg, tempAbility)
				})
				abilityImg.SetPanelEvent("onmouseout", function () {
					$.DispatchEvent("DOTAHideAbilityTooltip")
				})
				ability.SetPanelEvent("onactivate", function () {
					GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', {
						event: 'AddAbility',
						replaceHeroid: replaceHeroid,
						abilityname: tempAbility
					})
				})
			} else {
				ability.visible = false
			}
		} else {
			ability.visible = false
		}
	}
}

let RefreshServerAbility = (data) => {
	let playerid = Players.GetLocalPlayer()
	replaceHeroid = Players.GetSelectedEntities(playerid)[0]
	let abilityList = data.abilityList
	for (let index = 0; index < GameUI.FiveCloudConfig.heroMaxAbilityNum - 1; index++) {
		let ability = Entities.GetAbility(replaceHeroid, index)
	}
	let i = 0
	ClearExistingAbilityPanel()
	for (const key in abilityList) {
		if (Object.hasOwnProperty.call(abilityList, key)) {
			const abilityid = abilityList[key];
			let ability = $("#AbilityExisting").GetChild(i)
			i++
			if (abilityid && ability) {
				let abilityImg = ability.GetChild(0)
				let abilityname = Abilities.GetAbilityName(abilityid)

				ability.abilityname = abilityname
				abilityImg.contextEntityIndex = abilityid

				if (abilityname.indexOf('special_bonus_') >= 0 || abilityname == "generic_hidden" || abilityname == "") {
					ability.visible = false
				} else {
					ability.visible = true
					abilityImg.SetPanelEvent("onmouseover", function () {
						$.DispatchEvent("DOTAShowAbilityTooltip", abilityImg, abilityname)
					})
					abilityImg.SetPanelEvent("onmouseout", function () {
						$.DispatchEvent("DOTAHideAbilityTooltip")
					})
					ability.SetPanelEvent("onactivate", function () {
						ability.visible = false
						GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', {
							event: 'RemoveAbility',
							replaceHeroid: replaceHeroid,
							abilityname: abilityname
						})
					})
				}
			}
		}
	}
}

let ClearExistingAbilityPanel = () => {
	for (let i = 0; i < GameUI.FiveCloudConfig.heroMaxAbilityNum - 1; i++) {
		let ability = $("#AbilityExisting").GetChild(i)
		ability.visible = false
	}
}

// 注册拖拽事件
let RegisterSlotEvent = (slot) => {
	slot.SetDraggable(true);
	$.RegisterEventHandler('DragStart', slot, OnDragStart);
	$.RegisterEventHandler('DragDrop', slot, OnDragDrop);
	$.RegisterEventHandler('DragEnd', slot, OnDragEnd);
}

// 开始拖动
// panel 被拖动的那个DOTAItemImage
// draggedPanel 拖出来的东西
let OnDragStart = (panel, draggedPanel) => {
	$.DispatchEvent("DOTAHideAbilityTooltip")

	var displayPanel = $.CreatePanel("DOTAAbilityImage", panel, "")
	displayPanel.abilityname = panel.GetChild(0).abilityname

	draggedPanel.displayPanel = displayPanel;
	draggedPanel.offsetX = 0
	draggedPanel.offsetY = 0
}

// 松开拖动
// panel 松开时候指向的板
// draggedPanel 拖动的板
// caster 拖动的物品 target 交换的物品
let OnDragDrop = (panel, draggedPanel) => {
	if (panel.paneltype == 'DOTAAbilityImage') {
		GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', {
			event: 'SwapAbility',
			replaceHeroid: replaceHeroid,
			ability1: panel.abilityname,
			ability2: draggedPanel.abilityname
		})
	}

}

// 拖动结束
// panel 最初的板
// draggedPanel 拖动的板
let OnDragEnd = (panel, draggedPanel) => {
	draggedPanel.DeleteAsync(0)
}

(function () {
	let context_panel = $.GetContextPanel()
	context_panel.onopen = OnOpen

	// 初始化更换技能面板
	for (let i = 0; i < GameUI.FiveCloudConfig.heroMaxAbilityNum - 1; i++) {
		let addAbilityPanel = $.CreatePanel('Panel', $("#AbilityAdd"), '')
		addAbilityPanel.AddClass('fc-ability-panel')
		addAbilityPanel.BLoadLayoutSnippet('AbilityAddContainer')
		addAbilityPanel.visible = false

		let existingAbilityPanel = $.CreatePanel('Panel', $("#AbilityExisting"), '')
		existingAbilityPanel.AddClass('fc-ability-panel')
		existingAbilityPanel.BLoadLayoutSnippet('AbilityExistingContainer')
		existingAbilityPanel.visible = false
		RegisterSlotEvent(existingAbilityPanel)
	}

	$.RegisterEventHandler('DOTAUIHeroPickerHeroSelected', $('#heropick'), PickHero)
	GameEvents.Subscribe("ToHeroKVById", ToHeroKVById)
	GameEvents.Subscribe("RefreshServerAbility", RefreshServerAbility)

})();
