-- *** Credit goes to Flippant for helping me with Gearswap *** --
-- ** I Use Some of Motenten's Functions ** --

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end
texts = require('texts')

hud_text = texts.new({
    pos = {x = 10, y = 10},
    text = {font='Arial', size=10, color={255,255,255}},
    bg = {alpha=200, red=30, green=30, blue=30},
    flags = {draggable=true},
    padding = 5
})

function update_hud()
    if hud_text then
        local offense = state.OffenseMode and state.OffenseMode.value or 'N/A'
        local idle = state.IdleMode and state.IdleMode.value or 'N/A'
        local casting = state.CastingMode and state.CastingMode.value or 'N/A'
        local weapon = state.WeaponSet and state.WeaponSet.value or 'N/A' -- (optional for later)

        hud_text:text(
            'IdleMode: ' .. idle .. '\n' ..
            'OffenseMode: ' .. offense .. '\n' ..
            'CastingMode: ' .. casting
            -- If you later add WeaponSet: .. '\nWeaponSet: ' .. weapon
        )
        hud_text:show()
    end
end

function user_setup()

		state.OffenseMode:options('TP', 'ParryTank', 'Tank', 'Hybrid', 'TPACC')
		state.IdleMode:options('Normal', 'IdleTank', 'IdleMEVA')
		state.CastingMode:options('Normal', 'SIRD')
		update_hud()
	
end


function init_gear_sets()


-----------------------------------------------------------------------------
-- Idle Sets
-----------------------------------------------------------------------------
		sets.idle = {    
					ammo="Staunch Tathlum",
					head="Nyame Helm",
					body="Erilaz Surcoat +2",
					hands="Nyame Gauntlets",
					legs="Eri. Leg Guards +2",
					feet="Erilaz Greaves +2",
					neck="Null Loop",
					waist="Carrier's Sash",
					left_ear="Odnowa Earring +1",
					right_ear="Tuisto Earring",
					left_ring="Moonbeam Ring",
					right_ring="Shneddick Ring",
					back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Damage taken-5%',}},
				}
		sets.idle.Normal = {    
				    ammo="Staunch Tathlum",
					head="Nyame Helm",
					body="Runeist Coat +2",
					hands="Nyame Gauntlets",
					legs="Eri. Leg Guards +2",
					feet="Erilaz Greaves +2",
					neck="Null Loop",
					waist="Carrier's Sash",
					left_ear="Odnowa Earring +1",
					right_ear="Tuisto Earring",
					left_ring="Moonbeam Ring",
					right_ring="Shneddick Ring",
					back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Damage taken-5%',}},
				}
		sets.idle.IdleTank = {
					ammo="Staunch Tathlum",
					head="Nyame Helm",
					body="Erilaz Surcoat +2",
					hands="Nyame Gauntlets",
					legs="Eri. Leg Guards +2",
					feet="Erilaz Greaves +2",
					neck="Null Loop",
					waist="Flume Belt",
					left_ear="Odnowa Earring +1",
					right_ear="Tuisto Earring",
					left_ring="Moonbeam Ring",
					right_ring="Shneddick Ring",
					back="Moonbeam Cape",
				}
		sets.idle.IdleMEVA = {    
					ammo="Staunch Tathlum",
					head="Nyame Helm",
					body="Nyame Mail",
					hands="Nyame Gauntlets",
					legs="Nyame Flanchard",
					feet="Erilaz Greaves +2",
					neck="Null Loop",
					waist="Carrier's Sash",
					left_ear="Eabani Earring",
					right_ear="Tuisto Earring",
					left_ring="Moonbeam Ring",
					right_ring="Shneddick Ring",
					back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Damage taken-5%',}},
				}
-----------------------------------------------------------------------------
-- Engaged Sets
-----------------------------------------------------------------------------	
		-- DD TP	
		sets.engaged.TP ={
				ammo="Ginsen",
				head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
				body="Ayanmo Corazza +2",
				hands={ name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}},
				legs="Meg. Chausses +2",
				feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
				neck="Anu Torque",
				waist="Ioskeha Belt",
				left_ear="Sherida Earring",
				right_ear="Crep. Earring",
				left_ring="Ilabrat Ring",
				right_ring="Niqmaddu Ring",
				back="Null Shawl",
			}
		-- Acc DD TP	
		sets.engaged.TPACC ={    
				ammo="Seething Bomblet",
				head="Erilaz Galea +2",
				body="Ayanmo Corazza +2",
				hands={ name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}},
				legs="Eri. Leg Guards +2",
				feet="Erilaz Greaves +2",
				neck="Null Loop",
				waist="Ioskeha Belt",
				left_ear="Crep. Earring",
				right_ear="Sherida Earring",
				left_ring="Ilabrat Ring",
				right_ring="Chirich Ring +1",
				back="Null Shawl",
			}
		-- Parry Tanking	
		sets.engaged.ParryTank ={
				ammo="Staunch Tathlum",
				head="Nyame Helm",
				body="Nyame Mail",
				hands="Turms Mittens",
				legs="Eri. Leg Guards +2",
				feet="Turms Leggings",
				neck="Null Loop",
				waist="Ioskeha Belt",
				left_ear="Odnowa Earring +1",
				right_ear="Eabani Earring",
				left_ring="Moonbeam Ring",
				right_ring="Defending Ring",
				back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+2%',}},
			}
		-- Non-Parry Tanking	
		sets.engaged.Tank ={
				ammo="Staunch Tathlum",
				head="Nyame Helm",
				body="Erilaz Surcoat +2",
				hands="Nyame Gauntlets",
				legs="Eri. Leg Guards +2",
				feet="Erilaz Greaves +2",
				neck="Moonbeam Necklace",
				waist="Ioskeha Belt",
				left_ear="Odnowa Earring +1",
				right_ear="Tuisto Earring",
				left_ring="Moonbeam Ring",
				right_ring="Chirich Ring +1",
				back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Damage taken-5%',}},
			}
		-- Hybrid/-DT/DPS Tanking
		sets.engaged.Hybrid ={
				ammo="Staunch Tathlum",
				head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
				body="Ayanmo Corazza +2",
				hands={ name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}},
				legs="Eri. Leg Guards +2",
				feet="Erilaz Greaves +2",
				neck="Null Loop",
				waist="Ioskeha Belt",
				left_ear="Crep. Earring",
				right_ear="Sherida Earring",
				left_ring="Moonbeam Ring",
				right_ring="Chirich Ring +1",
				back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Damage taken-5%',}},
			}
		
-----------------------------------------------------------------------------
-- Weaponskill sets
-----------------------------------------------------------------------------
		sets.WS = {}
			sets.WS['Resolution'] = {    
				ammo="Knobkierrie",
				head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
				body="Ayanmo Corazza +2",
				hands={ name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}},
				legs="Meg. Chausses +2",
				feet={ name="Herculean Boots", augments={'Accuracy+8','Weapon skill damage +4%','STR+12','Attack+10',}},
				neck="Fotia Gorget",
				waist="Fotia Belt",
				left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
				right_ear="Sherida Earring",
				left_ring="Niqmaddu Ring",
				right_ring="Ilabrat Ring",
				back={ name="Ogma's Cape", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
			}
		sets.WS['Dimidiation'] = {    
				ammo="Knobkierrie",
				head={ name="Herculean Helm", augments={'Attack+12','Weapon skill damage +5%','Accuracy+9',}},
				body="Ayanmo Corazza +2",
				hands="Meg. Gloves +2",
				legs={ name="Herculean Trousers", augments={'Accuracy+21','Weapon skill damage +4%','DEX+8',}},
				feet={ name="Herculean Boots", augments={'Accuracy+8','Weapon skill damage +4%','STR+12','Attack+10',}},
				neck="Anu Torque",
				waist={ name="Sailfi Belt +1", augments={'Path: A',}},
				left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
				right_ear="Sherida Earring",
				left_ring="Niqmaddu Ring",
				right_ring="Ilabrat Ring",
				back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
			}
		sets.WS.Upheaval = {    ammo="Knobkierrie",
				head={ name="Herculean Helm", augments={'Attack+12','Weapon skill damage +5%','Accuracy+9',}},
				body="Nyame Mail",
				hands="Meg. Gloves +2",
				legs="Nyame Flanchard",
				feet={ name="Herculean Boots", augments={'Accuracy+8','Weapon skill damage +4%','STR+12','Attack+10',}},
				neck="Fotia Gorget",
				waist={ name="Sailfi Belt +1", augments={'Path: A',}},
				left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
				right_ear="Tuisto Earring",
				left_ring="Niqmaddu Ring",
				right_ring="Ilabrat Ring",
				back={ name="Ogma's Cape", augments={'VIT+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
			}
		
------------------------------------------------------
		-- Defining Sets
------------------------------------------------------	
		sets.base ={
				ammo="Staunch Tathlum",
				head="Nyame Helm",
				body="Erilaz Surcoat +2",
				hands="Nyame Gauntlets",
				legs="Eri. Leg Guards +2",
				feet="Erilaz Greaves +2",
				neck="Null Loop",
				waist="Flume Belt",
				left_ear="Odnowa Earring +1",
				right_ear="Tuisto Earring",
				left_ring="Moonbeam Ring",
				right_ring="Defending Ring",
				back="Moonbeam Cape",
			}
			
		sets.Enmity ={
				ammo="Staunch Tathlum",
				head="Halitus Helm",
				body="Emet Harness",
				hands="Nyame Gauntlets",
				legs="Eri. Leg Guards +2",
				feet="Erilaz Greaves +2",
				neck="Moonbeam Necklace",
				waist="Kasiri Belt",
				left_ear="Tuisto Earring",
				right_ear="Odnowa Earring +1",
				left_ring="Moonbeam Ring",
				right_ring="Defending Ring",
				back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Damage taken-5%',}},
			}

		sets.midcast['Enhancing Magic'] = set_combine(sets.base,{
				head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
				hands="Runeist Mitons +2",
				legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
				neck="Incanter's Torque",
				waist="Olympus Sash",
				left_ear="Mimir Earring",
				left_ring="Stikini Ring",
				_ring="Stikini Ring",
				back="Merciful cape",
			})
			
	    sets.midcast['Divine Magic'] ={}	
		
		sets.midcast.Spikes ={
				ammo="Seething Bomblet",
				head="Nyame Helm",
				body="Nyame Mail",
				hands="Nyame Gauntlets",
				legs="Nyame Flanchard",
				feet="Nyame Sollerets",
				neck="Sanctity Necklace",
				waist="Acuity Belt +1",
				left_ear="Hecate's Earring",
				right_ear="Friomisi Earring",
				left_ring="Defending Ring",
				right_ring="Moonbeam Ring",
			}
-----------------------------------------------------------------------------
--PRECAST SETS 
-----------------------------------------------------------------------------		
		sets.precast.FC = set_combine(sets.base,{
				ammo="Impatiens",
				head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
				body="Erilaz Surcoat +2",
				legs="Aya. Cosciales +2",
				feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
				neck="Voltsurge Torque",
				waist={ name="Sailfi Belt +1", augments={'Path: A',}},
				right_ear="Loquac. Earring",
				right_ring="Kishar Ring",
				back={ name="Ogma's Cape", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
			})
		sets.precast.SIRD =set_combine(sets.base,{
				ammo="Staunch Tathlum",
				head="Erilaz Galea +2",
				body={ name="Taeon Tabard", augments={'Spell interruption rate down -8%','Phalanx +3',}},
				hands={ name="Taeon Gloves", augments={'Spell interruption rate down -10%','Phalanx +3',}},
				legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
				feet={ name="Taeon Boots", augments={'Spell interruption rate down -10%','Phalanx +3',}},
				neck="Moonbeam Necklace",
				left_ring="Evanescence Ring",
				back={ name="Ogma's Cape", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
			})
		
		sets.precast.Enhance = set_combine(sets.precast.FC, 
				{waist="Siegel Sash", 
				legs="Futhark Trousers +1",
			})
			
		
-----------------------------------------------------------------------------
-- Job Swaps
-----------------------------------------------------------------------------
		sets.precast.JA = {}
		sets.precast.JA.Lunge ={
			ammo="Seething Bomblet",head="Nyame Helm", body="Nyame Mail",hands="Nyame Gauntlets",legs="Nyame Flanchard",
			feet="Nyame Sollerets",neck="Sanctity Necklace",left_ear="Friomisi Earring",right_ear="Hecate's Earring",}
		sets.precast.JA.Swipe = set_combine(sets.Lunge,{})
		sets.precast.JA.Vallation = set_combine(sets.Enmity,{body="Runeist Coat +2"}) --Enmity Set
		sets.precast.JA.Swordplay = set_combine(sets.Enmity,{hands="Futhark Mitons +1"})--Enmity Set
		sets.precast.JA.Pflug = set_combine(sets.Enmity,{feet="Runeist Bottes +1"}) --Enmity Set
		sets.precast.JA.Valiance = set_combine(sets.Enmity,{body="Runeist Coat +2"})--Enmity Set
		sets.precast.JA.Embolden = set_combine(sets.Enmity,{legs="Futhark Trousers +1"})--Enmity Set
		sets.precast.JA.Gambit = set_combine(sets.Enmity,{hands="Runeist Mitons +2"})--Enmity Set
		sets.precast.JA.Liement = set_combine(sets.Enmity,{body="Futhark Coat +1"})--Enmity Set
		sets.precast.JA["One For All"] = set_combine(sets.Enmity)--Enmity Set
		sets.precast.JA.Battuta = set_combine(sets.Enmity,{head="Fu. Bandeau +1"})--Enmity Set
		sets.precast.JA.Rayke = set_combine(sets.Enmity,{feet="Futhark Boots +1"})--Enmity Set		
		sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity,{body="Futhark Coat +1"})--Enmity Set
		sets.precast.JA['Vivacious Pulse'] = set_combine(sets.Enmity,
			{head="Erilaz Galea +2",legs="Rune. Trousers +1",neck="Incanter's Torque",left_ring="Stikini Ring" })--Enmity Set			
		sets.precast.JA.Provoke = set_combine(sets.Enmity)--Enmity Set
		sets.precast.JA.Warcry = set_combine(sets.Enmity)--Enmity Set
		
-----------------------------------------------------------------------------
--MIDCAST SETS
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
			-- Enhancing Magic
-----------------------------------------------------------------------------
		sets.midcast.Refresh ={
				head="Erilaz Galea +2",
				legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
			}
		sets.midcast.RefreshSelf ={
				head="Erilaz Galea +2",
				legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
				waist="Gishdubar Sash",
			}		
		sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],{
				head={ name="Fu. Bandeau +1", augments={'Enhances "Battuta" effect',}},
				body={ name="Taeon Tabard", augments={'Spell interruption rate down -8%','Phalanx +3',}},
				hands={ name="Taeon Gloves", augments={'Spell interruption rate down -10%','Phalanx +3',}},
				legs={ name="Taeon Tights", augments={'Spell interruption rate down -7%','Phalanx +3',}},
				feet={ name="Taeon Boots", augments={'Spell interruption rate down -10%','Phalanx +3',}},
			})
			
		sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'])
		
		sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'])	
		
		sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{
				head="Rune. Bandeau +1",
				body={ name="Taeon Tabard", augments={'"Regen" potency+3',}},
				legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
				feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+3','"Regen" potency+3',}},
				waist="Sroda Belt",
				right_ear="Erilaz Earring",
			})	
		sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'])	
		
		sets.midcast['Blaze Spikes'] = set_combine(sets.midcast.Spikes)
		sets.midcast['Shock Spikes'] = set_combine(sets.midcast.Spikes)
		sets.midcast['Ice Spikes'] = set_combine(sets.midcast.Spikes)
		
-----------------------------------------------------------------------------
			-- Blue Magic
-----------------------------------------------------------------------------
	    sets.midcast['Blue Magic'] = set_combine(sets.enmity, {
				ammo="Staunch Tathlum",
				head="Erilaz Galea +2",
				body="Emet Harness",
				hands="Nyame Gauntlets",
				legs="Eri. Leg Guards +2",
				feet="Erilaz Greaves +2",
				neck="Moonbeam Necklace",
				waist="Kasiri Belt",
				left_ear="Crep. Earring",
				right_ear="Tuisto Earring",
				left_ring="Moonbeam Ring",
				right_ring="Defending Ring",
				back="Null Shawl",
		})
	sets.midcast['Healing Breeze'] = set_combine(sets.base,{
				waist="Sroda Belt",
				left_ear="Mendicant's earring",
		})	
 	

		
-----------------------------------------------------------------------------
			-- Enmity Spells
-----------------------------------------------------------------------------		
		sets.midcast.Flash = set_combine(sets.Enmity)
		sets.midcast.Poisonga = set_combine(sets.Enmity)
		sets.midcast.Foil = set_combine(sets.Enmity)
	
-----------------------------------------------------------------------------
--EXTRA SETS
-----------------------------------------------------------------------------


end

-----------------------------------------------------------------------------
--Functions 		
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
			-- Precast Functions
-----------------------------------------------------------------------------	

function job_precast(spell, action, spellMap, eventArgs)
    last_spell_cast = spell

    if spell.action_type == 'Magic' then
        -- Check if CastingMode is SIRD first
        if state.CastingMode.current == 'SIRD' then
            equip(sets.precast.SIRD)
            eventArgs.handled = true
        elseif spell.skill == 'Enhancing Magic' then
            equip(sets.precast.Enhance)
            eventArgs.handled = true
        else
            equip(sets.precast.FC)
            eventArgs.handled = true
        end

    elseif spell.type == "JobAbility" or spell.type == "Ward" or spell.type == "Effusion" then
        if sets.precast.JA and sets.precast.JA[spell.english] then
            equip(sets.precast.JA[spell.english])
            eventArgs.handled = true
        end
		
	elseif spell.type == "Rune" then
		equip(sets.Enmity)
		
    elseif spell.type == "WeaponSkill" then
        if sets.WS and sets.WS[spell.english] then
            equip(sets.WS[spell.english])
            eventArgs.handled = true
        elseif sets.WS then
            equip(sets.WS) -- fallback to default WS set if needed
            eventArgs.handled = true
        end
    end
end
-----------------------------------------------------------------------------
			-- Midcast Functions
-----------------------------------------------------------------------------
function midcast(spell, action, spellMap, eventArgs)
    local equipSet = {}

    if spell.action_type == 'Magic' then
        -- Start from midcast base set
        equipSet = sets.midcast or {}

        -- Check for spell-specific midcast sets
        if equipSet[spell.english] then
            equipSet = equipSet[spell.english]
        elseif equipSet[spell.skill] then
            equipSet = equipSet[spell.skill]
        end

        equip(equipSet)
    end
	
end
function job_post_midcast(spell, action, spellMap, eventArgs)
        if spellMap == 'Refresh' then
            if spell.target.type == 'SELF' then
                equip(sets.midcast.RefreshSelf)
            else
                equip(sets.midcast.Refresh)
            end
        end
	end


function job_state_change(stateField, newValue, oldValue)
    update_hud()
end
-----------------------------------------------------------------------------
--MACRO BOOK		
-----------------------------------------------------------------------------
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 3)
	elseif player.sub_job == 'DNC' then
		set_macro_page(3, 3)
	elseif player.sub_job == 'NIN' then
		set_macro_page(2, 3)
	else
		set_macro_page(1, 3)
	end
end
