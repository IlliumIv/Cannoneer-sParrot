function CooldownStarted(device)
	local usableDeviceId = avatar.GetActiveUsableDevice()
	if usableDeviceId and device.id == usableDeviceId then
		local deviceInfo = avatar.GetUsableDeviceInfo(usableDeviceId)
		if deviceInfo then
			local deviceName = userMods.FromWString(deviceInfo.name)
			local isCannon = string.find(deviceName, "cannon") or string.find(deviceName, "Cannon") or string.find(deviceName, "пушка") or string.find(deviceName, "Пушка")
			if isCannon then
				avatar.DeactivateUsableDevice()
			end
		end
	end
end

function ActiveActionChanged(device)
	local usableDeviceId = avatar.GetActiveUsableDevice()
	if usableDeviceId and device.id == usableDeviceId then
		local deviceInfo = avatar.GetUsableDeviceInfo(usableDeviceId)
		if deviceInfo then
			local deviceName = userMods.FromWString(deviceInfo.name)
			local isArtillery = string.find(deviceName, "artillery") or string.find(deviceName, "Artillery") or string.find(deviceName, "лучемёт") or string.find(deviceName, "Лучемёт")
			if isArtillery and deviceInfo.actions[2].active then
				avatar.DeactivateUsableDevice()
			end
		end
	end
end

function Init()
	common.UnRegisterEventHandler(Init, "EVENT_AVATAR_CREATED")
	common.RegisterEventHandler(CooldownStarted, "EVENT_DEVICE_COOLDOWN_STARTED")
	common.RegisterEventHandler(ActiveActionChanged, "EVENT_DEVICE_ACTIVE_ACTION_CHANGED")
end

common.RegisterEventHandler(Init, "EVENT_AVATAR_CREATED")
if avatar.IsExist() then Init() end