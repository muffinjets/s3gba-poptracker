local levelStrings = {
"@Dragon Shores (Coast)/DS Flower",
"@Dragon Shores (Oasis)/DS Green Chest",
"@Dragon Shores (Nests)/DS Find all the Toys",
"@Dragon Shores (Nests)/DS Moneybags",
"@Dragon Shores (Coast)/DS Ripto",
"@Dragon Shores (Oasis)/DS Oasis Toddler",
"@Dragon Shores (Oasis)/DS Byrd Mission",
"@Dragon Shores (Nests)/DS Nest Toddler",
"@Fairy Library/FL Green Chest",
"@Fairy Library/FL Purple Chest",
"@Fairy Library/FL Light the Hearth",
"@Fairy Library/FL Find all the Machine Parts",
"@Fairy Library/FL Put out the Book Fires",
"@Fairy Library/FL Moneybags Vault",
"@Fairy Library/FL Ripto",
"@Fairy Library/FL Red Chest",
"@Yeti Serengeti/Flower",
"@Yeti Serengeti/Freeze Goats",
"@Yeti Serengeti/Chest Above Moneybags' Vault",
"@Yeti Serengeti/Find all the Climbing Gear",
"@Yeti Serengeti/Moneybags Vault",
"@Yeti Serengeti/Whistling Statues",
"@Yeti Serengeti/Chest Next to Bentley",
"@Yeti Serengeti/Purple Chest",
"@Byrd Barracks/BB Flower",
"@Byrd Barracks/BB Deliver Intro Penguin",
"@Byrd Barracks/BB Find all the Medals",
"@Byrd Barracks/BB Rescue all the Privates",
"@Byrd Barracks/BB Moneybags Vault",
"@Byrd Barracks/BB Rhynoc Bombing",
"@Byrd Barracks/BB Byrd Mission",
"@Byrd Barracks/BB Red Chest",
"@Thieves' Guild/TG Purple Chest",
"@Thieves' Guild/TG Toddler",
"@Thieves' Guild/TG Find all the Thief Tools",
"@Thieves' Guild/TG Catch Fast Eddie",
"@Thieves' Guild/TG Moneybags Vault",
"@Thieves' Guild/TG Win the Race",
"@Thieves' Guild/TG Agent 9 Mission",
"@Thieves' Guild/TG Moneybags",
"@Rabbit Habitat/RH Purple Chest",
"@Rabbit Habitat/RH Join the Halves",
"@Rabbit Habitat/RH Find all of the Flowers",
"@Rabbit Habitat/RH Moneybags Vault",
"@Rabbit Habitat/RH Whack-a-Rhynoc",
"@Rabbit Habitat/RH Chest at the bottom of the Purple Area",
"@Rabbit Habitat/RH Chest in the bottom-right of the Purple Area",
"@Rabbit Habitat/RH Yellow Chest",
"@Banana Savannah/BS Green Chest",
"@Banana Savannah/BS Flower",
"@Banana Savannah/BS Help Intro Monkey",
"@Banana Savannah/BS Find all the Ingredients",
"@Banana Savannah/BS Hit all the Targets",
"@Banana Savannah/BS Moneybags Vault",
"@Banana Savannah/BS Red Chest",
"@Banana Savannah/BS Agent 9 Mission",
"@Kangaroo Hoodoos/KH Green Chest",
"@Kangaroo Hoodoos/KH Flower",
"@Kangaroo Hoodoos/KH Help Intro Kangaroo",
"@Kangaroo Hoodoos/KH Find all the Artifacts",
"@Kangaroo Hoodoos/KH Destroy the TVs",
"@Kangaroo Hoodoos/KH Solve the 9-Square Puzzle",
"@Kangaroo Hoodoos/KH Moneybags Vault",
"@Kangaroo Hoodoos/KH Red Chest",
"@Moneybags' Mansion/MM Flower",
"@Moneybags' Mansion/MM Purple Chest",
"@Moneybags' Mansion/MM Butler Fight",
"@Moneybags' Mansion/MM Moneybags",
"@Moneybags' Mansion/MM Generator",
"@Moneybags' Mansion/MM Moneybags Vault",
"@Moneybags' Mansion/MM Green Chest",
"@Moneybags' Mansion/MM Agent 9 Mission",
"@Cheetah Spot Spa/CS Green Chest",
"@Cheetah Spot Spa/CS Flower",
"@Cheetah Spot Spa/CS Vending Machine",
"@Cheetah Spot Spa/CS Find all the Cool Things",
"@Cheetah Spot Spa/CS Fix the Treadmill",
"@Cheetah Spot Spa/CS Rhynoc Bombing",
"@Cheetah Spot Spa/CS Agent 9 Mission",
"@Cheetah Spot Spa/CS Moneybags",
"@Professor's Secret Lab/PL Green Chest",
"@Professor's Secret Lab/PL Zoo Toddler",
"@Professor's Secret Lab/PL Purple Chest Near Yak",
"@Professor's Secret Lab/PL Purple Chest Near Vault Button",
"@Professor's Secret Lab/PL Yellow Chest",
"@Professor's Secret Lab/PL Moneybags Vault",
"@Professor's Secret Lab/PL Red Chest in the Blue Area Far Right",
"@Professor's Secret Lab/PL Red Chest in front of Vault",
"@Rhynocs n' Clocks/RC Purple Chest",
"@Rhynocs n' Clocks/RC Toddler",
"@Rhynocs n' Clocks/RC Whack-a-Rhynoc",
"@Rhynocs n' Clocks/RC Byrd Mission",
"@Rhynocs n' Clocks/RC Chest on the Far Right",
"@Rhynocs n' Clocks/RC Chest on the Left Peak",
"@Chateau Ripto/CR Moneybags Vault",
"@Chateau Ripto/CR Byrd Mission",
"@Chateau Ripto/CR Ripto",
"@Chateau Ripto/CR Ripto 2",
"@Chateau Ripto/CR Moneybags",
"@Chateau Ripto/CR Yellow Chest"
}

local levelSorted = {}

for i=1, 100 do
	levelSorted[#levelSorted+1] = ""
end

local updateMeta = function(mem)


	for i=1, 100 do
		local b = mem:ReadUInt8(0x0871BD30-1+i)
		print("i "..i)
		print("ID "..b)
		levelSorted[b-0x43+1] = levelStrings[i]
	end
end

local updateDS = function(mem)
    local b = mem:ReadUInt8(0x03002FE7)
	
	Tracker:FindObjectForCode("plant1").Active = (b & 0x01)>0 
	Tracker:FindObjectForCode("artifact1").Active = (b & 0x02)>0 
    Tracker:FindObjectForCode("heart1").Active = (b & 0x04)>0 
	Tracker:FindObjectForCode("toy1").Active = (b & 0x08)>0 
	Tracker:FindObjectForCode("heart11").Active = (b & 0x10)>0
	Tracker:FindObjectForCode("machine1").Active = (b & 0x20)>0
	Tracker:FindObjectForCode("LeftGreen").Active = (b & 0x40)>0
	Tracker:FindObjectForCode("machine2").Active = (b & 0x80)>0

	if (b & 0x01) > 0 then
		Tracker:FindObjectForCode(levelSorted[1]).AvailableChestCount = 0
	end
	if (b & 0x02) > 0 then
		Tracker:FindObjectForCode(levelSorted[2]).AvailableChestCount = 0
	end
	if (b & 0x04) > 0 then
		Tracker:FindObjectForCode(levelSorted[3]).AvailableChestCount = 0
	end
	if (b & 0x08) > 0 then
		Tracker:FindObjectForCode(levelSorted[4]).AvailableChestCount = 0
	end
	if (b & 0x10) > 0 then
		Tracker:FindObjectForCode(levelSorted[5]).AvailableChestCount = 0
	end
	if (b & 0x20) > 0 then
		Tracker:FindObjectForCode(levelSorted[6]).AvailableChestCount = 0
	end
	if (b & 0x40) > 0 then
		Tracker:FindObjectForCode(levelSorted[7]).AvailableChestCount = 0
	end
	if (b & 0x80) > 0 then
		Tracker:FindObjectForCode(levelSorted[8]).AvailableChestCount = 0
	end
    return true -- (optional) returning false will call the callback again if anything else changes
end

local updateFL = function(mem)
    local b = mem:ReadUInt8(0x03002FE8)
	
	Tracker:FindObjectForCode("equipment1").Active = (b & 0x01)>0 
	Tracker:FindObjectForCode("hipness1").Active = (b & 0x02)>0 
    Tracker:FindObjectForCode("ice").Active = (b & 0x04)>0 
	Tracker:FindObjectForCode("heart2").Active = (b & 0x08)>0 
	Tracker:FindObjectForCode("artifact2").Active = (b & 0x10)>0
	Tracker:FindObjectForCode("toy2").Active = (b & 0x20)>0
	Tracker:FindObjectForCode("quickescape").Active = (b & 0x40)>0
	Tracker:FindObjectForCode("toy3").Active = (b & 0x80)>0
	
	if (b & 0x01) > 0 then
		Tracker:FindObjectForCode(levelSorted[9]).AvailableChestCount = 0
	end
	if (b & 0x02) > 0 then
		Tracker:FindObjectForCode(levelSorted[10]).AvailableChestCount = 0
	end
	if (b & 0x04) > 0 then
		Tracker:FindObjectForCode(levelSorted[11]).AvailableChestCount = 0
	end
	if (b & 0x08) > 0 then
		Tracker:FindObjectForCode(levelSorted[12]).AvailableChestCount = 0
	end
	if (b & 0x10) > 0 then
		Tracker:FindObjectForCode(levelSorted[13]).AvailableChestCount = 0
	end
	if (b & 0x20) > 0 then
		Tracker:FindObjectForCode(levelSorted[14]).AvailableChestCount = 0
	end
	if (b & 0x40) > 0 then
		Tracker:FindObjectForCode(levelSorted[15]).AvailableChestCount = 0
	end
	if (b & 0x80) > 0 then
		Tracker:FindObjectForCode(levelSorted[16]).AvailableChestCount = 0
	end

    return true -- (optional) returning false will call the callback again if anything else changes
end

local updateYS = function(mem)
    local b = mem:ReadUInt8(0x03002FE9)
	
	Tracker:FindObjectForCode("plant2").Active = (b & 0x01)>0 
	Tracker:FindObjectForCode("lamp").Active = (b & 0x02)>0 
    Tracker:FindObjectForCode("toy4").Active = (b & 0x04)>0 
	Tracker:FindObjectForCode("heart3").Active = (b & 0x08)>0 
	Tracker:FindObjectForCode("toy5").Active = (b & 0x10)>0
	Tracker:FindObjectForCode("medal1").Active = (b & 0x20)>0
	Tracker:FindObjectForCode("machine3").Active = (b & 0x40)>0
	Tracker:FindObjectForCode("ingredient1").Active = (b & 0x80)>0

	if (b & 0x01) > 0 then
		Tracker:FindObjectForCode(levelSorted[17]).AvailableChestCount = 0
	end
	if (b & 0x02) > 0 then
		Tracker:FindObjectForCode(levelSorted[18]).AvailableChestCount = 0
	end
	if (b & 0x04) > 0 then
		Tracker:FindObjectForCode(levelSorted[19]).AvailableChestCount = 0
	end
	if (b & 0x08) > 0 then
		Tracker:FindObjectForCode(levelSorted[20]).AvailableChestCount = 0
	end
	if (b & 0x10) > 0 then
		Tracker:FindObjectForCode(levelSorted[21]).AvailableChestCount = 0
	end
	if (b & 0x20) > 0 then
		Tracker:FindObjectForCode(levelSorted[22]).AvailableChestCount = 0
	end
	if (b & 0x40) > 0 then
		Tracker:FindObjectForCode(levelSorted[23]).AvailableChestCount = 0
	end
	if (b & 0x80) > 0 then
		Tracker:FindObjectForCode(levelSorted[24]).AvailableChestCount = 0
	end

    return true -- (optional) returning false will call the callback again if anything else changes
end

local updateBB = function(mem)
    local b = mem:ReadUInt8(0x03002FEA)
	
	Tracker:FindObjectForCode("plant3").Active = (b & 0x01)>0 
	Tracker:FindObjectForCode("ice2").Active = (b & 0x02)>0 
    Tracker:FindObjectForCode("heart4").Active = (b & 0x04)>0 
	Tracker:FindObjectForCode("hipness2").Active = (b & 0x08)>0 
	Tracker:FindObjectForCode("machine4").Active = (b & 0x10)>0
	Tracker:FindObjectForCode("toy6").Active = (b & 0x20)>0
	Tracker:FindObjectForCode("RightRed").Active = (b & 0x40)>0
	Tracker:FindObjectForCode("equipment2").Active = (b & 0x80)>0

	if (b & 0x01) > 0 then
		Tracker:FindObjectForCode(levelSorted[25]).AvailableChestCount = 0
	end
	if (b & 0x02) > 0 then
		Tracker:FindObjectForCode(levelSorted[26]).AvailableChestCount = 0
	end
	if (b & 0x04) > 0 then
		Tracker:FindObjectForCode(levelSorted[27]).AvailableChestCount = 0
	end
	if (b & 0x08) > 0 then
		Tracker:FindObjectForCode(levelSorted[28]).AvailableChestCount = 0
	end
	if (b & 0x10) > 0 then
		Tracker:FindObjectForCode(levelSorted[29]).AvailableChestCount = 0
	end
	if (b & 0x20) > 0 then
		Tracker:FindObjectForCode(levelSorted[30]).AvailableChestCount = 0
	end
	if (b & 0x40) > 0 then
		Tracker:FindObjectForCode(levelSorted[31]).AvailableChestCount = 0
	end
	if (b & 0x80) > 0 then
		Tracker:FindObjectForCode(levelSorted[32]).AvailableChestCount = 0
	end

    return true -- (optional) returning false will call the callback again if anything else changes
end

local updateTG = function(mem)
    local b = mem:ReadUInt8(0x03002FEB)
	
	Tracker:FindObjectForCode("hipness3").Active = (b & 0x01)>0 
	Tracker:FindObjectForCode("MagicRainbowDust").Active = (b & 0x02)>0 
    Tracker:FindObjectForCode("heart5").Active = (b & 0x04)>0 
	Tracker:FindObjectForCode("toy7").Active = (b & 0x08)>0 
	Tracker:FindObjectForCode("ingredient2").Active = (b & 0x10)>0
	Tracker:FindObjectForCode("medal2").Active = (b & 0x20)>0
	Tracker:FindObjectForCode("LeftRed").Active = (b & 0x40)>0
	Tracker:FindObjectForCode("machine5").Active = (b & 0x80)>0

	if (b & 0x01) > 0 then
		Tracker:FindObjectForCode(levelSorted[33]).AvailableChestCount = 0
	end
	if (b & 0x02) > 0 then
		Tracker:FindObjectForCode(levelSorted[34]).AvailableChestCount = 0
	end
	if (b & 0x04) > 0 then
		Tracker:FindObjectForCode(levelSorted[35]).AvailableChestCount = 0
	end
	if (b & 0x08) > 0 then
		Tracker:FindObjectForCode(levelSorted[36]).AvailableChestCount = 0
	end
	if (b & 0x10) > 0 then
		Tracker:FindObjectForCode(levelSorted[37]).AvailableChestCount = 0
	end
	if (b & 0x20) > 0 then
		Tracker:FindObjectForCode(levelSorted[38]).AvailableChestCount = 0
	end
	if (b & 0x40) > 0 then
		Tracker:FindObjectForCode(levelSorted[39]).AvailableChestCount = 0
	end
	if (b & 0x80) > 0 then
		Tracker:FindObjectForCode(levelSorted[40]).AvailableChestCount = 0
	end

    return true -- (optional) returning false will call the callback again if anything else changes
end

local updateRH = function(mem)
    local b = mem:ReadUInt8(0x03002FEC)
	
	Tracker:FindObjectForCode("equipment4").Active = (b & 0x01)>0 
	Tracker:FindObjectForCode("top").Active = (b & 0x02)>0 
    Tracker:FindObjectForCode("heart6").Active = (b & 0x04)>0 
	Tracker:FindObjectForCode("tool1").Active = (b & 0x08)>0 
	Tracker:FindObjectForCode("medal3").Active = (b & 0x10)>0
	Tracker:FindObjectForCode("equipment3").Active = (b & 0x20)>0
	Tracker:FindObjectForCode("machine6").Active = (b & 0x40)>0
	Tracker:FindObjectForCode("ingredient7").Active = (b & 0x80)>0

	if (b & 0x01) > 0 then
		Tracker:FindObjectForCode(levelSorted[41]).AvailableChestCount = 0
	end
	if (b & 0x02) > 0 then
		Tracker:FindObjectForCode(levelSorted[42]).AvailableChestCount = 0
	end
	if (b & 0x04) > 0 then
		Tracker:FindObjectForCode(levelSorted[43]).AvailableChestCount = 0
	end
	if (b & 0x08) > 0 then
		Tracker:FindObjectForCode(levelSorted[44]).AvailableChestCount = 0
	end
	if (b & 0x10) > 0 then
		Tracker:FindObjectForCode(levelSorted[45]).AvailableChestCount = 0
	end
	if (b & 0x20) > 0 then
		Tracker:FindObjectForCode(levelSorted[46]).AvailableChestCount = 0
	end
	if (b & 0x40) > 0 then
		Tracker:FindObjectForCode(levelSorted[47]).AvailableChestCount = 0
	end
	if (b & 0x80) > 0 then
		Tracker:FindObjectForCode(levelSorted[48]).AvailableChestCount = 0
	end

    return true -- (optional) returning false will call the callback again if anything else changes
end

local updateBS = function(mem)
    local b = mem:ReadUInt8(0x03002FED)
	
	Tracker:FindObjectForCode("equipment5").Active = (b & 0x01)>0 
	Tracker:FindObjectForCode("plant4").Active = (b & 0x02)>0 
    Tracker:FindObjectForCode("fire2").Active = (b & 0x04)>0 
	Tracker:FindObjectForCode("heart7").Active = (b & 0x08)>0 
	Tracker:FindObjectForCode("machine7").Active = (b & 0x10)>0
	Tracker:FindObjectForCode("artifact3").Active = (b & 0x20)>0
	Tracker:FindObjectForCode("tool2").Active = (b & 0x40)>0
	Tracker:FindObjectForCode("RightGreen").Active = (b & 0x80)>0

	if (b & 0x01) > 0 then
		Tracker:FindObjectForCode(levelSorted[49]).AvailableChestCount = 0
	end
	if (b & 0x02) > 0 then
		Tracker:FindObjectForCode(levelSorted[50]).AvailableChestCount = 0
	end
	if (b & 0x04) > 0 then
		Tracker:FindObjectForCode(levelSorted[51]).AvailableChestCount = 0
	end
	if (b & 0x08) > 0 then
		Tracker:FindObjectForCode(levelSorted[52]).AvailableChestCount = 0
	end
	if (b & 0x10) > 0 then
		Tracker:FindObjectForCode(levelSorted[53]).AvailableChestCount = 0
	end
	if (b & 0x20) > 0 then
		Tracker:FindObjectForCode(levelSorted[54]).AvailableChestCount = 0
	end
	if (b & 0x40) > 0 then
		Tracker:FindObjectForCode(levelSorted[55]).AvailableChestCount = 0
	end
	if (b & 0x80) > 0 then
		Tracker:FindObjectForCode(levelSorted[56]).AvailableChestCount = 0
	end

    return true -- (optional) returning false will call the callback again if anything else changes
end

local updateKH = function(mem)
    local b = mem:ReadUInt8(0x03002FEE)
	
	Tracker:FindObjectForCode("tool3").Active = (b & 0x01)>0 
	Tracker:FindObjectForCode("plant5").Active = (b & 0x02)>0 
    Tracker:FindObjectForCode("headbash").Active = (b & 0x04)>0 
	Tracker:FindObjectForCode("heart8").Active = (b & 0x08)>0 
	Tracker:FindObjectForCode("ingredient3").Active = (b & 0x10)>0
	Tracker:FindObjectForCode("medal4").Active = (b & 0x20)>0
	Tracker:FindObjectForCode("hipness4").Active = (b & 0x40)>0
	Tracker:FindObjectForCode("equipment6").Active = (b & 0x80)>0

	if (b & 0x01) > 0 then
		Tracker:FindObjectForCode(levelSorted[57]).AvailableChestCount = 0
	end
	if (b & 0x02) > 0 then
		Tracker:FindObjectForCode(levelSorted[58]).AvailableChestCount = 0
	end
	if (b & 0x04) > 0 then
		Tracker:FindObjectForCode(levelSorted[59]).AvailableChestCount = 0
	end
	if (b & 0x08) > 0 then
		Tracker:FindObjectForCode(levelSorted[60]).AvailableChestCount = 0
	end
	if (b & 0x10) > 0 then
		Tracker:FindObjectForCode(levelSorted[61]).AvailableChestCount = 0
	end
	if (b & 0x20) > 0 then
		Tracker:FindObjectForCode(levelSorted[62]).AvailableChestCount = 0
	end
	if (b & 0x40) > 0 then
		Tracker:FindObjectForCode(levelSorted[63]).AvailableChestCount = 0
	end
	if (b & 0x80) > 0 then
		Tracker:FindObjectForCode(levelSorted[64]).AvailableChestCount = 0
	end

    return true -- (optional) returning false will call the callback again if anything else changes
end

local updateMM = function(mem)
    local b = mem:ReadUInt8(0x03002FEF)
	
	Tracker:FindObjectForCode("plant6").Active = (b & 0x01)>0 
	Tracker:FindObjectForCode("artifact4").Active = (b & 0x02)>0 
    Tracker:FindObjectForCode("dynamo").Active = (b & 0x04)>0 
	Tracker:FindObjectForCode("heart9").Active = (b & 0x08)>0 
	Tracker:FindObjectForCode("equipment7").Active = (b & 0x10)>0
	Tracker:FindObjectForCode("hipness5").Active = (b & 0x20)>0
	Tracker:FindObjectForCode("medal5").Active = (b & 0x40)>0
	Tracker:FindObjectForCode("LeftPurple").Active = (b & 0x80)>0

	if (b & 0x01) > 0 then
		Tracker:FindObjectForCode(levelSorted[65]).AvailableChestCount = 0
	end
	if (b & 0x02) > 0 then
		Tracker:FindObjectForCode(levelSorted[66]).AvailableChestCount = 0
	end
	if (b & 0x04) > 0 then
		Tracker:FindObjectForCode(levelSorted[67]).AvailableChestCount = 0
	end
	if (b & 0x08) > 0 then
		Tracker:FindObjectForCode(levelSorted[68]).AvailableChestCount = 0
	end
	if (b & 0x10) > 0 then
		Tracker:FindObjectForCode(levelSorted[69]).AvailableChestCount = 0
	end
	if (b & 0x20) > 0 then
		Tracker:FindObjectForCode(levelSorted[70]).AvailableChestCount = 0
	end
	if (b & 0x40) > 0 then
		Tracker:FindObjectForCode(levelSorted[71]).AvailableChestCount = 0
	end
	if (b & 0x80) > 0 then
		Tracker:FindObjectForCode(levelSorted[72]).AvailableChestCount = 0
	end

    return true -- (optional) returning false will call the callback again if anything else changes
end

local updateCS = function(mem)
    local b = mem:ReadUInt8(0x03002FF0)
	
	Tracker:FindObjectForCode("tool4").Active = (b & 0x01)>0 
	Tracker:FindObjectForCode("plant7").Active = (b & 0x02)>0 
    Tracker:FindObjectForCode("SuperHealthBar").Active = (b & 0x04)>0 
	Tracker:FindObjectForCode("heart10").Active = (b & 0x08)>0 
	Tracker:FindObjectForCode("artifact5").Active = (b & 0x10)>0
	Tracker:FindObjectForCode("medal6").Active = (b & 0x20)>0
	Tracker:FindObjectForCode("LeftYellow").Active = (b & 0x40)>0
	Tracker:FindObjectForCode("tool7").Active = (b & 0x80)>0

	if (b & 0x01) > 0 then
		Tracker:FindObjectForCode(levelSorted[73]).AvailableChestCount = 0
	end
	if (b & 0x02) > 0 then
		Tracker:FindObjectForCode(levelSorted[74]).AvailableChestCount = 0
	end
	if (b & 0x04) > 0 then
		Tracker:FindObjectForCode(levelSorted[75]).AvailableChestCount = 0
	end
	if (b & 0x08) > 0 then
		Tracker:FindObjectForCode(levelSorted[76]).AvailableChestCount = 0
	end
	if (b & 0x10) > 0 then
		Tracker:FindObjectForCode(levelSorted[77]).AvailableChestCount = 0
	end
	if (b & 0x20) > 0 then
		Tracker:FindObjectForCode(levelSorted[78]).AvailableChestCount = 0
	end
	if (b & 0x40) > 0 then
		Tracker:FindObjectForCode(levelSorted[79]).AvailableChestCount = 0
	end
	if (b & 0x80) > 0 then
		Tracker:FindObjectForCode(levelSorted[80]).AvailableChestCount = 0
	end

    return true -- (optional) returning false will call the callback again if anything else changes
end

local updatePL = function(mem)
    local b = mem:ReadUInt8(0x03002FF1)
	
	Tracker:FindObjectForCode("tool5").Active = (b & 0x01)>0 
	Tracker:FindObjectForCode("hipness6").Active = (b & 0x02)>0 
    Tracker:FindObjectForCode("tool6").Active = (b & 0x04)>0 
	Tracker:FindObjectForCode("ingredient4").Active = (b & 0x08)>0 
	Tracker:FindObjectForCode("shades").Active = (b & 0x10)>0
	Tracker:FindObjectForCode("artifact6").Active = (b & 0x20)>0
	Tracker:FindObjectForCode("hipness7").Active = (b & 0x40)>0
	Tracker:FindObjectForCode("ingredient5").Active = (b & 0x80)>0

	if (b & 0x01) > 0 then
		Tracker:FindObjectForCode(levelSorted[81]).AvailableChestCount = 0
	end
	if (b & 0x02) > 0 then
		Tracker:FindObjectForCode(levelSorted[82]).AvailableChestCount = 0
	end
	if (b & 0x04) > 0 then
		Tracker:FindObjectForCode(levelSorted[83]).AvailableChestCount = 0
	end
	if (b & 0x08) > 0 then
		Tracker:FindObjectForCode(levelSorted[84]).AvailableChestCount = 0
	end
	if (b & 0x10) > 0 then
		Tracker:FindObjectForCode(levelSorted[85]).AvailableChestCount = 0
	end
	if (b & 0x20) > 0 then
		Tracker:FindObjectForCode(levelSorted[86]).AvailableChestCount = 0
	end
	if (b & 0x40) > 0 then
		Tracker:FindObjectForCode(levelSorted[87]).AvailableChestCount = 0
	end
	if (b & 0x80) > 0 then
		Tracker:FindObjectForCode(levelSorted[88]).AvailableChestCount = 0
	end

    return true -- (optional) returning false will call the callback again if anything else changes
end

local updateRC = function(mem)
    local b = mem:ReadUInt8(0x03002FF2)
	
	Tracker:FindObjectForCode("ingredient6").Active = (b & 0x01)>0 
	Tracker:FindObjectForCode("antennae").Active = (b & 0x02)>0 
    Tracker:FindObjectForCode("medal7").Active = (b & 0x04)>0 
	Tracker:FindObjectForCode("RightPurple").Active = (b & 0x08)>0 
	Tracker:FindObjectForCode("MagicBlueDust").Active = (b & 0x10)>0
	Tracker:FindObjectForCode("MagicGreenDust").Active = (b & 0x20)>0
	
	-- IN CR

	Tracker:FindObjectForCode("artifact7").Active = (b & 0x40)>0
	Tracker:FindObjectForCode("RightYellow").Active = (b & 0x80)>0

	if (b & 0x01) > 0 then
		Tracker:FindObjectForCode(levelSorted[89]).AvailableChestCount = 0
	end
	if (b & 0x02) > 0 then
		Tracker:FindObjectForCode(levelSorted[90]).AvailableChestCount = 0
	end
	if (b & 0x04) > 0 then
		Tracker:FindObjectForCode(levelSorted[91]).AvailableChestCount = 0
	end
	if (b & 0x08) > 0 then
		Tracker:FindObjectForCode(levelSorted[92]).AvailableChestCount = 0
	end
	if (b & 0x10) > 0 then
		Tracker:FindObjectForCode(levelSorted[93]).AvailableChestCount = 0
	end
	if (b & 0x20) > 0 then
		Tracker:FindObjectForCode(levelSorted[94]).AvailableChestCount = 0
	end
	if (b & 0x40) > 0 then
		Tracker:FindObjectForCode(levelSorted[95]).AvailableChestCount = 0
	end
	if (b & 0x80) > 0 then
		print("test "..levelSorted[96])
		Tracker:FindObjectForCode(levelSorted[96]).AvailableChestCount = 0
	end

    return true -- (optional) returning false will call the callback again if anything else changes
end

local updateCR = function(mem)
    local b = mem:ReadUInt8(0x03002FF3)
	
	Tracker:FindObjectForCode("heart12").Active = (b & 0x01)>0 
	Tracker:FindObjectForCode("warp").Active = (b & 0x02)>0 
    Tracker:FindObjectForCode("MagicGoldDust").Active = (b & 0x04)>0 
	Tracker:FindObjectForCode("MagicRedDust").Active = (b & 0x08)>0 

	if (b & 0x01) > 0 then
		Tracker:FindObjectForCode(levelSorted[97]).AvailableChestCount = 0
	end
	if (b & 0x02) > 0 then
		Tracker:FindObjectForCode(levelSorted[98]).AvailableChestCount = 0
	end
	if (b & 0x04) > 0 then
		Tracker:FindObjectForCode(levelSorted[99]).AvailableChestCount = 0
	end
	if (b & 0x08) > 0 then
		Tracker:FindObjectForCode(levelSorted[100]).AvailableChestCount = 0
	end

    return true -- (optional) returning false will call the callback again if anything else changes
end

ScriptHost:AddMemoryWatch("Meta", 0x0871BD30, 100, updateMeta)
ScriptHost:AddMemoryWatch("DSBlock", 0x03002FE7, 1, updateDS)
ScriptHost:AddMemoryWatch("FLBlock", 0x03002FE8, 1, updateFL)
ScriptHost:AddMemoryWatch("YSBlock", 0x03002FE9, 1, updateYS)
ScriptHost:AddMemoryWatch("BBBlock", 0x03002FEA, 1, updateBB)
ScriptHost:AddMemoryWatch("TGBlock", 0x03002FEB, 1, updateTG)
ScriptHost:AddMemoryWatch("RHBlock", 0x03002FEC, 1, updateRH)
ScriptHost:AddMemoryWatch("BSBlock", 0x03002FED, 1, updateBS)
ScriptHost:AddMemoryWatch("KHBlock", 0x03002FEE, 1, updateKH)
ScriptHost:AddMemoryWatch("MMBlock", 0x03002FEF, 1, updateMM)
ScriptHost:AddMemoryWatch("CSBlock", 0x03002FF0, 1, updateCS)
ScriptHost:AddMemoryWatch("PLBlock", 0x03002FF1, 1, updatePL)
ScriptHost:AddMemoryWatch("RCBlock", 0x03002FF2, 1, updateRC)
ScriptHost:AddMemoryWatch("CRBlock", 0x03002FF3, 1, updateCR)

ScriptHost:LoadScript("scripts/autotracking/archipelago.lua")