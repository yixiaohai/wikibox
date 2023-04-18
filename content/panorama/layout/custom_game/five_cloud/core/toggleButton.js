'use strict';

class FiveCloudToggleButton {
    constructor(options) {
        this.constructor.PanelList = []
    }

    static CreateToggleButtonList(panel) {
        let num = panel.GetChildCount()
        if (num > 0) {
            for (let index = 0; index < num; index++) {
                const element = panel.GetChild(index)
                if (element.paneltype == 'ToggleButton') {
                    this.PanelList.push(element)
                } else {
                    this.CreateToggleButtonList(element)
                }
            }
        }
    }

    Toggle(id, status) {
        let panel = this.GetToggleButton(id)
        if (panel){
            panel.checked = status
        }
    }

    // 发送自定义ToggleButton事件,eventName需要事件名称和按钮的ID一致
    // @param eventName string 事件名称
    SendToggleEvent(eventName, eventClass) {
        eventClass = eventClass || 'five_cloud_custom_event'
        let panel = this.GetToggleButton(eventName)
        if (panel){
            let data = {
                event: eventName,
                checked: panel.checked
            }
            GameUI.FiveCloudSDK.SendCustomGameEvent(eventClass, data)
        }
    }

    GetToggleButton(id) {
        let panel = this.constructor.PanelList.find(item => item.id == id)
        return panel
    }

    Start() {
        let context_panel = GameUI.FiveCloudConfig.CustomUIPanel
        this.constructor.PanelList = []
        this.constructor.CreateToggleButtonList(context_panel)
    }
}

GameUI.FiveCloudToggleButton = new FiveCloudToggleButton()

let UpdateServerStatus = (data) => {
	let status = data.data == 1 ? true : false
	GameUI.FiveCloudToggleButton.Toggle(data.name, status)
}

GameEvents.Subscribe('UpdateServerStatus', UpdateServerStatus)