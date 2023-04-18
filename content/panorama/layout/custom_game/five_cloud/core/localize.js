'use strict';

class FiveCloudLocalize {
    constructor(options) {
        this.constructor.languagePack = {}
        this.constructor.PanelList = []
        this.constructor.pack = {}
    }

    Init(language, pack) {
        this.constructor.languagePack[language] = pack
    }

    SetPack() {
        let result = this.constructor.languagePack['schinese']
        let pack = this.constructor.languagePack[GameUI.FiveCloudConfig.language]
        if (pack) {
            result = pack
        }
    
        for (let k in result) {
            let t = k.toUpperCase()
            result[t] = result[k]
            Reflect.deleteProperty(result, k);
        }
        this.constructor.pack = result
    }


    static GetLabel(panel) {
        let num = panel.GetChildCount()
        if (num > 0) {
            for (let index = 0; index < num; index++) {
                const element = panel.GetChild(index)
                if (element.paneltype == 'Label') {
                    this.PanelList.push(element)
                } else {
                    this.GetLabel(element)
                }
            }
        }
    }

    static LabelLocalize() {
        this.PanelList.forEach(element => {
            if (GameUI.FiveCloudConfig.language == 'english'){
                element.AddClass('english')
            }
            let l_text = this.CustomLocalize(element.text)
            if (l_text != element.text) {
                element.text = l_text
            }
        })
    }

    static CustomLocalize(text) {
        let new_text
        if (text && text[0] == '#') {
            new_text = text.slice(1).toUpperCase()
        }
        let result = this.pack[new_text] || $.Localize(text)
        return result
    }

    CustomLocalize(text) {
        return this.constructor.CustomLocalize(text)
    }

    Start() {
        let context_panel = GameUI.FiveCloudConfig.CustomUIPanel
        this.constructor.GetLabel(context_panel)
        this.constructor.LabelLocalize()
    }
}

GameUI.FiveCloudLocalize = new FiveCloudLocalize()
