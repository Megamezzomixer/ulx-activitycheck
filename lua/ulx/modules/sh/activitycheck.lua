local CATEGORY_NAME = "Utility"

if !file.Exists( "ulx", "DATA" ) then
	file.CreateDir( "ulx" )
end

if !file.Exists( "ulx/activitycheck", "DATA" ) then
	file.CreateDir( "ulx/activitycheck" )
end


function ulx.activitycheck(calling_ply, target_ply)

	if target_ply == nil then return end
	
	hours = math.floor(target_ply:TimeConnected() / 3600)
	minutes = math.floor((target_ply:TimeConnected() / 60) % 60)
	seconds = math.floor(target_ply:TimeConnected() % 60)
	if hours > 0 then
		ULib.tsay(calling_ply,  target_ply:GetName() .. " has a playtime of " .. hours .. " hours, " ..  minutes .. " minutes and " ..  seconds .. " seconds in this session.")
	elseif minutes > 0 then
		ULib.tsay(calling_ply,  target_ply:GetName() .. " has a playtime of " .. minutes .. " minutes and " ..  seconds .. " seconds in this session.")
	else
		ULib.tsay(calling_ply,  target_ply:GetName() .. " has a playtime of " .. seconds .. " seconds in this session.")
	end
	
	
	
	-- Nearly same code as activitycheckid.
	sidaltered = string.Replace(string.lower(target_ply:SteamID()), ":", "_")
	if !file.Exists("ulx/activitycheck/"..sidaltered..".txt", "DATA") then
		ULib.tsayError(calling_ply, "This user has no previous activity record.")
		return
	end
	
	returnVal = string.Split(file.Read("ulx/activitycheck/"..sidaltered..".txt"), ",")
	hours = math.floor(returnVal[1] / 3600)
	minutes = math.floor((returnVal[1] / 60) % 60)
	seconds = math.floor(returnVal[1] % 60)
	if hours > 0 then
		ULib.tsay(calling_ply,  target_ply:GetName() .. " has a playtime of " .. hours .. " hours, " ..  minutes .. " minutes and " ..  seconds .. " seconds in the last session.\nThe last session was at " .. returnVal[2])
	elseif minutes > 0 then
		ULib.tsay(calling_ply,  target_ply:GetName() .. " has a playtime of " .. minutes .. " minutes and " ..  seconds .. " seconds in the last session.\nThe last session was at " .. returnVal[2])
	else
		ULib.tsay(calling_ply,  target_ply:GetName() .. " has a playtime of " .. seconds .. " seconds in the last session.\nThe last session was at " .. returnVal[2])
	end
	
	

end
local activitycheck = ulx.command(CATEGORY_NAME, "ulx activitycheck", ulx.activitycheck, "!activitycheck")
activitycheck:addParam{type=ULib.cmds.PlayerArg}
activitycheck:defaultAccess(ULib.ACCESS_SUPERADMIN)
activitycheck:help("Get information about user activity")


function ulx.activitycheckid(calling_ply, steamid)

	sidaltered = string.Replace(string.lower(steamid), ":", "_")
	if !file.Exists("ulx/activitycheck/"..sidaltered..".txt", "DATA") then
		ULib.tsayError(calling_ply, "This SteamID has no previous activity record.")
		return
	end
	
	returnVal = string.Split(file.Read("ulx/activitycheck/"..sidaltered..".txt"), ",")
	hours = math.floor(returnVal[1] / 3600)
	minutes = math.floor((returnVal[1] / 60) % 60)
	seconds = math.floor(returnVal[1] % 60)
	if hours > 0 then
		ULib.tsay(calling_ply,  steamid .. " has a playtime of " .. hours .. " hours, " ..  minutes .. " minutes and " ..  seconds .. " seconds in the last session.\nThe last session was at " .. returnVal[2])
	elseif minutes > 0 then
		ULib.tsay(calling_ply,  steamid .. " has a playtime of " .. minutes .. " minutes and " ..  seconds .. " seconds in the last session.\nThe last session was at " .. returnVal[2])
	else
		ULib.tsay(calling_ply,  steamid .. " has a playtime of " .. seconds .. " seconds in the last session.\nThe last session was at " .. returnVal[2])
	end
end

local activitycheckid = ulx.command(CATEGORY_NAME, "ulx activitycheckid", ulx.activitycheckid)
activitycheckid:addParam{type=ULib.cmds.StringArg, hint="steamid", ULib.cmds.takeRestOfLine}
activitycheckid:defaultAccess(ULib.ACCESS_SUPERADMIN)
activitycheckid:help("Get information about user activity using a steamid")
