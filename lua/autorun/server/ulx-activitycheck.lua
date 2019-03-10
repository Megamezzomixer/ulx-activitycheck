

function plydisconnect(ply)
	local loggedGroups = {"owner", "headadmin", "superadmin", "admin", "trialadmin", "operator", "trialoperator"} -- Groups which will be logged
	local deleteOldLogs = true -- It will delete logs from members which were in a valid group before, but aren't anymore.
	validGroup = false
	sidaltered = string.Replace(string.lower(ply:SteamID()), ":", "-") -- We need to change the steamid for file save. : is restricted in the filename.
	
	for i, v in pairs(loggedGroups) do
		if ply:GetUserGroup() == v then
			validGroup = true
			break
		end
	end
	local sessiontime = math.floor(ply:TimeConnected())
	
	if validGroup then
		if sessiontime >= 60 then
			Timestamp = os.time()
			currentDate = os.date( "%d.%m.%Y %H:%M:%S" , Timestamp )
			file.Write("ulx/activitycheck/"..sidaltered..".txt", sessiontime .. "," .. currentDate)
		end
	else
		if deleteOldLogs then
			if file.Exists("ulx/activitycheck/"..sidaltered..".txt", "DATA") then
				file.Delete("ulx/activitycheck/"..sidaltered..".txt")
				print("[ULX Activitycheck] Removed obsolete log of " .. ply:SteamID())
			end
		end
	end
	
end
hook.Add("PlayerDisconnected", "activiitycheckPlayerDisconnect", plydisconnect)