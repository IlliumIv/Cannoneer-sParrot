function Shot()
	local deviceId = avatar.GetActiveUsableDevice()
	local deviceInfo = avatar.GetUsableDeviceInfo(deviceId)
	if deviceInfo then
		local deviceName = userMods.FromWString(deviceInfo.name)
		deviceName = string.lower(deviceName)
		local isCannon = string.find(deviceName, "cannon") or string.find(deviceName, "пушка")
		if isCannon then
			avatar.DeactivateUsableDevice()
		end
	end
end

function Init()
	common.UnRegisterEventHandler(Init, "EVENT_AVATAR_CREATED")
	common.RegisterEventHandler(Shot, "EVENT_CANNON_SHOT_STARTED")
end

common.RegisterEventHandler(Init, "EVENT_AVATAR_CREATED")
if avatar.IsExist() then Init() end