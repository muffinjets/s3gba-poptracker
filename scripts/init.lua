ENABLE_DEBUG_LOG = true
local variant = Tracker.ActiveVariantUID
IS_ITEMS_ONLY = variant:find("items_only")

print("Loaded variant: ", variant)
if ENABLE_DEBUG_LOG then
    print("Debug logging is enabled!")
end






Tracker:AddItems("items/notitems.json")
-- For some reason, "items/items.json" wouldn't load files????  I tried everything syntactically, the only thing that worked was changing the name of the file.  Wierd.
Tracker:AddMaps("maps/maps.json")
Tracker:AddLayouts("layouts/mainlayout.json")
Tracker:AddLayouts("layouts/grids.json")
Tracker:AddLocations("locations/dragonshores.json")
Tracker:AddLocations("locations/fairylibrary.json")
Tracker:AddLocations("locations/byrdbarracks.json")
Tracker:AddLocations("locations/yetiserengeti.json")
Tracker:AddLocations("locations/thievesguild.json")
Tracker:AddLocations("locations/rabbithabitat.json")
Tracker:AddLocations("locations/bananasavannah.json")
Tracker:AddLocations("locations/kangaroohoodoos.json")
Tracker:AddLocations("locations/moneybagsmansion.json")
Tracker:AddLocations("locations/professorssecretlab.json")
Tracker:AddLocations("locations/cheetahspotspa.json")
Tracker:AddLocations("locations/rhynocsnclocks.json")
Tracker:AddLocations("locations/chateauripto.json")

--autotracking

ScriptHost:LoadScript("scripts/autotracking.lua")
