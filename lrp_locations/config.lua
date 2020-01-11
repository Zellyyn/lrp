Config = {}

-- Store Objects
-- 247 Counter - v_ret_247_sweetcount
-- Coffee Machine - prop_vend_coffe_01, p_ld_coffee_vend_01, apa_mp_h_acc_coffeemachine_01, hei_heist_kit_coffeemachine_01
-- Cigarettes - prop_vend_fags_01
-- Snacks - prop_vend_snak_01_tu, prop_vend_snak_01
-- Drinks - prop_vend_fridge01
-- Red Soda - prop_vend_soda_01
-- Green Soda - prop_vend_soda_02
-- Water Bottle - prop_vend_water_01

-- Inventories
-- Dumpster - p_dumpster_t, prop_dumpster_01a, prop_dumpster_02a, prop_dumpster_02b, prop_dumpster_3a, prop_dumpster_4a, prop_dumpster_4b, prop_bin_14a, prop_bin_14b
-- Bins - prop_bin_04a, prop_bin_10a, prop_bin_10b, prop_bin_11a, prop_bin_11b, prop_bin_12a, prop_bin_beach_01d, prop_bin_delpiero, prop_bin_delpiero_b, prop_cs_bin_01, prop_cs_bin_01_skinned, prop_cs_bin_02, prop_cs_bin_03, prop_recyclebin_02b, prop_recyclebin_03_a

-- Robbery
-- Safe - prop_ld_int_safe_01, p_v_43_safe_s
-- Till - prop_till_01, prop_till_02, p_till_01_s, v_ret_gc_cashreg
-- Bank
-- ATM - prop_atm_01, prop_atm_02, prop_atm_03
-- Teller Door - v_ilev_gb_teldr
-- Teller Pen - v_corp_fleeca_display
-- Card Access - v_corp_bk_secpanel

-- Payphones - prop_phonebox_01a, prop_phonebox_01b, prop_phonebox_01c, prop_phonebox_02, prop_phonebox_03, prop_phonebox_04
-- Emergency Phone - hei_prop_carrier_phone_01, hei_prop_carrier_phone_02, prop_byard_phone

-- Hotdog Stand - prop_hotdogstand_01
-- Burger Stand - prop_burgerstand_01

-- Parking - prop_parkingpay, prop_parking_hut_2, prop_parking_hut_2b

Config.Locations = {
  ['card-access'] = {
    msg = 'Press E to Hack',
    action = 'lrp:hacking',
    props = {
      'v_corp_bk_secpanel',
    }
  },
  ['clothes'] = {
    msg = 'Press E for Clothes',
    action = 'lrp:clothing',
    props = {
      'prop_sglasses_stand_02',
      'v_52_varsity',
    }
  },
  ['parking'] = {
    msg = 'Press E for Vehicles',
    action = 'lrp:parking',
    props = {
      'prop_parkingpay',
      'prop_parking_hut_2',
      'prop_parking_hut_2b'
    }
  },
  ['hotdogs'] = {
    msg = 'Press E to Purchase',
    action = 'lrp:store-open',
    props = {
      'prop_hotdogstand_01'
    }
  },
  ['burgers'] = {
    msg = 'Press E to Purchase',
    action = 'lrp:store-open',
    props = {
      'prop_burgerstand_01'
    }
  },
  ['emergency-phones'] = {
    msg = 'Press E to Place Call',
    action = 'lrp:phone',
    props = {
      'hei_prop_carrier_phone_01',
      'hei_prop_carrier_phone_02',
      'prop_byard_phone' 
    }
  },
  ['payphones'] = {
    msg = 'Press E to Place Call',
    action = 'lrp:phone',
    props = {
      'prop_phonebox_01a',
      'prop_phonebox_01b',
      'prop_phonebox_01c',
      'prop_phonebox_02',
      'prop_phonebox_03',
      'prop_phonebox_04' 
    }
  },
  ['atm'] = {
    msg = 'Press E for Banking',
    action = 'lrp:bank',
    props = {
      'prop_atm_01',
      'prop_atm_02',
      'prop_atm_03',
      'prop_fleeca_atm'
    }
  },
  ['teller'] = {
    msg = 'Press E for Banking',
    action = 'lrp:banking',
    props = {
      'v_corp_fleeca_display',
    }
  },
  ['tills'] = {
    msg = 'Press R to Rob',
    action = 'lrp:robbery',
    props = {
      'prop_till_01',
      'prop_till_02',
      'p_till_01_s',
      'v_ret_gc_cashreg'
    }
  },
  ['safes'] = {
    msg = 'Press R to Rob',
    action = 'lrp:robbery',
    props = {
      'prop_ld_int_safe_01',
      'p_v_43_safe_s'
    }
  },
  ['bins'] = {
    msg = 'Press E to Search',
    action = 'lrp:search',
    props = {
      'prop_bin_04a',
      'prop_bin_10a',
      'prop_bin_10b',
      'prop_bin_11a',
      'prop_bin_11b',
      'prop_bin_12a',
      'prop_bin_beach_01d',
      'prop_bin_delpiero',
      'prop_bin_delpiero_b',
      'prop_cs_bin_01',
      'prop_cs_bin_01_skinned',
      'prop_cs_bin_02',
      'prop_cs_bin_03',
      'prop_recyclebin_02b',
      'prop_recyclebin_03_a'
    }
  },
  ['dumpsters'] = {
    msg = 'Press E to Search',
    action = 'lrp:search',
    props = {
      'p_dumpster_t',
      'prop_dumpster_01a',
      'prop_dumpster_02a',
      'prop_dumpster_02b',
      'prop_dumpster_3a',
      'prop_dumpster_4a',
      'prop_dumpster_4b',
      'prop_bin_14a',
      'prop_bin_14b'
    }
  },
  ['vend-water'] = {
    msg = 'Press E to Purchase',
    action = 'lrp:store',
    props = {
      'prop_vend_water_01'
    }
  },
  ['vend-green'] = {
    msg = 'Press E to Purchase',
    action = 'lrp:store',
    props = {
      'prop_vend_soda_02'
    }
  },
  ['vend-red'] = {
    msg = 'Press E to Purchase',
    action = 'lrp:store',
    props = {
      'prop_vend_soda_01'
    }
  },
  ['vend-drinks'] = {
    msg = 'Press E to Purchase',
    action = 'lrp:store',
    props = {
      'prop_vend_fridge01'
    }
  },
  ['vend-food'] = {
    msg = 'Press E to Purchase',
    action = 'lrp:store',
    props = {
      'prop_vend_snak_01_tu', 
      'prop_vend_snak_01'
    }
  },
  ['vend-cigarettes'] = {
    msg = 'Press E to Purchase',
    action = 'lrp:store',
    props = {
      'prop_vend_fags_01'
    }
  },
  ['vend-coffee'] = {
    msg = 'Press E to Purchase',
    action = 'lrp:store',
    props = {
      'prop_vend_coffe_01',
      'p_ld_coffee_vend_01',
      'apa_mp_h_acc_coffeemachine_01',
      'hei_heist_kit_coffeemachine_01' 
    }
  },
  ['REPAIR'] = {
    msg = 'REPAIR',
    action = 'lrp:store',
    props = {
     'v_46_carlift2' 
    }
  },
  ['SPRAY'] = {
    msg = 'REPAIR',
    action = 'lrp:store',
    props = {
     'v_ilev_spraydoor' 
    }
  },
  ['UPGRADE'] = {
    msg = 'UPGRADE',
    action = 'lrp:store',
    props = {
     'v_46_carlift' 
    }
  },
  ['vend-convenience'] = {
    msg = 'Press E to Purchase',
    action = 'lrp:store',
    props = {
     'v_ret_247_sweetcount' 
    }
  }
}

