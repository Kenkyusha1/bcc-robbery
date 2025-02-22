---------- Pulling Essentials -------------
local VORPcore = {} --Pulls vorp core
TriggerEvent("getCore", function(core)
  VORPcore = core
end)
local VORPInv = {}
VORPInv = exports.vorp_inventory:vorp_inventoryApi()
local BccUtils = exports['bcc-utils'].initiate()

-------- Job Alert Setup -----
local police_alert = exports['bcc-job-alerts']:RegisterAlert({
    name = 'banker', --The name of the alert
    command = nil, -- the command, this is what players will use with /
    message = Config.PoliceAlert.AlertMssg, -- Message to show to theh police
    messageTime = Config.PoliceAlert.ShowMssgTime, -- Time the message will stay on screen (miliseconds)
    job = Config.PoliceAlert.Job, -- Job the alert is for
    jobgrade = { 0, 1, 2, 3, 4, 5 }, -- What grades the alert will effect
    icon = "star", -- The icon the alert will use
    hash = -1282792512, -- The radius blip
    radius = 40.0, -- The size of the radius blip
    blipTime = Config.PoliceAlert.BlipTime, -- How long the blip will stay for the job (miliseconds)
    blipDelay = 5000, -- Delay time before the job is notified (miliseconds)
    originText = "", -- Text displayed to the user who enacted the command
    originTime = 0 --The time the origintext displays (miliseconds)
})

------------- Cooldown Handler thanks to Byte ----------------
local cooldowns = {}
RegisterServerEvent('bcc-robbery:ServerCooldownCheck', function(shopid, v)
    local _source = source
    if cooldowns[shopid] then --Check if the robery has a cooldown registered yet.
        local seconds = Config.RobberyCooldown
        if os.difftime(os.time(), cooldowns[shopid]) >= seconds then -- Checks the current time difference from the stored enacted time, then checks if that difference us past the seconds threshold
            cooldowns[shopid] = os.time() --Update the cooldown with the new enacted time.
            TriggerClientEvent("bcc-robbery:RobberyHandler", _source, v) --Robbery is not on cooldown
            police_alert:SendAlert(_source)
        else --robbery is on cooldown
            VORPcore.NotifyRightTip(_source, Config.Language.OnCooldown, 4000)
        end
    else
        cooldowns[shopid] = os.time() --Store the current time
        TriggerClientEvent("bcc-robbery:RobberyHandler", _source, v) --Robbery is not on cooldown
        police_alert:SendAlert(_source)
    end
end)

--------- Event to handle pay outs ----------
RegisterServerEvent('bcc-robbery:CashPayout', function(amount)
    local Character = VORPcore.getUser(source).getUsedCharacter --checks the char used
    Character.addCurrency(0, amount)
end)

RegisterServerEvent('bcc-robbery:ItemsPayout', function(itemName, itemCount)
    local Character = VORPcore.getUser(source).getUsedCharacter -- Checks the character used
    VORPInv.addItem(source, itemName, itemCount)
end)


-------- Job Restrictor Check -------
RegisterServerEvent('bcc-robbery:JobCheck', function()
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter -- Get player's character
    
    local job = false
    for k, v in pairs(Config.NoRobberyJobs) do
        if v.jobname == Character.job then
            job = true
            break -- Stop the loop if the job is found in the restricted list
        end
    end

    local policeCount = 0

    -- Calculate the number of police officers
    for _, player in ipairs(GetPlayers()) do
        local playerCharacter = VORPcore.getUser(player).getUsedCharacter
        if playerCharacter.job == "police" then
            policeCount = policeCount + 1
        end
    end

    local Inventory = exports.vorp_inventory:vorp_inventoryApi()

    if not job then
        -- Check if the player has the required item
        local count = Inventory.getItemCount(_source, Config.RequiredItem)
        if count >= 1 then
            -- Check the police count and execute the appropriate action
            if policeCount >= Config.MinimumPoliceCount then
                TriggerClientEvent('bcc-robbery:RobberyEnabler', _source)
            else
                VORPcore.NotifyRightTip(_source, Config.Language.NotEnoughPolice, 4000)
            end
        else
            VORPcore.NotifyRightTip(_source, Config.Language.NoRequiredItem, 4000)
        end
    else
        VORPcore.NotifyRightTip(_source, Config.Language.WrongJob, 4000)
    end
end)
BccUtils.Versioner.checkRelease(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-robbery')