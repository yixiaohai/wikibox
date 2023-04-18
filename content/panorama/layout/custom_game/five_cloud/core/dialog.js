'use strict';

class FiveCloudDialog {
    constructor(options) {
        let panel = GameUI.FiveCloudSDK.CreateRouter('dialog','dialog','five_cloud/core/')

        this.constructor.control_title = panel.FindChildTraverse('Title')
        this.constructor.control_input = panel.FindChildTraverse('Input')
        this.constructor.control_error = panel.FindChildTraverse('Error')
        this.constructor.control_reset = panel.FindChildTraverse('Reset')
        this.constructor.control_describe = panel.FindChildTraverse('Describe')


        panel.FindChildTraverse('Ok').SetPanelEvent('onactivate', () => {
            this.constructor.Ok()
        })

        panel.FindChildTraverse('Reset').SetPanelEvent('onactivate', () => {
            this.constructor.Reset()
        })

        panel.FindChildTraverse('Cancel').SetPanelEvent('onactivate', () => {
            this.constructor.Close()
        })

        this.constructor.control_input.SetPanelEvent('oncancel', () => {
            this.constructor.Close()
        })
    }
    // 加载一个窗口信息
    // @param name string 窗口名称
    // @param options object 配置信息
    Init(name, options) {
        this.constructor[name] = {}
        this.constructor[name].title = options.title
        this.constructor[name].describe = options.describe
        this.constructor[name].ok_function = options.ok_function
        this.constructor[name].defaultValue = options.defaultValue
        this.constructor[name].rule = options.rule
    }
    static GetInput() {
        return this.control_input.text
    }
    // 设置错误提示
    // @param e string 错误提示内容
    static SetErrorInfo(e) {
        this.control_error.text = GameUI.FiveCloudLocalize.CustomLocalize(e)
        if (e == null || e == '') {
            this.control_error.style.visibility = 'collapse'
        } else {
            this.control_error.style.visibility = 'visible'
        }
    }
    // 校验
    static Verification() {
        let result = true
        if (this.rule) {
            let type = typeof this.rule
            if (type == 'function') {
                this.rule()
            } else if (type == 'string') {
                if (this.rule == 'number') {
                    if (isNaN(Number(this.control_input.text))) {
                        this.SetErrorInfo('请输入数字')
                        result = false
                    }
                }
            }
        }
        return result
    }
    static Ok() {
        if (this.Verification()) {
            this.ok_function()
            this.Close()
        }
    }
    static Reset() {
        this.control_input.text = this.defaultValue || ''
    }
    static Close() {
        $.DispatchEvent('DropInputFocus')
        GameUI.FiveCloudLayer.Close('dialog', 'dialog')
    }
    // 打开一个窗口信息
    // @param name string 窗口名称
    static Open(name) {

        if (this[name] == undefined) {
            GameUI.FiveCloudLayer.Error('[' + name + ']窗口未初始化', '')
            return
        }
        this.control_title.text = GameUI.FiveCloudLocalize.CustomLocalize(this[name].title)
        if (this[name].describe) {
            this.control_describe.text = GameUI.FiveCloudLocalize.CustomLocalize(this[name].describe)
        }

        this.defaultValue = this[name].defaultValue
        this.ok_function = this[name].ok_function
        this.rule = this[name].rule

        this.SetErrorInfo()
        this.Reset()

        GameUI.FiveCloudLayer.Open('dialog', 'dialog')
        this.control_input.SetFocus()
    }
    Open(name) {
        this.constructor.Open(name)
    }
}

GameUI.FiveCloudDialog = new FiveCloudDialog()