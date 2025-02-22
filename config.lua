Config = {}

---------------- Main Setup ------------------------
Config.RobberyCommand = 'robbery' --command to enter to enable robberies
Config.RobberyCooldown = 3600 --This is the cooldown in seconds for each robbery meaning once a place is robbed you have to wait this long to rob it again

--These are jobs that will not be able to do robberies
Config.NoRobberyJobs = { --add as many as you want just copy paste a table
    {jobname = 'police'},
    {jobname = 'doctor'},
}
Config.RequiredItem = "lockpick"

Config.MinimumPoliceCount = 2

Config.PoliceAlert = {
    enabled = true,
    Job = 'police',
    AlertMssg = 'Robbery In Progress!',
    ShowMssgTime = 30000,
    BlipTime = 60000
}

--Lockpicking setup
Config.LockPick = {
    MaxAttemptsPerLock = 3,
    lockpickitem = 'lockpick',
    difficulty = 10,
    hintdelay = 500,
    pins = { -- hardcoded pins, if randomPins set to true, then this will be ignored.
        {
            deg = 25 -- 0-360 degrees
        },
        {
            deg = 0 -- 0-360 degrees
        },
        {
            deg = 300 -- 0-360 degrees
        }
    },
    randomPins = true --If random is set to True, then pins above will be ignored.
}

-- Main robbery setup
Config.Robberies = {
    {
        Id = 1, --this has to be unique to each robbery
        StartingCoords = {x = -322.36, y = 804.46, z = 117.88}, --coords you have to be near to start the robbery
        EnemyNpcs = true, --if true enemy npcs will spawn and attack the player
        WaitBeforeLoot = 0, --wait in ms before player can loot 0 for none
        LootLocations = { --This is the loot location setup, add as many as youd like
            {
                LootCoordinates = {x = -325.82, y = 797.02, z = 121.54}, --coordinates of the loot box
                CashReward = math.random(50, 200), --amount of cash to reward set 0 for none
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'water', --name of the item in the database
                        count = math.random(1, 10), --the amount of the item to give
                    },
                },
            },
            {
                LootCoordinates = {x = -321.37, y = 806.94, z = 117.88}, --coordinates of the loot box
                CashReward = math.random(50, 200), --amount of cash to reward
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'iron', --the name of the item in the database
                        count = math.random(1, 10), --amount to give
                    },
                },
            },
        },
        EnemyNpcCoords = { --coords where the enemy npcs will spawn add as many as youd like
            {x = -326.71, y = 801.15, z = 120.22}, --coords the peds will spawn at
            {x = -327.38, y = 807.86, z = 117.94},
        },
    },
    {
        Id = 2, --this has to be unique to each robbery
        StartingCoords = {x = -307.49, y = 778.03, z = 118.7}, --coords you have to be near to start the robbery
        EnemyNpcs = false, --if true enemy npcs will spawn and attack the player
        WaitBeforeLoot = 60000, --wait in ms before player can loot 0 for none
        LootLocations = { --This is the loot location setup, add as many as youd like
            {
                LootCoordinates = {x = -301.89, y = 772.2, z = 118.7}, --coordinates of the loot box
                CashReward = 10, --amount of cash to reward set 0 for none
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'iron', --name of the item in db
                        count = 1, --amount to give
                    },
                },
            },
        },
        EnemyNpcCoords = { --coords where the enemy npcs will spawn add as many as youd like
            {x = -325.04, y = 797.18, z = 117.88}, --coords the ped will spawn
            {x = -320.61, y = 803.24, z = 117.88},
        },
    },
}

------------------- Translate Here -----------------------
Config.Language = {
    RobberyStart = 'Robbery Started!',
    OnCooldown = 'This has been robbed recently!',
    LootMarked = 'Begin Looting!',
    HoldOutBeforeLooting = 'Wait',
    HoldOutBeforeLooting2 = 'Minutes Before Looting',
    RobberyFail = 'Robbery Failed!',
    Rob = 'LockPick',
    Robbery = 'LockBox',
    PickFailed = 'Lockpicking Failed Lock Broken',
    RobberyEnable = 'Robberies enabled shoot a gun, at a valid location to start a robbery!',
    RobberyDisable = 'Robberies Disabled',
    WrongJob = 'You can not start robberies due to your job!',
    NotEnoughPolice = "There isn't enough police.",
    NoRequiredItem = "You don't have the required item."
    
}