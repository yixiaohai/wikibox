'use strict';

class FiveCloudConfig {
    constructor(options) {
        this.heroMaxAbilityNum = 35
        this.heroMaxInventoryNum = 17
        this.isDebugMode = false
        this.isCloudMode = false
        this.IsDedicatedServer = false
        this.CustomUIPanel = $.GetContextPanel().GetParent().GetParent().GetParent()
        this.rootPanel = this.CustomUIPanel.GetParent()
        this.currentAction = ''
        this.mouseClickListen = false
        this.language = $.Language()
    }

    // 更新配置数据
    // @param data object
    UpdateConfig(data) {
        this.heroMaxAbilityNum = data.heroMaxAbilityNum || this.heroMaxAbilityNum
        this.heroMaxInventoryNum = data.heroMaxInventoryNum || this.heroMaxInventoryNum
        this.isDebugMode = data.isDebugMode ? Boolean(data.isDebugMode) : this.isDebugMode
        this.isCloudMode = data.isCloudMode ? Boolean(data.isCloudMode) : this.isCloudMode
        this.IsDedicatedServer = data.IsDedicatedServer ? Boolean(data.IsDedicatedServer) : this.IsDedicatedServer
    }

}

GameUI.FiveCloudConfig = new FiveCloudConfig()

let FiveCloud_UpdateConfig = (data) => {
    GameUI.FiveCloudConfig.UpdateConfig(data)
}

GameEvents.Subscribe('FiveCloud_UpdateConfig', FiveCloud_UpdateConfig)