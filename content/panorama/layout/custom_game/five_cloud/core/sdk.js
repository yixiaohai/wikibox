'use strict';

class FiveCloudSDK {
    constructor(options) {
        this.constructor.TopMenu = {}

        this.Print('\n----------------------------------------------------------------------------\n')
        this.Print(' ______  _                  _____  _                    _         _   _____')
        this.Print('|  ____|(_)                / ____|| |                  | |       | | / ____|')
        this.Print('| |__    _ __   __  ___   | |     | |  ___   _   _   __| |       | || (___')
        this.Print('|  __|  | |\\ \\ / / / _ \\  | |     | | / _ \\ | | | | / _` |   _   | | \\___ \\')
        this.Print('| |     | | \\ V / |  __/  | |____ | || (_) || |_| || (_| |  | |__| | ____) |')
        this.Print('|_|     |_|  \\_/   \\___|   \\_____||_| \\___/  \\__,_| \\__,_|   \\____/ |_____/')
        this.Print('\n----------------------------------------------------------------------------\n')

    }
    // 控制台打印
    // @param content string 消息内容
    // @param identifier string 标识符
    // @param level int 内容前的空格数量
    Print(content, identifier, level) {
        if (Game.IsInToolsMode()) {
            level = level || 0
            let tempStr = ''
            if (level > 0) {
                for (let index = 0; index < level; index++) {
                    tempStr += '\t'
                }
            }
            if (identifier) {
                identifier = identifier + ' : '
            } else {
                identifier = ''
            }
            if (typeof content == 'object') {
                $.Msg(tempStr + identifier + '{')
                for (let i in content) {
                    let v = content[i]
                    if (typeof v === 'object') {
                        this.Print(v, i, level + 1)
                    } else {
                        $.Msg(tempStr + '\t' + i.padEnd(20) + ' = ' + v + ' (' + typeof v + ')')
                    }
                }
                $.Msg(tempStr + '}')
            } else {
                $.Msg(tempStr + identifier + content)
            }
        }
    }

    // 发送自定义事件,会带上playerid和所选单位
    // @param eventName string 事件名称
    // @param data object 数据
    SendCustomGameEvent(eventName, data) {
        let playerid = Players.GetLocalPlayer()
        let selectedUnits = Players.GetSelectedEntities(playerid)
        data.playerid = playerid
        data.selectedUnits = selectedUnits
        GameEvents.SendCustomGameEventToServer(eventName, data)
    }

    Compare(a, b) {
        for (let i = 0; i < Math.min(a.length, b.length); i++) {
            const diff = a.charCodeAt(i) - b.charCodeAt(i);
            if (diff !== 0) {
                return diff;
            }
        }
        return a.length - b.length;
    }

    // 创建路由
    // @param id string 唯一标识，文件夹名称需要同名
    // @param type string 面板类型
    // @param path string 唯一标识
    // @param panel panel 父面板
    CreateRouter(id, type, path, panel) {
        type = type || id
        path = path || 'five_cloud/view/'
        panel = panel || GameUI.FiveCloudConfig.CustomUIPanel

        let temp_panel = panel.FindChildTraverse(id)
        if (!temp_panel) {
            temp_panel = $.CreatePanel('Panel', panel, id)
        }
        temp_panel.BLoadLayout('file://{resources}/layout/custom_game/' + path + id + '/index.xml', false, false)
        GameUI.FiveCloudLayer.Load(temp_panel, id, type)
        return temp_panel
    }

    AddTopMenu(imageUrl, id, func, index, text) {
        this.constructor.TopMenu[index] = {}
        this.constructor.TopMenu[index].imageUrl = imageUrl
        this.constructor.TopMenu[index].id = id
        this.constructor.TopMenu[index].func = func
        this.constructor.TopMenu[index].text = text
    }

    DrawTopMenu() {
        let topmenu = GameUI.FiveCloudLayer.Get('topmenu', 'topmenu')
        if (topmenu){
            topmenu.RemoveAndDeleteChildren()
            let object = this.constructor.TopMenu
            for (const key in object) {
                if (Object.hasOwnProperty.call(object, key)) {
                    const element = object[key];
                    let panel = $.CreatePanel('Panel', topmenu, '')
                    let panel_image = $.CreatePanel('Image', panel, element.id)
                    panel.AddClass('fc-topmenu-buttonbox')
                    panel_image.AddClass(element.id)
                    panel_image.SetImage(element.imageUrl)
                    panel.SetPanelEvent('onactivate', () => {
                        element.func()
                    })
                    let text = element.text || '#' + element.id
                    GameUI.FiveCloudLayer.HoverDOTATooltip(panel_image, $.Localize(text))
                }
            }
        }
    }

    KeyBind(hotKey, callback) {
        const cmd = 'FiveCloud_CustomKey_' + hotKey + '_' + Date.now().toString(32);
        Game.CreateCustomKeyBind(hotKey, cmd);
        Game.AddCommand(cmd, callback, '', 1 << 32);
    }
}

GameUI.FiveCloudSDK = new FiveCloudSDK()