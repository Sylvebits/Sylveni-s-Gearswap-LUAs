-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
texts = require('texts')
resist_timer = 0
last_spell_cast = nil

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
-------------------------------------------------------------------------------------------------------------------
-- HUD Setup
-------------------------------------------------------------------------------------------------------------------
hud_text = texts.new({
    pos = {x = 10, y = 10},
    text = {font='Arial', size=10, color={255,255,255}},
    bg = {alpha=200, red=30, green=30, blue=30},
    flags = {draggable=true},
    padding = 5
})
resist_hud = texts.new({
    pos = {x = 750, y = 750},
    text = {
        font = 'Arial',
        size = 14,
        color = {255, 100, 100},
        stroke = {width = 2, alpha = 255}
    },
    bg = {
        alpha = 0,  -- Transparent
        red = 0,
        green = 0,
        blue = 0
    },
    flags = {draggable = true},
    padding = 5
})
cast_hud = texts.new({
    pos = {x = 100, y = 150},
    text = {font='Arial', size=10, color={100,255,100}},
    bg = {alpha=200, red=0, green=0, blue=0},
    flags = {draggable=false},
    padding = 5
})
cast_timer = 0
function show_resist_alert(spell, message_type)
    local text = ''

    if message_type == 'completely' then
        text = 'Completely Resisted: ' .. spell.english
    elseif message_type == 'immunobreak' then
        text = 'Immunobreak: ' .. spell.english
    else
        text = 'Resisted: ' .. spell.english
    end

resist_hud:text(text)
resist_hud:show()
resist_timer = os.clock()

start_resist_flicker()

windower.play_sound(windower.addon_path .. 'data/sounds/resist.wav')
end

function update_hud()
    if hud_text then
        local offense = state.OffenseMode and state.OffenseMode.value or 'N/A'
        local weapon = state.WeaponSet and state.WeaponSet.value or 'N/A'

        hud_text:text(
            'IdleMode: ' .. state.IdleMode.value .. '\n' ..
            'OffenseMode: ' .. offense .. '\n' ..
            'WeaponSet: ' .. weapon .. '\n' ..
            'CastingMode: ' .. state.CastingMode.value
        )
        hud_text:show()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
-------------------------------------------------------------------------------------------------------------------

function job_setup()
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Single', 'Dual')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resist')
    state.IdleMode:options('Single', 'DT', 'DW', 'DWDT')
	state.WeaponSet = M{['description'] = 'DW Weapon Set', 'DWSword', 'DWClub', 'DWDagger', 'Single'}


    gear.default.obi_waist = "Sekhmet Corset"
    
    select_default_macro_book()
	
    -- Set default OffenseMode and WeaponSet depending on subjob
    if player.sub_job == 'NIN' then
        state.OffenseMode:set('Dual')
        state.WeaponSet:set('DWSword')
		state.IdleMode:set('DW')
    else
        state.OffenseMode:set('Single')
        state.WeaponSet:set('Single')
		state.IdleMode:set('Single')
    end
    if player.sub_job ~= 'NIN' then
        state.IdleMode:options('Single', 'DT')
    else
        state.IdleMode:options('Single', 'DT', 'Single', 'DW', 'DWDT')
    end
    update_hud()
end


-----------------------------------------------------------------------------
							-- Gear Sets --
-----------------------------------------------------------------------------
function init_gear_sets()

-----------------------------------------------------------------------------
-- Idle Sets
-----------------------------------------------------------------------------
    sets.resting ={

		ammo="Staunch Tathlum",
		head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy Tabard +2",
		hands="Malignance Gloves",
		legs={ name="Chironic Hose", augments={'Pet: Mag. Acc.+24','Pet: STR+13','"Refresh"+1','Accuracy+20 Attack+20','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		feet="Nyame Sollerets",
		neck="Null Loop",
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring",
		back="Moonbeam Cape",
	}
    sets.idle ={
			main="Daybreak",
			sub={ name="Forfend +1", augments={'Path: A',}},	
			ammo="Staunch Tathlum",
			head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
			body="Lethargy Sayon +2",
			hands="Malignance Gloves",
			legs="Nyame Flanchard",
			feet="Nyame Sollerets",
			neck="Null Loop",
			waist="Carrier's Sash",
			left_ear="Eabani Earring",
			right_ear="Odnowa Earring +1",
			left_ring="Defending Ring",
			right_ring="Shneddick Ring",
			back="Moonbeam Cape",
		}
    sets.idle.DW ={
			head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
			body="Lethargy Sayon +2",
			hands="Malignance Gloves",
			legs={ name="Chironic Hose", augments={'Pet: Mag. Acc.+24','Pet: STR+13','"Refresh"+1','Accuracy+20 Attack+20','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
			feet="Nyame Sollerets",
			neck="Null Loop",
			waist="Carrier's Sash",
			left_ear="Tuisto Earring",
			right_ear="Odnowa Earring +1",
			left_ring="Defending Ring",
			right_ring="Shneddick Ring",
			back="Moonbeam Cape",
		}	
	    sets.idle.DWDT ={
			head="Malignance Chapeau",
			body="Malignance Tabard",
			hands="Malignance Gloves",
			legs="Nyame Flanchard",
			feet="Nyame Sollerets",
			neck="Null Loop",
			waist="Carrier's Sash",
			left_ear="Tuisto Earring",
			right_ear="Odnowa Earring +1",
			left_ring="Defending Ring",
			right_ring="Shneddick Ring",
			back="Moonbeam Cape",
		}

    sets.idle.DT = {		
			main="Sakpata's Sword",
			sub={ name="Forfend +1", augments={'Path: A',}},
			ammo="Staunch Tathlum",
			head="Malignance Chapeau",
			body="Malignance Tabard",
			hands="Malignance Gloves",
			legs="Nyame Flanchard",
			feet="Nyame Sollerets",
			neck="Null Loop",
			waist="Carrier's Sash",
			left_ear="Eabani earring",
			right_ear="Odnowa Earring +1",
			left_ring="Defending Ring",
			right_ring="Shneddick Ring",
			back="Moonbeam Cape",
		}	
    sets.idle.MDT = {} 
    sets.idle.Mage = {}
	
-----------------------------------------------------------------------------
-- Engaged Sets
-----------------------------------------------------------------------------
    sets.engaged ={
			main="Naegling",
		--	sub={ name="Forfend +1", augments={'Path: A',}},
			range="Ullr",
			head="Malignance Chapeau",
			body="Malignance Tabard",
			hands="Malignance Gloves",
			legs="Jhakri Slops +2",
			feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
			neck="Null Loop",
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Sherida Earring",
			right_ear="Cessance Earring",
			left_ring="Ilabrat Ring",
			right_ring="Chirich Ring +1",
			back="Null Shawl",
		}
	sets.engaged.DW ={
			range="ullr",
			head="Malignance Chapeau",
			body="Malignance Tabard",
			hands="Malignance Gloves",
			legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
			feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
			neck="Null Loop",
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Sherida Earring",
			right_ear="Eabani Earring",
			left_ring="Ilabrat Ring",
			right_ring="Chirich Ring +1",
			back="Null Shawl",
		}
	sets.engaged.DWSword = set_combine(sets.engaged.DW, {main="Naegling",sub="Sakpata's Sword"})
	sets.engaged.DWClub = set_combine(sets.engaged.DW, {main="Daybreak",sub="Sakpata's Sword"})
	sets.engaged.DWDagger = set_combine(sets.engaged.DW, {main="Tauret",sub="Daybreak"})
	
	sets.engaged.Mage = {}
    sets.engaged.Defense = {} --Purposefully unused

-----------------------------------------------------------------------------
-- Weaponskill sets
-----------------------------------------------------------------------------	
    sets.precast.WS = {}
	
    sets.precast.WS['Requiescat'] = {}

    sets.precast.WS['Sanguine Blade'] = {}

	sets.precast.WS['Savage Blade'] = {    
			range="Ullr",
			head="Nyame Helm",
			body="Volte Harness",
			hands="Jhakri Cuffs +2",
			legs="Jhakri Slops +2",
			feet="Leth. Houseaux +2",
			neck="Anu Torque",
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			right_ear="Sherida Earring",
			left_ring="Ilabrat Ring",
			right_ring="Petrov Ring",
			back="Null Shawl",
		}	
	--------------------------------------
			--* PRECAST SETS *--
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard +1"}
    
    sets.precast.FC = {
			head="Atro. Chapeau +2",
			body={ name="Viti. Tabard +1", augments={'Enhances "Chainspell" effect',}},
			legs="Aya. Cosciales +2",
			feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
			neck="Voltsurge Torque",
			waist="Witful Belt",
			left_ear="Malignance Earring",
			right_ear="Loquac. Earring",
			left_ring="Kishar Ring",
			right_ring="Lebeche Ring",
			back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Spell interruption rate down-10%',}},
	}
	sets.precast.ENFEEBLING = set_combine(sets.precast.FC, {head="Leth. Chappel +2",})   
	
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

 
------------------------------------------------------
		-- Defining Sets
------------------------------------------------------	
		
			--Damage Taken Set--
		sets.base ={
				head="Malignance Chapeau",
				body="Malignance Tabard",
				hands="Malignance Gloves",
				legs="Nyame Flanchard",
				feet="Nyame Sollerets",
				neck="Null Loop",
				waist="Carrier's Sash",
				left_ear="Eabani Earring",
				right_ear="Odnowa Earring +1",
				left_ring="Defending Ring",
				back="Moonbeam Cape",
			}
			
		sets.buff.ComposureOther ={
				head="Leth. Chappel +2",
				body="Lethargy Sayon +2",
				hands="Atrophy Gloves +2",
				legs="Leth. Fuseau +2",
				feet="Leth. Houseaux +2",
			}
			
		sets.buff.Saboteur = {
				hands="Leth. Gantherots +2"		
			}	
			
			--570+ Enhancing Skill--		
		sets.midcast['Enhancing Magic'] = set_combine(sets.base,{
				sub={ name="Forfend +1", augments={'Path: A',}},
				head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
				body={ name="Viti. Tabard +1", augments={'Enhances "Chainspell" effect',}},
				hands={ name="Viti. Gloves +1", augments={'Enhancing Magic duration',}},
				legs="Atrophy Tights +2",
				feet="Leth. Houseaux +2",
				neck="Incanter's Torque",
				waist="Olympus Sash",
				left_ear="Mimir Earring",
				left_ring="Stikini Ring",
				right_ring="Stikini Ring",
				back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +4','Enha.mag. skill +9','Enh. Mag. eff. dur. +19',}},
			})	
			
			--505 Enhancing Skill--
		sets.midcast.EnhancingDuration =  set_combine(sets.midcast['Enhancing Magic'],{
				head="Leth. Chappel +2",
				body="Lethargy Sayon +2",
				hands="Atrophy Gloves +2",
								waist="Embla Sash",
				legs="Leth. Fuseau +2",
				feet="Leth. Houseaux +2",
				back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +4','Enha.mag. skill +9','Enh. Mag. eff. dur. +19',}},
			})			
 
-----------------------------------------------------------------------------
			--* MIDCAST SETS *--
-----------------------------------------------------------------------------

    sets.midcast.FastRecast = {}

-----------------------------------------------------------------------------
-- Curing Magic
-----------------------------------------------------------------------------
    sets.midcast.Cure ={
			main="Daybreak",
			sub={ name="Forfend +1", augments={'Path: A',}},
			ammo="Staunch Tathlum",
			head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
			body="Malignance Tabard",
			hands="Malignance Gloves",
			legs={ name="Chironic Hose", augments={'Mag. Acc.+22','"Cure" potency +10%','MND+15','"Mag.Atk.Bns."+4',}},
			feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
			neck="Incanter's Torque",
			left_ear="Mendi. Earring",
			right_ear="Loquac. Earring",
			left_ring="Defending Ring",
			right_ring="Stikini Ring",
			back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Spell interruption rate down-10%',}},
						}
		
    sets.midcast.Curaga = {}
	sets.midcast.Cursna = {}
    sets.midcast.CureSelf ={
			main="Daybreak",
			sub={ name="Forfend +1", augments={'Path: A',}},
			ammo="Staunch Tathlum",
			head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
			body="Malignance Tabard",
			hands="Malignance Gloves",
			legs={ name="Chironic Hose", augments={'Mag. Acc.+22','"Cure" potency +10%','MND+15','"Mag.Atk.Bns."+4',}},
			feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
			neck="Incanter's Torque",
			waist="Gishdubar Sash",
			left_ear="Mendi. Earring",
			right_ear="Loquac. Earring",
			left_ring="Defending Ring",
			right_ring="Stikini Ring",
			back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Spell interruption rate down-10%',}},
}

-----------------------------------------------------------------------------
-- Enhancing Magic
-----------------------------------------------------------------------------
	
	sets.midcast.Temper = set_combine(sets.midcast.EnhancingDuration)
		
    sets.midcast.Refresh = set_combine(
		sets.midcast.EnhancingDuration, 
			{legs="Leth. Fuseau +2", 
				body="Atrophy Tabard +2",})   
			
	sets.midcast.RefreshSelf = set_combine(
		sets.midcast.EnhancingDuration, 
			{legs="Leth. Fuseau +2", 
				waist="Gishdubar Sash",
				body="Atrophy Tabard +2",})   

    sets.midcast.Stoneskin= set_combine(
		sets.midcast['Enhancing Magic'], 
			{waist="Siegel sash",
				legs="Shedir seraweels",})
				
	sets.midcast.Phalanx = set_combine(sets.midcast.EnhancingDuration)
	
	sets.midcast.Haste = set_combine(sets.midcast.EnhancingDuration)
	
	sets.midcast.PhalanxSelf = set_combine(
		sets.midcast['Enhancing Magic'], 
			{main="Sakpata's Sword",
				ammo="Staunch Tathlum",
				body={ name="Taeon Tabard", augments={'Spell interruption rate down -8%','Phalanx +3',}},
				hands={ name="Taeon Gloves", augments={'Spell interruption rate down -10%','Phalanx +3',}},
				legs={ name="Taeon Tights", augments={'Spell interruption rate down -7%','Phalanx +3',}},
				feet={ name="Taeon Boots", augments={'Spell interruption rate down -10%','Phalanx +3',}},
				waist="Gishdubar Sash",})
				
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
			{legs="Shedir seraweels",})
	
	
-----------------------------------------------------------------------------
-- Enfeebling Magic
-----------------------------------------------------------------------------
	
	sets.midcast['Enfeebling Magic'] ={
			head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
			body="Atrophy Tabard +2",
			hands="Leth. Ganth. +2",
			legs={ name="Chironic Hose", augments={'Mag. Acc.+28','MND+13','"Mag.Atk.Bns."+4',}},
			feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
			left_ring="Stikini Ring",
			right_ring="Stikini Ring",
		}
	
	
	
	--------------------------
	-- Enfeebling Skill Based
	--------------------------
	sets.midcast['Distract II'] ={
			main="Daybreak",
			sub={ name="Forfend +1", augments={'Path: A',}},
			range="Ullr",
			head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
			body="Lethargy Sayon +2",
			hands="Leth. Ganth. +2",
			legs={ name="Psycloth Lappas", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
			feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
			neck="Null Loop",
			waist="Luminary Sash",
			left_ear="Malignance Earring",
			right_ear="Snotra Earring",
			left_ring="Stikini Ring",
			right_ring="Stikini Ring",
			back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Spell interruption rate down-10%',}},
		}
	sets.midcast['Frazzle II'] ={
			main="Daybreak",
			sub={ name="Forfend +1", augments={'Path: A',}},
			range="Ullr",
			head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
			body="Lethargy Sayon +2",
			hands="Leth. Ganth. +2",
			legs={ name="Psycloth Lappas", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
			feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
			neck="Null Loop",
			waist="Luminary Sash",
			left_ear="Malignance Earring",
			right_ear="Snotra Earring",
			left_ring="Stikini Ring",
			right_ring="Stikini Ring",
			back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Spell interruption rate down-10%',}},
		}
	sets.midcast['Distract III'] ={}
	sets.midcast['Frazzle III'] = {}

	-----------------------------
	-- Magic Accuracy(.resist) & Duration
	-----------------------------
	sets.midcast['Sleep'] ={
			main="Naegling",
			sub={ name="Forfend +1", augments={'Path: A',}},
			range="Ullr",
			head="Leth. Chappel +2",
			body="Lethargy Sayon +2",
			hands="Leth. Ganth. +2",
			legs="Leth. Fuseau +2",
			feet="Leth. Houseaux +2",
			neck="Null Loop",
			waist="Luminary Sash",
			left_ear="Malignance Earring",
			right_ear="Snotra Earring",
			left_ring="Stikini Ring",
			right_ring="Kishar Ring",
			back="Null Shawl",
		}
	sets.midcast['Sleep'].resist = set_combine(sets.midcast['Sleep'],{	right_ring="Stikini Ring", 		
			legs={ name="Chironic Hose", augments={'Mag. Acc.+28','MND+13','"Mag.Atk.Bns."+4',}},})
			
	sets.midcast['Sleep II'] ={
			main="Naegling",
			sub={ name="Forfend +1", augments={'Path: A',}},
			range="Ullr",
			head="Leth. Chappel +2",
			body="Lethargy Sayon +2",
			hands="Leth. Ganth. +2",
			legs="Leth. Fuseau +2",
			feet="Leth. Houseaux +2",
			neck="Null Loop",
			waist="Luminary Sash",
			left_ear="Malignance Earring",
			right_ear="Snotra Earring",
			left_ring="Stikini Ring",
			right_ring="Kishar Ring",
			back="Null Shawl",
		}
	sets.midcast['Sleep II'].resist = set_combine(sets.midcast['Sleep II'],{	right_ring="Stikini Ring", 		
			legs={ name="Chironic Hose", augments={'Mag. Acc.+28','MND+13','"Mag.Atk.Bns."+4',}},})
	
	sets.midcast['Silence'] ={
			main="Naegling",
			sub={ name="Forfend +1", augments={'Path: A',}},
			range="Ullr",
			head="Leth. Chappel +2",
			body="Lethargy Sayon +2",
			hands="Leth. Ganth. +2",
			legs="Leth. Fuseau +2",
			feet="Leth. Houseaux +2",
			neck="Null Loop",
			waist="Luminary Sash",
			left_ear="Malignance Earring",
			right_ear="Snotra Earring",
			left_ring="Stikini Ring",
			right_ring="Kishar Ring",
			back="Null Shawl",
		}
	sets.midcast['Silence'].resist = set_combine(sets.midcast['Silence'],{	right_ring="Stikini Ring", 		
			legs={ name="Chironic Hose", augments={'Mag. Acc.+28','MND+13','"Mag.Atk.Bns."+4',}},})
	
	sets.midcast['Bind'] ={
			main="Naegling",
			sub={ name="Forfend +1", augments={'Path: A',}},
			range="Ullr",
			head="Leth. Chappel +2",
			body="Lethargy Sayon +2",
			hands="Leth. Ganth. +2",
			legs="Leth. Fuseau +2",
			feet="Leth. Houseaux +2",
			neck="Null Loop",
			waist="Luminary Sash",
			left_ear="Malignance Earring",
			right_ear="Snotra Earring",
			left_ring="Stikini Ring",
			right_ring="Kishar Ring",
			back="Null Shawl",
		}
	sets.midcast['Bind'].resist = set_combine(sets.midcast['Bind'],{	right_ring="Stikini Ring", 		
			legs={ name="Chironic Hose", augments={'Mag. Acc.+28','MND+13','"Mag.Atk.Bns."+4',}},})
			
	sets.midcast['Dia III'] ={
			main="Naegling",
			sub={ name="Forfend +1", augments={'Path: A',}},
			range="Ullr",
			head="Leth. Chappel +2",
			body="Lethargy Sayon +2",
			hands="Leth. Ganth. +2",
			legs="Leth. Fuseau +2",
			feet="Leth. Houseaux +2",
			neck="Null Loop",
			waist="Luminary Sash",
			left_ear="Malignance Earring",
			right_ear="Snotra Earring",
			left_ring="Stikini Ring",
			right_ring="Kishar Ring",
			back="Null Shawl",
		}
	
	sets.midcast['Dispel'] ={
			main="Naegling",
			sub={ name="Forfend +1", augments={'Path: A',}},
			range="Ullr",
			head="Leth. Chappel +2",
			body="Lethargy Sayon +2",
			hands="Leth. Gantherots +2",
			waist="Luminary Sash",
			legs={ name="Chironic Hose", augments={'Mag. Acc.+28','MND+13','"Mag.Atk.Bns."+4',}},
			feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
			neck="Null Loop",
			left_ear="Crep. Earring",
			right_ear="Malignance Earring",
			left_ring="Stikini Ring",
			right_ring="Stikini Ring",
			back="Null Shawl",
	}	
	sets.midcast['Break'] ={
			main="Naegling",
			sub={ name="Forfend +1", augments={'Path: A',}},
			range="Ullr",
			head="Leth. Chappel +2",
			body="Lethargy Sayon +2",
			hands="Leth. Ganth. +2",
			legs="Leth. Fuseau +2",
			feet="Leth. Houseaux +2",
			neck="Null Loop",
			waist="Luminary Sash",
			left_ear="Malignance Earring",
			right_ear="Snotra Earring",
			left_ring="Stikini Ring",
			right_ring="Kishar Ring",
			back="Null Shawl",
		}
	
	-----------------------------
	-- 	Mind-Scaling Spells 
	-----------------------------	
	sets.midcast['Slow'] ={
		main="Naegling",
		sub={ name="Forfend +1", augments={'Path: A',}},
		range="Ullr",
		head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +2",
		hands="Leth. Gantherots +2",
		legs={ name="Psycloth Lappas", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
		feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
		neck="Dls. Torque +1",
		waist="Luminary Sash",
		right_ear="Malignance Earring",
		left_ear="Snotra Earring",
		left_ring="Stikini Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Spell interruption rate down-10%',}},
}
		--Resistant Set
	sets.midcast['Slow'].resist ={
		main="Naegling",
		sub={ name="Forfend +1", augments={'Path: A',}},
		range="Ullr",
		head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +2",
		hands="Leth. Gantherots +2",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+28','MND+13','"Mag.Atk.Bns."+4',}},
		feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
		neck="Dls. Torque +1",
		waist="Luminary Sash",
		right_ear="Malignance Earring",
		left_ear="Snotra Earring",
		left_ring="Stikini Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Spell interruption rate down-10%',}},
}
		
    sets.midcast['Slow II'] ={
		main="Naegling",
		sub={ name="Forfend +1", augments={'Path: A',}},
		range="Ullr",
		head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +2",
		hands="Leth. Gantherots +2",
		legs={ name="Psycloth Lappas", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
		feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
		neck="Dls. Torque +1",
		waist="Luminary Sash",
		right_ear="Malignance Earring",
		left_ear="Snotra Earring",		
		left_ring="Stikini Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Spell interruption rate down-10%',}},
}
		--Resistant Set
	sets.midcast['Slow II'].resist ={
		main="Naegling",
		sub={ name="Forfend +1", augments={'Path: A',}},
		range="Ullr",
		head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +2",
		hands="Leth. Gantherots +2",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+28','MND+13','"Mag.Atk.Bns."+4',}},
		feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
		neck="Dls. Torque +1",
		waist="Luminary Sash",
		right_ear="Malignance Earring",
		left_ear="Snotra Earring",
		left_ring="Stikini Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Spell interruption rate down-10%',}},
}

	sets.midcast['Paralyze'] ={
		main="Naegling",
		sub={ name="Forfend +1", augments={'Path: A',}},
		range="Ullr",
		head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +2",
		hands="Leth. Gantherots +2",
		legs={ name="Psycloth Lappas", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
		feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
		neck="Dls. Torque +1",
		waist="Luminary Sash",
		left_ear="Snotra Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Spell interruption rate down-10%',}},
}

	sets.midcast['Paralyze II'] ={
		main="Naegling",
		sub={ name="Forfend +1", augments={'Path: A',}},
		range="Ullr",
		head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +2",
		hands="Leth. Gantherots +2",
		legs={ name="Psycloth Lappas", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
		feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
		neck="Dls. Torque +1",
		waist="Luminary Sash",
		left_ear="Snotra Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Spell interruption rate down-10%',}},
}
		--Resistant Set
	sets.midcast['Paralyze'].resist ={
				main="Naegling",
				sub={ name="Forfend +1", augments={'Path: A',}},
				range="Ullr",
				head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
				body="Lethargy Sayon +2",
				hands="Leth. Gantherots +2",
				legs={ name="Chironic Hose", augments={'Mag. Acc.+28','MND+13','"Mag.Atk.Bns."+4',}},
				feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
				neck="Dls. Torque +1",
				waist="Luminary Sash",
				left_ear="Snotra Earring",
				right_ear="Malignance Earring",
				left_ring="Stikini Ring",
				right_ring="Metamor. Ring +1",
				back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Spell interruption rate down-10%',}},
		}
		--Resistant Set
	sets.midcast['Paralyze II'].resist ={
				main="Naegling",
				sub={ name="Forfend +1", augments={'Path: A',}},
				range="Ullr",
				head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
				body="Lethargy Sayon +2",
				hands="Leth. Gantherots +2",
				legs={ name="Chironic Hose", augments={'Mag. Acc.+28','MND+13','"Mag.Atk.Bns."+4',}},
				feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
				neck="Dls. Torque +1",
				waist="Luminary Sash",
				left_ear="Snotra Earring",
				right_ear="Malignance Earring",
				left_ring="Stikini Ring",
				right_ring="Metamor. Ring +1",
				back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Spell interruption rate down-10%',}},
		}
	sets.midcast['Addle'] ={
				main="Naegling",
				sub={ name="Forfend +1", augments={'Path: A',}},
				range="Ullr",
				head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
				body="Lethargy Sayon +2",
				hands="Leth. Gantherots +2",
				legs={ name="Psycloth Lappas", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
				feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
				neck="Dls. Torque +1",
				waist="Luminary Sash",
				left_ear="Snotra Earring",		
				right_ear="Malignance Earring",
				left_ring="Stikini Ring",
				right_ring="Metamor. Ring +1",
				back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Spell interruption rate down-10%',}},
		}	
		
	sets.midcast['Addle II'] ={
				main="Naegling",
				sub={ name="Forfend +1", augments={'Path: A',}},
				range="Ullr",
				head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
				body="Lethargy Sayon +2",
				hands="Leth. Gantherots +2",
				legs={ name="Psycloth Lappas", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
				feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
				neck="Dls. Torque +1",
				waist="Luminary Sash",
				left_ear="Snotra Earring",
				right_ear="Malignance Earring",
				left_ring="Stikini Ring",
				right_ring="Metamor. Ring +1",
				back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Spell interruption rate down-10%',}},
		}
	-----------------------------
	-- 	Int-Scaling Spells 
	-----------------------------	
	sets.midcast['Blind'] ={
				main="Naegling",
				sub={ name="Forfend +1", augments={'Path: A',}},
				range="Ullr",
				head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
				body="Lethargy Sayon +2",
				hands="Leth. Gantherots +2",
				legs={ name="Psycloth Lappas", augments={'MP+50','INT+7','"Conserve MP"+6',}},
				feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
				neck="Dls. Torque +1",
				waist="Acuity Belt +1",
				left_ear="Snotra Earring",
				right_ear="Malignance Earring",
				left_ring="Stikini Ring",
				right_ring="Metamor. Ring +1",
				back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		}	
	sets.midcast['Blind II'] ={
				main="Naegling",
				sub={ name="Forfend +1", augments={'Path: A',}},
				range="Ullr",
				head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
				body="Lethargy Sayon +2",
				hands="Leth. Gantherots +2",
				legs={ name="Psycloth Lappas", augments={'MP+50','INT+7','"Conserve MP"+6',}},
				feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
				neck="Dls. Torque +1",
				waist="Acuity Belt +1",
				left_ear="Snotra Earring",
				right_ear="Malignance Earring",
				left_ring="Stikini Ring",
				right_ring="Metamor. Ring +1",
				back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		}
	


	sets.midcast['Gravity'] = {}	
	sets.midcast['Gravity II'] = {}
	sets.midcast['Poison'] = {}
	
-----------------------------------------------------------------------------
		-- Elemental Magic
-----------------------------------------------------------------------------
    sets.midcast['Elemental Magic'] ={
				main="Daybreak",
				sub={ name="Forfend +1", augments={'Path: A',}},
				head="Leth. Chappel +2",
				body="Lethargy Sayon +2",
				hands="Leth. Ganth. +2",
				legs="Leth. Fuseau +2",
				feet="Leth. Houseaux +2",
				neck="Null Loop",
				waist="Acuity Belt +1",
				left_ear="Friomisi Earring",
				right_ear="Malignance Earring",
				left_ring="Defending Ring",
				right_ring="Shneddick Ring",
				back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
			}
	sets.midcast['Elemental Magic'].DW =set_combine(sets.midcast['Elemental Magic'],{main="Daybreak", sub="Naegling"})	
    sets.midcast['Elemental Magic'].Resist = {}
    
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {}

    sets.midcast.Stun = {}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {ring1="Excelsis Ring", waist="Fucho-no-Obi"})

    sets.midcast.Aspir = sets.midcast.Drain

-----------------------------------------------------------------------------
-- Extra Sets
-----------------------------------------------------------------------------


end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    last_spell_cast = spell
    if spell.skill == 'Enfeebling Magic' then
        equip(sets.precast.ENFEEBLING)
        eventArgs.handled = true -- Prevents Mote from equipping FC
    end
-- Lock slots during spellcasting in Dual mode, except when in Resist mode with a defined resist set
if state.OffenseMode.current == 'Dual' and spell.action_type == 'Magic' then
    local has_resist_set = sets.midcast[spell.english] and sets.midcast[spell.english].resist
    if not (state.CastingMode.current == 'Resist' and has_resist_set) then
        disable('main', 'sub', 'range', 'ammo')
    else
        enable('main', 'sub', 'range', 'ammo') -- ensure fully unlocked for max accuracy
    end
end


end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.

function job_post_midcast(spell, action, spellMap, eventArgs)
if spell.skill == 'Elemental Magic' then
    if state.OffenseMode.current == 'Dual' and player.status == 'Idle' then
        equip(sets.midcast['Elemental Magic'].DW)
    else
        equip(sets.midcast['Elemental Magic'])
    end
end
    -- Enfeebling Magic resist handling
    if spell.skill == 'Enfeebling Magic' then
        if state.CastingMode.value == 'Resist' and sets.midcast[spell.english] and sets.midcast[spell.english].resist then
            equip(sets.midcast[spell.english].resist)
        elseif state.Buff.Saboteur then
            equip(sets.buff.Saboteur)
        end

    elseif spell.skill == 'Enhancing Magic' then
        -- Specific spell overrides first
        if spell.english == 'Phalanx' or spell.english == 'Phalanx II' then
            if spell.target.type == 'SELF' then
                equip(sets.midcast.PhalanxSelf)
            else
                equip(sets.midcast.Phalanx)
            end

        elseif spell.english:startswith('Refresh') then
            if spell.target.type == 'SELF' then
                equip(sets.midcast.RefreshSelf)
            else
                equip(sets.midcast.Refresh)
            end

        elseif spell.english == 'Aquaveil' then
            equip(sets.midcast.Aquaveil)

        elseif spell.english == 'Temper' then
            equip(sets.midcast.Temper)
        elseif spell.english == 'Haste II' then
            equip(sets.midcast.Haste)		
		elseif spell.english:startswith('Gain') then
            equip(sets.midcast.EnhancingDuration)
        elseif spell.english == 'Stoneskin' then
            equip(sets.midcast.Stoneskin)

        else
            -- Default fallback Enhancing Magic
            equip(sets.midcast['Enhancing Magic'])
        end

        -- Apply Composure gear if buff active and target is a player
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther) 
        end

    elseif spell.skill == 'Healing Magic' then
        -- Cure for self-targeting
        if spellMap == 'Cure' and spell.target.type == 'SELF' then
            equip(sets.midcast.CureSelf)
        end
    end

    -- Enable weapon swapping if casting non-resist mode while not engaged
    if state.OffenseMode.current == 'Dual'
        and state.CastingMode.current ~= 'Resist'
        and player.status ~= 'Engaged' then
        enable('main', 'sub', 'range', 'ammo')
    end
end



-------------------------------------------------------------------------------------------------------------------
-- HUD Functions
-------------------------------------------------------------------------------------------------------------------


function job_aftercast(spell, action, spellMap, eventArgs)
    -- No action needed anymore — we handle resists in the packet listener
end

function start_resist_flicker()
    local flicker_on = true

    local function flicker()
        local now = os.clock()
        if not resist_hud or not resist_hud:visible() or (now - resist_timer) > 4 then
            -- Stop flickering when HUD is hidden or expired
            return
        end

        if flicker_on then
            resist_hud:color(255, 255, 255) -- flash white
        else
            resist_hud:color(255, 100, 100) -- normal red
        end

        flicker_on = not flicker_on
        coroutine.schedule(flicker, 0.1)
    end

    coroutine.schedule(flicker, 0.1)
end


function show_cast_alert(spell)
    cast_hud:text('Cast: ' .. spell.english)
    cast_hud:show()
    cast_timer = os.clock()
end
function play_toggle_sound()
    windower.play_sound(windower.addon_path .. 'data/sounds/001.wav')
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
if newValue == 'Dual' then
    enable('main','sub','range')
    state.WeaponSet:set('DWSword')
    state.IdleMode:set('DW')
    update_hud()
        else
    if newValue == 'Single' then
        enable('main','sub','range','ammo')  -- Unlock slots when going to Single mode
    end

    if state.WeaponSet and state.WeaponSet.value ~= 'Single' then
        state.WeaponSet:set('Single')
    end
    state.IdleMode:set('Single')
end
play_toggle_sound()
    end
if stateField == 'WeaponSet' then
    local ws = select_engaged_set()
    if ws then
        local weapon_slots = {}
        if ws.main then weapon_slots.main = ws.main end
        if ws.sub then weapon_slots.sub = ws.sub end

        enable('main','sub')
        equip(weapon_slots)
        disable('main','sub')
    end

end

    -- Automatically engage DW set if subjob is NIN
    if stateField == 'Offense Mode' and player.sub_job == 'NIN' and newValue ~= 'Dual' then
        equip(sets.engaged.DW)
    end

    if stateField == 'IdleMode' or stateField == 'HybridMode' or stateField == 'CastingMode' then
        handle_equipping_gear(player.status)
    end

    update_hud()
end
function customize_melee_set(meleeSet)
    if player.sub_job == 'NIN' and state.OffenseMode.current == 'Dual' then
        if state.WeaponSet.current == 'DWClub' and sets.engaged.DWClub then
            meleeSet = sets.engaged.DWClub
        elseif state.WeaponSet.current == 'DWDagger' and sets.engaged.DWDagger then
            meleeSet = sets.engaged.DWDagger
        elseif sets.engaged.DWSword then
            meleeSet = sets.engaged.DWSword
        else
            meleeSet = sets.engaged.DW
        end

    elseif state.OffenseMode.current == 'Mage' and sets.engaged.Mage then
        meleeSet = sets.engaged.Mage
    else
        meleeSet = sets.engaged
    end

    return meleeSet
end

function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        equip(select_engaged_set())
      --  disable('main', 'sub', 'range', 'ammo') -- lock after proper gear is on
    elseif oldStatus == 'Engaged' then
        enable('main', 'sub', 'range', 'ammo') -- unlock when disengaged
    end
end

function select_engaged_set()
        if state.OffenseMode.current == 'Single' and sets.engaged then
        return sets.engaged
		elseif player.sub_job == 'NIN' and state.OffenseMode.current == 'Dual' then
        if state.WeaponSet.current == 'DWClub' and sets.engaged.DWClub then
            return sets.engaged.DWClub
        elseif state.WeaponSet.current == 'DWDagger' and sets.engaged.DWDagger then
            return sets.engaged.DWDagger
        elseif sets.engaged.DWSword then
            return sets.engaged.DWSword
        else
            return sets.engaged.DW
        end
    elseif state.OffenseMode.current == 'Mage' and sets.engaged.Mage then
        return sets.engaged.Mage
    else
        return sets.engaged
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
--function customize_idle_set(idleSet)
   -- if player.sub_job == 'NIN' and state.OffenseMode.current == 'Dual' and sets.idle.DW then
   --     idleSet = sets.idle.DW
   -- elseif state.IdleMode.current == 'DT' and sets.idle.dt then
   --     idleSet = sets.idle.dt
   --  elseif state.IdleMode.current == 'normal' and sets.idle then
   --     idleSet = sets.idle
   -- end
function customize_idle_set(idleSet)   
    if state.IdleMode.current == 'DW' and sets.idle.DW then
        idleSet = sets.idle.DW
    elseif state.IdleMode.current == 'DT' and sets.idle.DT then
        idleSet = sets.idle.DT
    elseif state.IdleMode.current == 'Single' and sets.idle.Single then
        idleSet = sets.idle.Single
	    elseif state.IdleMode.current == 'DWDT' and sets.idle.DWDT then
        idleSet = sets.idle.DWDT
    end
	
    if player.sub_job == 'NIN' and state.OffenseMode.current == 'Dual' then
        local weaponSet = select_engaged_set()
        idleSet = set_combine(idleSet, {main = weaponSet.main, sub = weaponSet.sub})
    end
local weaponSet = select_engaged_set()
if weaponSet and weaponSet.main and weaponSet.sub then
    idleSet = set_combine(idleSet, {
        main = weaponSet.main,
        sub = weaponSet.sub
    })
end
    if player.mpp < 51 and sets.latent_refresh then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'SCH' then
        set_macro_page(2, 12)
	else
        set_macro_page(1, 12)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- HUD Functions --
-------------------------------------------------------------------------------------------------------------------


windower.register_event('prerender', function()
    local now = os.clock()

    if resist_hud and resist_hud:visible() then
        local time_visible = now - resist_timer
        if time_visible > 4 then
            resist_hud:hide()
        elseif time_visible > 3 then
            local alpha = math.floor(255 * (4 - time_visible))
            resist_hud:alpha(alpha)
            -- no background fade anymore
        else
            resist_hud:alpha(255)
        end
    end
end)


windower.register_event('action', function(act)
    if not last_spell_cast then return end

    if act.category == 4 and act.targets then
        for _, target in ipairs(act.targets) do
            for _, action in ipairs(target.actions or {}) do
                local msg = action.message

                if msg then
                    if msg == 655 or msg == 656 then
                        show_resist_alert(last_spell_cast, 'completely')
                        last_spell_cast = nil
                        return
                    elseif msg == 653 or msg == 654 then
                        show_resist_alert(last_spell_cast, 'immunobreak')
                        last_spell_cast = nil
                        return
                    elseif msg == 85 or msg == 284 then
                        show_resist_alert(last_spell_cast, 'resist')
                        last_spell_cast = nil
                        return
                    end
                end
            end
        end
    end
end)

