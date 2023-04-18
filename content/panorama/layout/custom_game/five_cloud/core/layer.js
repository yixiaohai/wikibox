'use strict';

class FiveCloudLayer {
    constructor(options) {
        this.layers = {}
        this.open_layers = []
    }

    // 缓存面板
    // @param panel panel
    // @param layer_name string 面板名称，唯一
    // @param panel_type string 面板类型，同类型面板只能同时打开一个
    Load(panel, layer_name, panel_type) {
        panel_type = panel_type || 'default'
        this.layers[panel_type] = this.layers[panel_type] || []
        panel.layer_name = layer_name
        panel.panel_type = panel_type
        this.layers[panel_type].push(panel)
    }

    // 开启某个面板
    // @param layer_name string 面板名称，唯一
    // @param panel_type string 面板类型，可选
    Open(layer_name, panel_type) {
        let panel = this.Get(layer_name, panel_type)
        if (panel && panel.BHasClass('minimized')) {
            let onopen = panel.onopen
            panel_type = panel_type || panel.panel_type
            this.CloseAll(panel_type)
            panel.RemoveClass('minimized')
            if (typeof onopen == 'function') {
                onopen()
            }
            this.open_layers.push(panel)
        }
    }

    // 关闭某个窗口
    // @param layer_name string 面板名称，唯一
    // @param panel_type string 面板类型，可选
    Close(layer_name, panel_type) {
        let panel = this.Get(layer_name, panel_type)
        if (panel && !panel.BHasClass('minimized')) {
            let onclose = panel.onclose
            panel.AddClass('minimized')
            if (typeof onclose == 'function') {
                onclose()
            }
            let index = this.open_layers.findIndex(element => element.layer_name == layer_name)
            if (index >= 0) {
                this.open_layers.splice(index, 1)
            }
        }
    }

    // 获取某个窗口是否开启
    // @param layer_name string 面板名称，唯一
    // @param panel_type string 面板类型，可选
    IsOpen(layer_name, panel_type) {
        let panel = this.Get(layer_name, panel_type)
        if (panel) {
            return !panel.BHasClass('minimized')
        } else {
            return false
        }
    }

    // 切换某个窗口
    // @param layer_name string 面板名称，唯一
    // @param panel_type string 面板类型，可选
    Toggle(layer_name, panel_type) {
        let panel = this.Get(layer_name, panel_type)
        if (panel) {
            if (panel.BHasClass('minimized')) {
                this.Open(layer_name, panel_type)
            } else {
                this.Close(layer_name, panel_type)
            }
        }
    }

    // 获取某个面板
    // @param layer_name string 面板名称，唯一
    // @param panel_type string 面板类型，可选
    Get(layer_name, panel_type) {
        let result
        if (panel_type && this.layers[panel_type]) {
            this.layers[panel_type].forEach(element => {
                if (element.layer_name == layer_name) {
                    result = element
                }
            })
        } else {
            for (let i in this.layers) {
                let arr = this.layers[i]
                arr.forEach(element => {
                    if (element.layer_name == layer_name) {
                        result = element
                    }
                })
            }
        }
        return result
    }

    // 关闭某个类型的窗口
    // @param panel_type string 面板类型
    CloseAll(panel_type) {
        for (let e in this.open_layers) {
            if (this.open_layers[e].panel_type == panel_type) {
                this.Close(this.open_layers[e].layer_name, panel_type)
            }
        }
    }

    // 显示Dota的tooltip
    // @param panel string 面板
    // @param text string 要显示的内容
    // @param title string 面板标题
    HoverDOTATooltip(panel, text, title) {
        if (panel) {
            text = GameUI.FiveCloudLocalize.CustomLocalize(text)
            panel.SetPanelEvent('onmouseover', function () {
                if (title) {
                    $.DispatchEvent('DOTAShowTitleTextTooltip', panel, title, text)
                } else {
                    $.DispatchEvent('DOTAShowTextTooltip', panel, text)
                }
            })

            panel.SetPanelEvent('onmouseout', function () {
                $.DispatchEvent('DOTAHideTextTooltip')
                $.DispatchEvent('DOTAHideTitleTextTooltip')
            })
        }
    }

    // Dota默认的错误提示
    Error(text, sound) {
        let new_text = GameUI.FiveCloudLocalize.CustomLocalize(text)
        sound = sound || ''
        GameUI.SendCustomHUDError(new_text, sound)
    }
}

GameUI.FiveCloudLayer = new FiveCloudLayer()


