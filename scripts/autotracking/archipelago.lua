-- this is an example/ default implementation for AP autotracking
-- it will use the mappings defined in item_mapping.lua and location_mapping.lua to track items and locations via thier ids
-- it will also load the AP slot data in the global SLOT_DATA, keep track of the current index of on_item messages in CUR_INDEX
-- addition it will keep track of what items are local items and which one are remote using the globals LOCAL_ITEMS and GLOBAL_ITEMS
-- this is useful since remote items will not reset but local items might
ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = nil
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}
IGNORE_CHANGE = false

function forceUpdate()
    local update = Tracker:FindObjectForCode("update")
    update.Active = not update.Active
end

function onClearHandler(slot_data)
    local clear_timer = os.clock()
    ScriptHost:RemoveWatchForCode("StateChanged")
    -- Disable tracker updates.
    Tracker.BulkUpdate = true
    -- Use a protected call so that tracker updates always get enabled again, even if an error occurred.
    local ok, err = pcall(onClear, slot_data)
    -- Enable tracker updates again.
    if ok then
        -- Defer re-enabling tracker updates until the next frame, which doesn't happen until all received items/cleared
        -- locations from AP have been processed.
        local handlerName = "AP onClearHandler"
        local function frameCallback()
            ScriptHost:AddWatchForCode("StateChanged", "*", stateChanged)
            ScriptHost:RemoveOnFrameHandler(handlerName)
            Tracker.BulkUpdate = false

            forceUpdate()
            print(string.format("Time taken total: %.2f", os.clock() - clear_timer))
        end
        ScriptHost:AddOnFrameHandler(handlerName, frameCallback)
    else
        Tracker.BulkUpdate = false
        print("Error: onClear failed:")
        print(err)
    end
end

function onClear(slot_data) 
	local onClear_timer = os.clock()
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
    end
    SLOT_DATA = slot_data
    CUR_INDEX = -1
	Tracker.BulkUpdate = true
	-- reset locations
    for _, v in pairs(LOCATION_MAPPING) do
        if v[1] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing location %s", v[1]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[1]:sub(1, 1) == "@" then
                    obj.AvailableChestCount = obj.ChestCount
                else
                    obj.Active = false
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
	-- reset items
    for _, v in pairs(ITEM_MAPPING) do
        if v[1] and v[2] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing item %s of type %s", v[1], v[2]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
					obj.Active = false
                elseif v[2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = obj.MinCount
				elseif v[2] == "non-interactive" then
                    obj.AcquiredCount = obj.MinCount
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
	Tracker.BulkUpdate = false
    LOCAL_ITEMS = {}
    GLOBAL_ITEMS = {}
    PLAYER_ID = Archipelago.PlayerNumber or -1
    TEAM_NUMBER = Archipelago.TeamNumber or 0
    print(PLAYER_ID)
    print(TEAM_NUMBER)

    if PLAYER_ID > -1 then
        --HINTS_ID = "_read_hints_"..TEAM_NUMBER.."_"..PLAYER_ID
        --DIButton = "Dragon_Monkey_DIButton"
        DIButton = "AE_DIButton_"..TEAM_NUMBER.."_"..PLAYER_ID
        CrCWaterButton = "AE_CrCWaterButton_"..TEAM_NUMBER.."_"..PLAYER_ID
        MM_Painting_Button = "AE_MM_Painting_Button_"..TEAM_NUMBER.."_"..PLAYER_ID
        MM_MonkeyHead_Button = "AE_MM_MonkeyHead_Button_"..TEAM_NUMBER.."_"..PLAYER_ID
        TVT_Lobby_Button = "AE_TVT_Lobby_Button_"..TEAM_NUMBER.."_"..PLAYER_ID
        DR_Block_Pushed = "AE_DR_Block_"..TEAM_NUMBER.."_"..PLAYER_ID

        Archipelago:SetNotify({DIButton,CrCWaterButton,MM_Painting_Button,MM_MonkeyHead_Button,TVT_Lobby_Button,DR_Block_Pushed})
        Archipelago:Get({DIButton,CrCWaterButton,MM_Painting_Button,MM_MonkeyHead_Button,TVT_Lobby_Button,DR_Block_Pushed})

    end
	-- Logic :     
		-- 0 = normal
		-- 1 = hard
		-- 2 = expert
    if SLOT_DATA == nil then
        return
    end
    if slot_data['logic'] ~= nil then
        Tracker:FindObjectForCode("op_logic").CurrentStage = slot_data['logic']
    end
	-- Coins Shuffle:
		--0 = Off
		--1 = On
    if slot_data['coin'] ~= nil then
        Tracker:FindObjectForCode("op_coins").CurrentStage = slot_data['coin']
    end
    -- Goal:
		--0 = mm
		--1 = ppm
		--2 = tokenhunt
		--3 = mmtoken

		--4 = ppmtoken
    if slot_data['goal'] ~= nil then
        Tracker:FindObjectForCode("op_goal").CurrentStage = slot_data['goal']
    end
    if slot_data['superflyer'] ~= nil then
        Tracker:FindObjectForCode("op_superflyer").CurrentStage = slot_data['superflyer']
    end

	if slot_data['requiredtokens'] ~= nil then
		requiredtokens = slot_data['requiredtokens']
		totaltokens = slot_data['totaltokens']
		if requiredtokens > totaltokens then
			Tracker:FindObjectForCode("required_tokens").AcquiredCount = totaltokens
			print("Used TotalTokens")
		else
			Tracker:FindObjectForCode("required_tokens").AcquiredCount = requiredtokens
			print("Used RequiredTokens")
		end
		
    end
	
    if slot_data['mailbox'] ~= nil then
        Tracker:FindObjectForCode("op_mailbox").CurrentStage = slot_data['mailbox']
    end
    if slot_data['infinitejump'] ~= nil then
        Tracker:FindObjectForCode("op_ij").CurrentStage = slot_data['infinitejump']
    end
    if slot_data['shufflewaternet'] ~= nil then
        Tracker:FindObjectForCode("op_waternet").CurrentStage = slot_data['shufflewaternet']
    end
	if slot_data['unlocksperkey'] ~= nil then
        Tracker:FindObjectForCode("op_keyoption").CurrentStage = slot_data['unlocksperkey']
    end
	if slot_data['shufflenet'] ~= nil then
        Tracker:FindObjectForCode("op_net").CurrentStage = slot_data['shufflenet']
    end
	--print(slot_data['entrance'])
	if slot_data['entrance'] ~= nil then
        Tracker:FindObjectForCode("op_entrance").CurrentStage = slot_data['entrance']
    end
    if slot_data['randomizestartingroom'] ~= nil then
        Tracker:FindObjectForCode("op_rsr").CurrentStage = slot_data['randomizestartingroom']
    end
	if slot_data['lamp'] == 0 or slot_data["lamp"] == nil then
		Tracker:FindObjectForCode("op_lamps").CurrentStage = 0
	else
		Tracker:FindObjectForCode("op_lamps").CurrentStage = 1
	end
    if slot_data['jacket'] == 0 or slot_data["jacket"] == nil then
		Tracker:FindObjectForCode("op_jackets").CurrentStage = 0
	else
		Tracker:FindObjectForCode("op_jackets").CurrentStage = 1
	end
	if slot_data['trainingrooms'] ~= nil then
		Tracker:FindObjectForCode("op_tr").CurrentStage = slot_data['trainingrooms']

	end
	Tracker:FindObjectForCode("ap_connected").Active = true

	
	loadAP()
	--worldUnlocks()
	print(string.format("Time taken onClear: %.2f", os.clock() - onClear_timer))
end


-- called when an item gets collected
function onItem(index, item_id, item_name, player_number)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
    end
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: could not find item mapping for id %s", item_id))
        end
        return
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: code: %s, type %s", v[1], v[2]))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: could not find object for code %s", v[1]))
    end
    -- track local items via snes interface
    if is_local then
        if LOCAL_ITEMS[v[1]] then
            LOCAL_ITEMS[v[1]] = LOCAL_ITEMS[v[1]] + 1
        else
            LOCAL_ITEMS[v[1]] = 1
        end
    else
        if GLOBAL_ITEMS[v[1]] then
            GLOBAL_ITEMS[v[1]] = GLOBAL_ITEMS[v[1]] + 1
        else
            GLOBAL_ITEMS[v[1]] = 1
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("local items: %s", dump_table(LOCAL_ITEMS)))
        print(string.format("global items: %s", dump_table(GLOBAL_ITEMS)))
    end
    if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
        -- add snes interface functions here for local item tracking
    end
    setER()
    setSR()
    worldUnlocks()
end

--called when a location gets cleared
function onLocation(location_id, location_name)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onLocation: %s, %s", location_id, location_name))
    end
    local v = LOCATION_MAPPING[location_id]
    if not v and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[1]:sub(1, 1) == "@" then
            obj.AvailableChestCount = obj.AvailableChestCount - 1
        else
            obj.Active = true
        end
		if v[2] then
			local obj2 = Tracker:FindObjectForCode(v[2])
			obj2.AcquiredCount = obj2.AcquiredCount - 1
		end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find object for code %s", v[1]))
    end

    --setER()
    --worldUnlocks()
end

-- called when a locations is scouted
function onScout(location_id, location_name, item_id, item_name, item_player)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onScout: %s, %s, %s, %s, %s", location_id, location_name, item_id, item_name,
            item_player))
    end
    -- not implemented yet :(
end

-- called when a bounce message is received 
function onBounce(json)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onBounce: %s", dump_table(json)))
    end
    -- your code goes here
end

function onNotify(key, value, old_value)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onNotify: %s, %s, %s", key, dump(value), old_value))
    end
    if value ~= old_value then
        print(key)
        if key == DR_Block_Pushed then
            if value == 1 then
              Tracker:FindObjectForCode("DR-Block").Active = true
            end
		elseif key == DIButton then
            if value == 1 then
                Tracker:FindObjectForCode("DI-Button").Active = true
            end
		elseif key == CrCWaterButton then
            if value == 1 then
                Tracker:FindObjectForCode("CC-Button").Active = true
            end
		elseif key == MM_Painting_Button then
		    if value == 1 then
		        Tracker:FindObjectForCode("MM-Painting").Active = true
		    end
		elseif key == MM_MonkeyHead_Button then
            if value == 1 then
                Tracker:FindObjectForCode("MM-Button").Active = true
            end
		elseif key == TVT_Lobby_Button then
            if value == 1 then
                Tracker:FindObjectForCode("TVT_Lobby_Button").Active = true
            end
		end
    end
end

function onNotifyLaunch(key, value)
	obj = Tracker:FindObjectForCode("tot_ape")
	print(obj.AcquiredCount)
	if value ~= nil then
        print(key)
        if key == DR_Block_Pushed then
		  if value == 1 then
              Tracker:FindObjectForCode("DR-Block").Active = true
		  end
		elseif key == DIButton then
		  if value == 1 then
		    Tracker:FindObjectForCode("DI-Button").Active = true
		  end
		elseif key == CrCWaterButton then
		  if value == 1 then
		    Tracker:FindObjectForCode("CC-Button").Active = true
		  end
		elseif key == MM_Painting_Button then
		  if value == 1 then
		    Tracker:FindObjectForCode("MM-Painting").Active = true
		  end
		elseif key == MM_MonkeyHead_Button then
		  if value == 1 then
		    Tracker:FindObjectForCode("MM-Button").Active = true
		  end
		elseif key == TVT_Lobby_Button then
		  if value == 1 then
		    Tracker:FindObjectForCode("TVT_Lobby_Button").Active = true
		  end
		end
    else
		--local onClear_timer = os.clock()
		--tot_ape = Tracker:FindObjectForCode("tot_ape")
		--tot_ape.AcquiredCount = 0
		-- reset locations
		--for k, v in pairs(locationToCode) do
		--	if k then 
		--		local obj = Tracker:FindObjectForCode("@"..k)
		--		if obj then
		--			--print(v)
		--			if (string.find(string.upper(v), "MONKEY")) then
		--				if obj.AvailableChestCount == 0 then
		--					tot_ape.AcquiredCount = tot_ape.AcquiredCount + 1							
		--				end
		--			end
		--		elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		--			print(string.format("onClear: could not find object for code %s", k))
		--		end
		--	end
		--end
		--print(string.format("Time taken onRESET: %.2f", os.clock() - onClear_timer))
	end
	
end
-- on data received
Archipelago:AddSetReplyHandler("notify handler", onNotify)
-- on connect
Archipelago:AddRetrievedHandler("notify launch handler", onNotifyLaunch)

-- add AP callbacks
-- un-/comment as needed
--Archipelago:AddClearHandler("clear handler", onClearHandler)
Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
-- Archipelago:AddScoutHandler("scout handler", onScout)
-- Archipelago:AddBouncedHandler("bounce handler", onBounce)