Config = {}
-- Keys
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, 
  ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, 
  ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, 
  ["K"] = 311, ["L"] = 182,	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, 
  ["."] = 81,	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, 
  ["DELETE"] = 178,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, 
  ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

-- Fuel Settings
Config.FuelAlertPercent = 0.15
Config.BaseFuel         = 65
Config.FuelKey          = Keys['E']
Config.SecPerFuelUnit   = 1.0
Config.CostPerUnit      = 1.5
Config.FuelSaveModifier = 10 -- 10 base 20 is double saving  5 is double usage

Config.VehicleFuelLimit = {
	[0] = 0.8, -- Compacts
	[1] = 1.0, -- Sedans
	[2] = 1.1, -- SUVs
	[3] = 1.1, -- Coupes
	[4] = 1.4, -- Muscle
	[5] = 1.4, -- Sports Classics
	[6] = 1.1, -- Sports
	[7] = 1.1, -- Super
	[8] = 0.4, -- Motorcycles
	[9] = 1.4, -- Off-road
	[10] = 3.0, -- Industrial
	[11] = 1.3, -- Utility
	[12] = 1.3, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 2.0, -- Boats
	[15] = 5.0, -- Helicopters
	[16] = 5.0, -- Planes
	[17] = 2.0, -- Service
	[18] = 1.4, -- Emergency
	[19] = 5.0, -- Military
	[20] = 2.0, -- Commercial
	[21] = 10.0, -- Trains
}

Config.VehicleConsumption = {
	[0] = 1.0, -- Compacts
	[1] = 1.0, -- Sedans
	[2] = 1.5, -- SUVs
	[3] = 1.0, -- Coupes
	[4] = 1.4, -- Muscle
	[5] = 1.4, -- Sports Classics
	[6] = 1.5, -- Sports
	[7] = 1.5, -- Super
	[8] = 0.4, -- Motorcycles
	[9] = 1.4, -- Off-road
	[10] = 2.0, -- Industrial
	[11] = 1.5, -- Utility
	[12] = 1.5, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 1.0, -- Boats
	[15] = 1.0, -- Helicopters
	[16] = 1.0, -- Planes
	[17] = 1.0, -- Service
	[18] = 1.1, -- Emergency
	[19] = 1.0, -- Military
	[20] = 2.0, -- Commercial
	[21] = 5.0, -- Trains
}

Config.FuelMultiplier = {
	[1.0] = 1.8,
	[0.9] = 1.6,
	[0.8] = 1.4,
	[0.7] = 1.2,
	[0.6] = 1.0,
	[0.5] = 0.8,
	[0.4] = 0.6,
	[0.3] = 0.3,
	[0.2] = 0.05,
	[0.1] = 0.0,
	[0.0] = 0.0,
}

Config.GasPumpModels = {
  ['prop_gas_pump_1a'] = true,
  ['prop_gas_pump_1b'] = true,
  ['prop_gas_pump_1c'] = true,
  ['prop_gas_pump_1d'] = true,
  ['prop_gas_pump_old2'] = true,
  ['prop_gas_pump_old3'] = true,
  ['prop_vintage_pump'] = true
}
