'use strict';

let MailList = (data) => {
	$('#MailList').RemoveAndDeleteChildren()
	if (data.status) {
		if (data.list) {
			let num = 0
			for (const key in data.list) {
				if (Object.hasOwnProperty.call(data.list, key)) {
					const element = data.list[key];
					const title = element.title
					const excerpt = element.excerpt
					const isRead = element.isRead
					const content = element.content
					const date = element.updateAt

					let read = isRead == 1 ? '已读' : '未读'

					let panel = $.CreatePanel('Panel', $('#MailList'), '')
					panel.BLoadLayoutSnippet('mail')
					panel.GetChild(0).text = title
					panel.GetChild(1).text = excerpt
					panel.GetChild(2).text = read
					panel.GetChild(3).text = date
					panel.SetPanelEvent('onactivate', () => {
						$('#MailContent').text = content
						GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_system_event', { event: 'ReadMail', id: element.id })

						$('#DeleteButton').RemoveClass('minimized')
						$('#DeleteButton').SetPanelEvent('onactivate', () => {
							GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_system_event', { event: 'DeleteMail', id: element.id })
							panel.DeleteAsync(0)
							$('#MailContent').text = ''
							$('#DeleteButton').AddClass('minimized')
							num--
							MailCount(num)
						})
					})

					num++
				}
			}
			MailCount(num)
		}
	} else {
		$('#MailContent').text = '获取右键失败'
	}
}

let MailCount = (num) =>{
	if (num == 0){
		$('#MailContent').text = '暂无邮件'
	}
}

let OnOpen = () => {
	GameUI.FiveCloudConfig.mouseClickListen = true
	GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_system_event', { event: 'GetMailList' })
}

(function () {
	let context_panel = $.GetContextPanel()
	context_panel.onopen = OnOpen

	GameEvents.Subscribe('MailList', MailList)
})();
