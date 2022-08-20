--how long you want the thing to last for. in seconds.
local announcestring = false
local lastfor = 5
local display = false

--DO NOT TOUCH BELOW THIS LINE OR YOU /WILL/ FUCK SHIT UP.
--DO NOT BE STUPID AND WHINE TO ME ABOUT THIS BEING BROKEN IF YOU TOUCHED THE LINES BELOW.

local function Initialize(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_RANKUP_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString("~y~Announcement")
    PushScaleformMovieFunctionParameterString(announcestring)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

local function ActivateThread()
    if announcestring then
        CreateThread(function()
        while display do
            Wait(0)
            --if announcestring then
                scaleform = Initialize("mp_big_message_freemode")
                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            --end
        end
        end)
    end
end

RegisterNetEvent('oznamenie')
announcestring = false
AddEventHandler('oznamenie', function(msg)
	announcestring = msg
    display = true
    ActivateThread()
	PlaySoundFrontend(-1, "MP_AWARD","HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	Wait(lastfor * 5000)
    display = false
	announcestring = false
    ActivateThread()
end)

TriggerEvent('chat:addSuggestion', '/Announcement', 'Announcement for whole server (Admins only)', {
    { name="Text", help="Into announcement fits about 150 chars" }
})
