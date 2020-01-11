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

Config.UseMetric        = false

-- Modules
Config.UseGPS           = true
Config.UseClock         = true

-- Brake Key
Config.BrakeKey         = Keys["S"]

-- Seatbelt
Config.SeatbeltToggle   = Keys["K"]

-- Light Colors
Config.LowBeamColorOn   = "rgba(200, 200, 200, 1)"
Config.LowBeamColorOff  = "rgba(0, 0, 0,0.5)"

Config.HighBeamColorOn  = "rgba(50, 100, 200, 1)"
Config.HighBeamColorOff = "rgba(0, 0, 0,0.5)"

Config.EngineColorOn    = "rgba(255, 174, 66, 1)"
Config.EngineColorOff   = "rgba(0, 0, 0,0.5)"

Config.FuelColorOff     = "rgba(200, 200, 200, 1)"
Config.FuelColorOn      = "rgba(200,80,80, 0.45)"

Config.SeatbeltColorOff = "rgba(0, 0, 0, 0.45)"
Config.SeatbeltColorOn  = "rgba(250,20,20, 0.9)"

Config.BrakeLightsWhenStopped = true

-- Seat Sliding
Config.DisableSeatSliding = true

-- Cruise Control
Config.CruiseIncrement  = 5
Config.CruiseColor      = "rgba(0, 0, 0,0.5)"
Config.CruiseColorActive= "rgba(50, 100, 200, 1)"
Config.CruiseToggle     = Keys["U"]
Config.CruiseInc        = Keys["N+"]
Config.CruiseDec        = Keys["N-"]

-- Fuel Settings
Config.FuelAlertPercent = 0.15
Config.BaseFuel         = 65
Config.FuelKey          = Keys['E']
Config.SecPerFuelUnit   = 1.1
Config.CostPerUnit      = 1.5

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
	[18] = 0.8, -- Emergency
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

Config.ZoneName = {
  ['AIRP'] = 'Los Santos International Airport',
  ['ALAMO'] = 'Alamo Sea',
  ['ALTA'] = 'Alta',
  ['ARMYB'] = 'Fort Zancudo',
  ['BANHAMC'] = 'Banham Canyon Dr',
  ['BANNING'] = 'Banning',
  ['BEACH'] = 'Vespucci Beach',
  ['BHAMCA'] = 'Banham Canyon',
  ['BRADP'] = 'Braddock Pass',
  ['BRADT'] = 'Braddock Tunnel',
  ['BURTON'] = 'Burton',
  ['CALAFB'] = 'Calafia Bridge',
  ['CANNY'] = 'Raton Canyon',
  ['CCREAK'] = 'Cassidy Creek',
  ['CHAMH'] = 'Chamberlain Hills',
  ['CHIL'] = 'Vinewood Hills',
  ['CHU'] = 'Chumash',
  ['CMSW'] = 'Chiliad Mountain State Wilderness',
  ['CYPRE'] = 'Cypress Flats',
  ['DAVIS'] = 'Davis',
  ['DELBE'] = 'Del Perro Beach',
  ['DELPE'] = 'Del Perro',
  ['DELSOL'] = 'La Puerta',
  ['DESRT'] = 'Grand Senora Desert',
  ['DOWNT'] = 'Downtown',
  ['DTVINE'] = 'Downtown Vinewood',
  ['EAST_V'] = 'East Vinewood',
  ['EBURO'] = 'El Burro Heights',
  ['ELGORL'] = 'El Gordo Lighthouse',
  ['ELYSIAN'] = 'Elysian Island',
  ['GALFISH'] = 'Galilee',
  ['GOLF'] = 'GWC and Golfing Society',
  ['GRAPES'] = 'Grapeseed',
  ['GREATC'] = 'Great Chaparral',
  ['HARMO'] = 'Harmony',
  ['HAWICK'] = 'Hawick',
  ['HORS'] = 'Vinewood Racetrack',
  ['HUMLAB'] = 'Humane Labs and Research',
  ['JAIL'] = 'Bolingbroke Penitentiary',
  ['KOREAT'] = 'Little Seoul',
  ['LACT'] = 'Land Act Reservoir',
  ['LAGO'] = 'Lago Zancudo',
  ['LDAM'] = 'Land Act Dam',
  ['LEGSQU'] = 'Legion Square',
  ['LMESA'] = 'La Mesa',
  ['LOSPUER'] = 'La Puerta',
  ['MIRR'] = 'Mirror Park',
  ['MORN'] = 'Morningwood',
  ['MOVIE'] = 'Richards Majestic',
  ['MTCHIL'] = 'Mount Chiliad',
  ['MTGORDO'] = 'Mount Gordo',
  ['MTJOSE'] = 'Mount Josiah',
  ['MURRI'] = 'Murrieta Heights',
  ['NCHU'] = 'North Chumash',
  ['NOOSE'] = 'N.O.O.S.E',
  ['OCEANA'] = 'Pacific Ocean',
  ['PALCOV'] = 'Paleto Cove',
  ['PALETO'] = 'Paleto Bay',
  ['PALFOR'] = 'Paleto Forest',
  ['PALHIGH'] = 'Palomino Highlands',
  ['PALMPOW'] = 'Palmer-Taylor Power Station',
  ['PBLUFF'] = 'Pacific Bluffs',
  ['PBOX'] = 'Pillbox Hill',
  ['PROCOB'] = 'Procopio Beach',
  ['RANCHO'] = 'Rancho',
  ['RGLEN'] = 'Richman Glen',
  ['RICHM'] = 'Richman',
  ['ROCKF'] = 'Rockford Hills',
  ['RTRAK'] = 'Redwood Lights Track',
  ['SANAND'] = 'San Andreas',
  ['SANCHIA'] = 'San Chianski Mountain Range',
  ['SANDY'] = 'Sandy Shores',
  ['SKID'] = 'Mission Row',
  ['SLAB'] = 'Stab City',
  ['STAD'] = 'Maze Bank Arena',
  ['STRAW'] = 'Strawberry',
  ['TATAMO'] = 'Tataviam Mountains',
  ['TERMINA'] = 'Terminal',
  ['TEXTI'] = 'Textile City',
  ['TONGVAH'] = 'Tongva Hills',
  ['TONGVAV'] = 'Tongva Valley',
  ['VCANA'] = 'Vespucci Canals',
  ['VESP'] = 'Vespucci',
  ['VINE'] = 'Vinewood',
  ['WINDF'] = 'Ron Alternates Wind Farm',
  ['WVINE'] = 'West Vinewood',
  ['ZANCUDO'] = 'Zancudo River',
  ['ZP_ORT'] = 'Port of South Los Santos',
  ['ZQ_UAR'] = 'Davis Quar'
}

Config.Cardinals = {
  [0] = 'N',
  [1] = 'NW', 
  [2] = 'W', 
  [3] = 'SW', 
  [4] = 'S', 
  [5] = 'SE', 
  [6] = 'E', 
  [7] = 'NE', 
  [8] = 'N'
}

Config.DoW = {
  [0] = 'SUN',
  [1] = 'MON',
  [2] = 'TUE',
  [3] = 'WED',
  [4] = 'THU',
  [5] = 'FRI',
  [6] = 'SAT'
}

