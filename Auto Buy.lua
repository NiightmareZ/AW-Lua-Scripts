--Made By NiightmareZ
--Credits to SenseUI for the GUI

if SenseUI == nil then
	RunScript( "senseui.lua" );
end

SenseUI.EnableLogs = false;

local local_player = null
local money = 0
local sleep = 0
local buy_act = false
local auto_buy = false
local nade = false
local itembox_index_main = 0
local itembox_index_secondary = 0
local window_open = SenseUI.Keys.insert;

--Information
function draw_callback()

	local_player = entities.GetLocalPlayer();
	if SenseUI.BeginWindow( "main2", 100, 100, 250, 240) then
		SenseUI.DrawTabBar()
		SenseUI.AddGradient()
		SenseUI.SetWindowDrawTexture(true)
		SenseUI.SetWindowMoveable(true)
		SenseUI.SetWindowOpenKey( window_open )

		if SenseUI.BeginGroup("test", "Auto Buy", 5, 5, 230, 220) then
			
			check_bool1 = SenseUI.Checkbox("Activate", check_bool1, false)
			if check_bool1 == true then
				auto_buy = true
			end
			if check_bool1 == false then
				auto_buy = false
			end

			SenseUI.Label("Primary");
			--local itembox_index_main = (gui.GetValue("vis_historyticks") + 1);
			itembox_index_main = SenseUI.Combo("itembox_index_main", {"Off", "Auto", "Scout", "AWP","AK-47, M4A4/A1" }, itembox_index_main)
			--gui.SetValue("vis_historyticks", itembox_index_main-1);
			
			SenseUI.Label("Secondary");
			itembox_index_secondary = SenseUI.Combo("itembox_index_secondary", { "Off", "R8/Deagle", "Elite", "P250", "CZ75-A / .57 / Tec-9" }, itembox_index_secondary)
	 
			check_bool2 = SenseUI.Checkbox("Nades", check_bool2, false)
			if check_bool2 == true then
				nade = true
			end
			if check_bool2 == false then
				nade = false
			end

			check_bool3 = SenseUI.Checkbox("Zeus", check_bool3, false)
			if check_bool3 == true then
				zeus = true
			end
			if check_bool3 == false then
				zeus = false
			end
	 
			check_bool4 = SenseUI.Checkbox("Kevlar", check_bool4, false)
			if check_bool4 == true then
				kevlar = true
			end
			if check_bool4 == false then
				kevlar = false
			end
	 
	 
			check_bool5 = SenseUI.Checkbox("Defuser", check_bool5, false)
			if check_bool5 == true then
				defuser = true
			end
			if check_bool5 == false then
				defuser = false
			end
	
		end;
		SenseUI.EndGroup();
	end;
	SenseUI.EndWindow();
	
end




function autobuy(event)
	if (local_player ~= nil) then
		money = local_player:GetProp("m_iAccount")
	end
	-- print(event:GetName())
	if auto_buy then
		if event:GetName() == "round_start" then
			buy_act = true
			sleep = globals.TickCount()
		end
	end
end
 
 
 function buy()
	--print(itembox_index_secondary)
	--print(itembox_index_main)
	-- print(money)
	if buy_act == true and globals.TickCount() - sleep > 32 then
		buy_act = false
		--print("hallo")
		sleep = globals.TickCount()
		if (itembox_index_secondary == 2) then
			client.Command("buy deagle", true)
		end
 
		if (itembox_index_secondary == 3) then
			client.Command("buy elite", true)
		end
 
		if (itembox_index_secondary == 4) then
			client.Command("buy p250", true)
		end
 
		if (itembox_index_secondary == 5) then
			client.Command("buy tec9", true)
		end
 
 
		if (money > 199) then
			if zeus then
				client.Command("buy Taser", true)
			end
		end
 
		if (money > 2200) then
			if (itembox_index_main == 2) then
				client.Command("buy scar20", true)
				print(money)
			end
 
			if (itembox_index_main == 3) then
				client.Command("buy ssg08", true)
			end
 
			if (itembox_index_main == 4) then
				client.Command("buy awp", true)
			end
 
			if (itembox_index_main == 5) then
				client.Command("buy ak47", true)
				print(money)
			end
 
			if kevlar then
				client.Command("buy vest; buy vesthelm")
			end
 
			if nade then
				client.Command("buy incgrenade; buy molotov; buy hegrenade; buy smokegrenade", true)
			end
 
			if defuser then
				client.Command("buy defuser")
			end
		end
	end
end

callbacks.Register( "Draw", "test2", draw_callback );
client.AllowListener('round_start');
callbacks.Register("FireGameEvent", "autobuy", autobuy);
callbacks.Register("Draw", "buy", buy);
callbacks.Register("Draw", "menu", menu);