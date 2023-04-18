'use strict';

let SelectHeroList = [
    'legion_commander',
    'skeleton_king',
    'centaur',
    'tiny',
    'axe',
    'slardar',
    'sven',
    'sand_king',
    'tidehunter',
    'huskar',
    'magnataur',
    'riki',
    'nyx_assassin',
    'dazzle',
    'lina',
    'lion',
    'windrunner',
    'vengefulspirit',
    'ogre_magi',
    'earth_spirit',
    'tusk',
    'pudge',
    'kunkka',
    'chaos_knight',
    'alchemist',
    'primal_beast',
    'mars',
    'dragon_knight',
    'hoodwink',
    'faceless_void',
    'earthshaker',
    'disruptor'
]

let SelectHeroCategoryImgSelectAll = () => {
    let SelectHeroCategoryImgList = $('#HideSkillHeroCategory')
    for (let i = 0; i < SelectHeroCategoryImgList.GetChildCount(); i++) {
        let SelectHeroCategoryImg = SelectHeroCategoryImgList.GetChild(i).GetChild(0)
        SelectHeroCategoryImg.checked = 1
        SelectHeroCategoryImg.AddClass('active')
    }
}

let SelectHeroCategoryImgSelectBack = () => {
    let SelectHeroCategoryImgList = $('#HideSkillHeroCategory')
    for (var i = 0; i < SelectHeroCategoryImgList.GetChildCount(); i++) {
        let SelectHeroCategoryImg = SelectHeroCategoryImgList.GetChild(i).GetChild(0)
        if (SelectHeroCategoryImg.checked == 1) {
            SelectHeroCategoryImg.checked = 0
            SelectHeroCategoryImg.RemoveClass('active')
        } else {
            SelectHeroCategoryImg.checked = 1
            SelectHeroCategoryImg.AddClass('active')
        }
    }
}

let HideSkillOptionOk = () => {
    let data = {}
    let invisRadioButton = $('#invis').GetChild(0)
    let blinkRadioButton = $('#blink').GetChild(0)
    let delayRadioButton = $('#delay').GetChild(0)
    data.invis = invisRadioButton.GetSelectedButton().tabindex
    data.blink = blinkRadioButton.GetSelectedButton().tabindex
    data.delay = delayRadioButton.GetSelectedButton().tabindex
    let SelectHeroCategoryImgList = $('#HideSkillHeroCategory')
    for (var i = 0; i < SelectHeroCategoryImgList.GetChildCount(); i++) {
        let SelectHeroCategoryImg = SelectHeroCategoryImgList.GetChild(i).GetChild(0)
        data[SelectHeroCategoryImg.heroname] = SelectHeroCategoryImg.checked
    }

    GameUI.FiveCloudSDK.SendCustomGameEvent('app_event', { event: 'HideSkillOption', data: data })

    GameUI.FiveCloudLayer.Close('hideskilloption', 'center')
}

let HideSkillOptionReset = () => {
    SelectHeroCategoryImgSelectAll()
    $('#invis').GetChild(2).checked = true
    $('#blink').GetChild(2).checked = true
    $('#delay').GetChild(0).checked = true
}

let HideSkillOptionCancel = () => {
    GameUI.FiveCloudLayer.Close('hideskilloption', 'center')
}

(function () {
    $('#HideSkillHeroCategory').RemoveAndDeleteChildren()

    for (let i = 0; i < SelectHeroList.length; i++) {
        let SelectHeroCategoryImgPanel = $.CreatePanel('Panel', $('#HideSkillHeroCategory'), '')
        SelectHeroCategoryImgPanel.BLoadLayoutSnippet('SelectHeroCategoryImgPanel')
        let SelectHeroCategoryImg = SelectHeroCategoryImgPanel.GetChild(0)
        SelectHeroCategoryImg.heroname = 'npc_dota_hero_' + SelectHeroList[i]
        SelectHeroCategoryImg.checked = 1
        SelectHeroCategoryImgPanel.SetPanelEvent('onactivate', function () {
            if (SelectHeroCategoryImg.checked == 1) {
                SelectHeroCategoryImg.checked = 0
                SelectHeroCategoryImgPanel.GetChild(0).RemoveClass('active')
            } else {
                SelectHeroCategoryImg.checked = 1
                SelectHeroCategoryImgPanel.GetChild(0).AddClass('active')
            }
        })
    }

    $('#invis').GetChild(2).checked = true
    $('#blink').GetChild(2).checked = true
    $('#delay').GetChild(0).checked = true

})();
