local Utils = require("utils")

Utils.Log("Enabled Feature: OP English subtitles")

local Subs = nil
local TIME_SHIFT = -100

-- Convenience function to change the subtitle widget to the given text at the specific time
local function DisplaySubs(Subs, Seconds, Centiseconds, Lyrics)
    local totalMillis = math.floor(Seconds * 1000 + Centiseconds * 10 + TIME_SHIFT);

	ExecuteWithDelay(totalMillis, function()
		Subs:OpenSubtitle(FText(Lyrics))
		Subs:AnimeIn(0)
	end)
end

local function WBP_Movie_C__OpenMovie(Param_WBP_Movie_C, Param_NewParam)
	-- Only trigger if we're playing the English OP
	local Movie = Param_NewParam:get():ToString()
	local OP = "op_STEAM_en.mp4"

	if string.sub(Movie, -#OP) ~= OP then return end

	local WBP_Movie_C = Param_WBP_Movie_C:get()
	WBP_Movie_C.bIsSkip = false

	Subs = StaticConstructObject(StaticFindObject("/Game/MadeInAbyss/UI/Sequence/WBP_SequenceText.WBP_SequenceText_C"),
			WBP_Movie_C, 0, 0, 0, nil, false, false, nil)

	if not Subs:IsValid() then
		Utils.Log("Unable to create Subtitle Widget")
		return
	end

	Subs:AddToViewport(1)

	-- I really hope this doesn't go too out of sync lol
	-- Lyrics translated with DeepL, edited by me
	DisplaySubs(Subs, 22, 42, "As dawn breaks over the city")
	DisplaySubs(Subs, 26, 40, "We begin to move silently")
	DisplaySubs(Subs, 29, 82, "Our hearts are beating faster today")
	DisplaySubs(Subs, 33, 32, "Than it did yesterday")
	DisplaySubs(Subs, 37, 32, "All right now, let's join hands")
	DisplaySubs(Subs, 40, 80, "And leave all our hesitations behind")
	DisplaySubs(Subs, 43, 41, "We'll move forward to the direction the compass points to")
	DisplaySubs(Subs, 49, 41, "Towards the very end of the Abyss")
	DisplaySubs(Subs, 53, 97, "As if lured by the darkness within")
	DisplaySubs(Subs, 57, 63, "If this will change everything,")
	DisplaySubs(Subs, 61, 28, "We wouldn't mind that")
	DisplaySubs(Subs, 63, 86, "Even if the glimmer of hope")
	DisplaySubs(Subs, 67, 62, "No longer reaches us")
	DisplaySubs(Subs, 72, 32, "We'll shine it brightly ourselves")
	DisplaySubs(Subs, 74, 62, "That's right--using our own hands")
	DisplaySubs(Subs, 77, 75, "In this journey of no return")
	DisplaySubs(Subs, 81, 34, "To get the answers that we've been looking for")
	DisplaySubs(Subs, 88, 48, "")
end

-- Hook during the game thread as anything before that is too early and wouldn't hook
ExecuteInGameThread(function()
    RegisterHook("/Game/MadeInAbyss/Media/WBP_Movie.WBP_Movie_C:OpenMovie", WBP_Movie_C__OpenMovie)
end)