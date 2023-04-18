let CreateUnit = (unit) => {
  let action = GameUI.FiveCloudConfig.currentAction

  if (action == 'AddUnit_Friend') {
    GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'CreateUnit', unit: unit, isFriend: true })
  }
  if (action == 'AddUnit_Enemy') {
    GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'CreateUnit', unit: unit, isFriend: false })
  }
  GameUI.FiveCloudLayer.Close('unitpick', 'center')
}

(function () {

})();

