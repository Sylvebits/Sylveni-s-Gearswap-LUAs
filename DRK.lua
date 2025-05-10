-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
     -- Load and initialize the include file.
    include('Mote-Include.lua')
		send_command('send Sylveni /lockstyleset 4')
end
 texts = require('texts')
	dt_toggle_active = false
hud_text = texts.new({
    pos = {x = 10, y = 10},
    text = {
        font='Arial',
        size=9,
        color={255,255,255},
        stroke={width=2, alpha=255, red=50, green=50, blue=200}  -- Light blue shadow stroke
    },
    bg = {alpha=25, red=30, green=30, blue=30},
    flags = {draggable=true},
    padding = 5
})
 
-- Setup vars that are user-independent.
function job_setup()
    state.Buff.Aftermath = buffactive.Aftermath or false
    state.Buff.Souleater = buffactive.Souleater or false
    state.Buff['Dark Seal'] = buffactive['Dark Seal'] or false
    state.Buff['Last Resort'] = buffactive['Last Resort'] or false
    state.Buff['Doom'] = buffactive['Doom'] or false
    state.Buff['Curse'] = buffactive['Curse'] or false
 
    LowTierNuke = S{
        'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}
        
    Absorbs = S{'Absorb-STR', 'Absorb-DEX', 'Absorb-VIT', 'Absorb-AGI', 'Absorb-INT', 'Absorb-MND', 'Absorb-CHR', 'Absorb-Attri', 'Absorb-ACC', 'Absorb-TP'}
   
   
end
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'GSACC', 'ScytheACC', 'AM3', 'DT', 'DTH')
	state.WeaponSet = M{['description'] = 'Weapon Set', 'Caladbolg', 'Apoc', 'Lycurgos', 'Crep-Scythe'}
    state.CastingMode:options('Normal', 'Resist')
    state.IdleMode:options('Normal','DT')
	enable('main','sub','range')
update_hud()
end
 
 
 
-----------------------------------------------------------------------------
							-- Gear Sets --
-----------------------------------------------------------------------------
function init_gear_sets()
-----------------------------------------------------------------------------
-- Idle Sets
-----------------------------------------------------------------------------
	sets.idle ={
			ammo="Staunch Tathlum",
			head="Sakpata's Helm",
			body="Sakpata's Plate",
			hands="Sakpata's Gauntlets",
			legs="Sakpata's Cuisses",
			feet="Sakpata's Leggings",
			neck="Null Loop",
			waist="Carrier's Sash",
			left_ear="Odnowa Earring +1",
			right_ear="Tuisto Earring",
			left_ring="Moonbeam Ring",
			right_ring="Shneddick Ring",
			back="Moonbeam Cape",
		}
    sets.idle.DT = {}
 
    sets.idle.Town ={right_ring="Shneddick Ring",}
	sets.idle.Adoulin = set_combine(sets.idle, {body = "Councilor's Garb",  })
	

-----------------------------------------------------------------------------
-- Engaged Sets
-----------------------------------------------------------------------------
  --	state.WeaponSet = M{['description'] = 'Caladbolg', 'Apoc', 'Lycurgos', 'Crep-Scythe'}
  --    state.OffenseMode:options('Normal', 'GSACC', 'ScytheACC', 'AM3', 'DT', 'DTH')	


------------------------------------
-- Weaponsets
------------------------------------

	sets.Apoc = {main="Apocalypse"}
	sets.Lycurgos = {main="Lycurgos"}
	sets['Crep-Scythe'] = {main="Crepuscular Scythe"}
	sets.Caladbolg = {main="Caladbolg"}

------------------------------------
-- TP Sets
------------------------------------	
	--General TP
  sets.engaged ={
			sub="Utu grip",	
			ammo="Ginsen",
			head="Flam. Zucchetto +2",
			body="Sakpata's Plate",
			hands="Sakpata's Gauntlets",
			legs="Sakpata's Cuisses",
			feet="Flam. Gambieras +2",
			neck={ name="Abyssal Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Cessance Earring",
			right_ear="Crep. Earring",
			left_ring="Chirich Ring +1",
			right_ring="Niqmaddu Ring",
			back="Null Shawl",
		}
		
	--Damage Taken Hybrid	
    sets.engaged.DTH ={
			sub="Utu grip",	
			ammo="Ginsen",
			head="Flam. Zucchetto +2",
			body="Sakpata's Plate",
			hands="Sakpata's Gauntlets",
			legs="Sakpata's Cuisses",
			feet="Flam. Gambieras +2",
			neck="Null Loop",
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Cessance Earring",
			right_ear="Odnowa Earring +1",
			left_ring="Defending Ring",
			right_ring="Moonbeam Ring",
			back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
		}
		
	--Full Damage Taken/MEVA
    sets.engaged.DT ={
			sub="Utu grip",			
			ammo="Staunch Tathlum",
			head="Sakpata's Helm",
			body="Sakpata's Plate",
			hands="Sakpata's Gauntlets",
			legs="Sakpata's Cuisses",
			feet="Sakpata's Leggings",
			neck="Null Loop",
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Eabani Earring",
			right_ear="Tuisto Earring",
			left_ring="Moonbeam Ring",
			right_ring="Chirich Ring +1",
			back="Null Shawl",
		}
		
	--Greatsword ACC	
    sets.engaged.GSACC ={

			sub="Utu grip",
			ammo="Ginsen",
			head="Flam. Zucchetto +2",
			body="Sakpata's Plate",
			hands="Heath. Gauntlets +2",
			legs="Sakpata's Cuisses",
			feet="Flam. Gambieras +2",
			neck="Null Loop",
			waist="Ioskeha Belt",
			left_ear="Cessance Earring",
			right_ear="Crep. Earring",
			left_ring="Chirich Ring +1",
			right_ring="Moonbeam Ring",
			back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
		}
		
	--Scythe ACC			
	sets.engaged.ScytheACC ={
			sub="Utu grip",
			ammo="Ginsen",
			head="Heath. Burgeon. +2",
			body="Sakpata's Plate",
			hands="Sakpata's Gauntlets",
			legs="Sakpata's Cuisses",
			feet="Flam. Gambieras +2",
			neck="Null Loop",
			waist="Ioskeha Belt",
			left_ear="Cessance Earring",
			right_ear="Crep. Earring",
			left_ring="Chirich Ring +1",
			right_ring="Moonbeam Ring",
			back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
		}
		
	--AM3	
	sets.engaged.AM3 = {}
	
-----------------------------------------------------------------------------
--PRECAST SETS
-----------------------------------------------------------------------------
			--Damage Taken Set--
	sets.base ={
			head="Sakpata's Helm",
			body="Sakpata's Plate",
			hands="Sakpata's Gauntlets",
			legs="Sakpata's Cuisses",
			feet="Sakpata's Leggings",
			neck="Null Loop",
			waist="Carrier's Sash",
			left_ear="Odnowa Earring +1",
			right_ear="Eabani Earring",
			left_ring="Moonbeam Ring",
			right_ring="Defending Ring",
			back="Null Shawl",
		}

------------------------------------
-- Job Precast
------------------------------------

    sets.precast.JA['Diabolic Eye'] = {hands="Fallen's finger gauntlets +3"}
    sets.precast.JA['Arcane Circle'] = {feet="Ignominy Sollerets +1"}
    sets.precast.JA['Nether Void'] = {legs="Heath. Flanchard +2"}
    sets.precast.JA['Souleater'] = {head="Ignominy Burgonet +2"}
    sets.precast.JA['Weapon Bash'] = {hands="Ignominy Gauntlets +1"}
    sets.precast.JA['Last Resort'] = {back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},}
    sets.precast.JA['Dark Seal'] = {head="Fallen's Burgeonet +3"}
    sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass +1"}
 

------------------------------------
-- Spell Precast
------------------------------------

    sets.precast.FC = set_combine(sets.base,{
			head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
			legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
			feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
			neck="Voltsurge Torque",
			left_ear="Malignance Earring",
			right_ear="Loquac. Earring",
			left_ring="Kishar Ring",
			back={ name="Ankou's Mantle", augments={'Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
		})
		
		
-----------------------------------------------------------------------------
--Midcast Sets
-----------------------------------------------------------------------------		 

     sets.midcast.Utsusemi = set_combine(sets.precast.FC,{})

 
------------------------------------------------------
		-- Defining Sets
------------------------------------------------------
	
	sets.midcast.FastRecast = {}
	
	sets.midcast['Dark Magic'] = set_combine(sets.base,{
			head="Ig. Burgeonet +2",
			body="Carm. Scale Mail",
			hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
			legs="Heath. Flanchard +2",
			neck="Erra Pendant",
			left_ring="Evanescence Ring",
			right_ring="Stikini Ring",
			back="Merciful Cape",
		})
		
    sets.midcast['Dark Magic'].Resistant = set_combine(sets.midcast['Dark Magic'], {})
	
	sets.midcast['Enfeebling Magic'] = set_combine(sets.base,{
			head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
			body="Ignominy Cuirass +3",
			neck="Incanter's Torque",
			left_ring="Kishar Ring",
			right_ring="Stikini Ring",
		})    

  
    sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})
 
 -----------------------------------------------------------------------------
		-- Dark Magic
-----------------------------------------------------------------------------
 
 
-- Based on HP when casted.
    sets.midcast['Dread Spikes'] ={
			ammo="Staunch Tathlum",
			head="Ratri Sallet",
			body="Heath. Cuirass +2",
			hands="Ratri Gadlings",
			legs="Ratri Cuisses",
			feet="Ratri Sollerets",
			neck="Null Loop",
			waist="Carrier's Sash",
			left_ear="Odnowa Earring +1",
			right_ear="Tuisto Earring",
			left_ring="Moonbeam Ring",
			right_ring="Defending Ring",
			back="Moonbeam Cape",
		}
     sets.midcast['Endark II'] = set_combine(sets.midcast['Dark Magic'],{			feet="Ratri Sollerets",}) 
-- Absorbs
	sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'],{
			feet="Ratri Sollerets",
			left_ear="Malignance Earring",
			right_ear="Crep. Earring",
			left_ring="Kishar Ring",
			back="Chuparrosa Mantle",
		})
 
    sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {hands="Heathen's Gauntlets +2"})
    sets.midcast['Absorb-TP'].Resistant = set_combine(sets.midcast.Absorb.Resistant, {hands="Heathen's Gauntlets +2"})
 
    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'],{
			feet="Heath. Sollerets +2",
			neck="Null Loop",
			left_ear="Malignance Earring",
			right_ear="Crep. Earring",
			left_ring="Stikini Ring",
			right_ring="Stikini Ring",
			back="Null Shawl",
		})
 
    sets.midcast.Stun.Resistant =set_combine(sets.midcast.Stun, {})
        
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'],{
			head={ name="Fall. Burgeonet +3", augments={'Enhances "Dark Seal" effect',}},
			hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
			legs="Heath. Flanchard +2",
			feet="Ratri Sollerets",
			neck="Erra Pendant",
			left_ear="Hirudinea Earring",
			right_ear="Malignance Earring",
			left_ring="Evanescence Ring",
			right_ring="Stikini Ring",
			back="Chuparrosa Mantle",
		})
    
    sets.midcast.Drain.Resistant = set_combine(sets.midcast['Dark Magic'].Resistant, {})
    sets.midcast['Drain III'] = set_combine(sets.midcast.Drain, {feet="Ratri Sollerets"})        
    sets.midcast.Aspir = set_combine(sets.midcast.Drain, {})
    sets.midcast.Aspir.Resistant = set_combine(sets.midcast.Drain, {})
	
-----------------------------------------------------------------------------
		-- Elemental Magic
-----------------------------------------------------------------------------

-- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast.LowTierNuke = {      
			ammo="Seething Bomblet",
			head="Nyame Helm",
			body="Nyame Mail",
			hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
			legs="Nyame Flanchard",
			feet="Heath. Sollerets +2",
			neck="Sanctity Necklace",
			waist="Olympus Sash",
			left_ear="Malignance Earring",
			right_ear="Friomisi Earring",
			left_ring="Stikini Ring",
			right_ring="Crepuscular Ring",
			back={ name="Ankou's Mantle", augments={'Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
		}
		
    sets.midcast.LowTierNuke.Resistant = {      
			ammo="Seething Bomblet",
			head="Nyame Helm",
			body="Nyame Mail",
			hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
			legs="Nyame Flanchard",
			feet="Heath. Sollerets +2",
			neck="Sanctity Necklace",
			waist="Olympus Sash",
			left_ear="Malignance Earring",
			right_ear="Friomisi Earring",
			left_ring="Stikini Ring",
			right_ring="Crepuscular Ring",
			back={ name="Ankou's Mantle", augments={'Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
		}

    sets.midcast.HighTierNuke = {       
			ammo="Seething Bomblet",
			head="Nyame Helm",
			body="Nyame Mail",
			hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
			legs="Nyame Flanchard",
			feet="Heath. Sollerets +2",
			neck="Sanctity Necklace",
			waist="Olympus Sash",
			left_ear="Malignance Earring",
			right_ear="Friomisi Earring",
			left_ring="Stikini Ring",
			right_ring="Crepuscular Ring",
			back={ name="Ankou's Mantle", augments={'Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
		}
		
    sets.midcast.HighTierNuke.Resistant = {       
			ammo="Seething Bomblet",
			head="Nyame Helm",
			body="Nyame Mail",
			hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
			legs="Nyame Flanchard",
			feet="Heath. Sollerets +2",
			neck="Sanctity Necklace",
			waist="Olympus Sash",
			left_ear="Malignance Earring",
			right_ear="Friomisi Earring",
			left_ring="Stikini Ring",
			right_ring="Crepuscular Ring",
			back={ name="Ankou's Mantle", augments={'Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
		}
 -----------------------------------------------------------------------------
		-- Extra Midcast
-----------------------------------------------------------------------------
	sets.midcast.Utsusemi = set_combine(sets.precast.FC,{})


-----------------------------------------------------------------------------
-- Idle Sets
-----------------------------------------------------------------------------

-- Custom buff sets
			sets.Souleater = {head="Ignominy Burgeonet +2"}
			sets['Last Resort'] = {}
			sets.Doom = {}
			sets['Dark Seal'] = {head="Fallen's Burgeonet +3"}
			sets.Aftermath = {}
		 

 
-----------------------------------------------------------------------------
-- Weaponskill sets
-----------------------------------------------------------------------------	
	sets.precast.WS = {
			ammo="Knobkierrie",
			head="Flam. Zucchetto +2",
			body="Ignominy Cuirass +3",
			hands="Sakpata's Gauntlets",
			legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
			feet="Heath. Sollerets +2",
			neck="Fotia Gorget",
			waist="Fotia Belt",
			left_ear="Thrud Earring",
			right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			left_ring="Rajas Ring",
			right_ring="Petrov Ring",
			back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		}

		------------------------------------
		-- Scythe Weaponskills
		------------------------------------
-- Entropy - FTP 0.75, 1.25, 2.0, - INT 85% -- Gravitation/Reverberation
    sets.precast.WS['Entropy'] = {    
			ammo="Seething Bomblet",
			head="Heath. Burgeon. +2",
			body="Ignominy Cuirass +3",
			hands="Ratri Gadlings",
			legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
			feet="Heath. Sollerets +2",
			neck={ name="Abyssal Beads +1", augments={'Path: A',}},
			waist="Fotia Belt",
			left_ear="Friomisi Earring",
			right_ear="Malignance Earring",
			left_ring="Chirich Ring +1",
			right_ring="Petrov Ring",
			back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		}

        
-- Insurgency
    sets.precast.WS['Insurgency'] = {    
			ammo="Knobkierrie",
			head="Heath. Burgeon. +2",
			body="Ignominy Cuirass +3",
			hands="Sakpata's Gauntlets",
			legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
			feet="Heath. Sollerets +2",
			neck={ name="Abyssal Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Thrud Earring",
			right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			left_ring="Chirich Ring +1",
			right_ring="Petrov Ring",
			back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		}
        
-- Cross Reaper - FTP 2.75 - STR 40%, INT 40% - WSdmg% -- Darkness/Gravitation
    sets.precast.WS['Cross Reaper'] = {    
			ammo="Knobkierrie",
			head="Heath. Burgeon. +2",
			body="Ignominy Cuirass +3",
			hands="Ratri Gadlings",
			legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
			feet="Heath. Sollerets +2",
			neck={ name="Abyssal Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Thrud Earring",
			right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			left_ring="Chirich Ring +1",
			right_ring="Niqmaddu Ring",
			back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		}

-- Catastrophe - FTP 2.75 - STR 40%, INT 40% - WSdmg% -- Darkness/Gravitation
    sets.precast.WS['Catastrophe'] = {    
			ammo="Knobkierrie",
			head="Heath. Burgeon. +2",
			body="Ignominy Cuirass +3",
			hands="Ratri Gadlings",
			legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
			feet="Heath. Sollerets +2",
			neck={ name="Abyssal Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Thrud Earring",
			right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
			left_ring="Chirich Ring +1",
			right_ring="Niqmaddu Ring",
			back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		}
-- Quietus - FTP 3.0, - STR 60% MND 60% - Triple Dmg, Ignores Defense -- Darkness/Distortion
    sets.precast.WS['Quietus'] = {    
			ammo="Knobkierrie",
			head="Heath. Burgeon. +2",
			body="Ignominy Cuirass +3",
			hands="Ratri Gadlings",
			legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
			feet="Heath. Sollerets +2",
			neck={ name="Abyssal Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Thrud Earring",
			right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			left_ring="Chirich Ring +1",
			right_ring="Petrov Ring",
			back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		}
		------------------------------------
		-- Greatsword Weaponskills
		------------------------------------
 
-- Resolution - FTP .71, 1.5, 2.25, - STR 85% Multi Hit -- Fragmentation/Scission
 sets.precast.WS['Resolution'] = {
			ammo="Knobkierrie",
			head="Flam. Zucchetto +2",
			body="Hjarrandi Breast.",
			hands="Sakpata's Gauntlets",
			legs="Sakpata's Cuisses",
			feet="Flam. Gambieras +2",
			neck="Fotia Gorget",
			waist="Fotia Belt",
			left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			right_ear="Cessance Earring",
			left_ring="Niqmaddu Ring",
			right_ring="Petrov Ring",
			back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
		}
-- Torcleaver - FTP 4.75, 7.5, 10, - VIT 80% -- Light/Distortion
 sets.precast.WS['Torcleaver'] ={
			ammo="Knobkierrie",
			head="Sakpata's Helm",
			body="Ignominy Cuirass +3",
			hands={ name="Odyssean Gauntlets", augments={'Attack+14','Weapon skill damage +4%','STR+11','Accuracy+14',}},
			legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
			feet="Heath. Sollerets +2",
			neck={ name="Abyssal Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			right_ear="Thrud Earring",
			left_ring="Chirich Ring +1",
			right_ring="Niqmaddu Ring",
			back={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
		}

		------------------------------------
		-- Greataxe Weaponskills
		------------------------------------
		
		--Upheaval
 sets.precast.WS['Upheaval'] ={    
			ammo="Knobkierrie",
			head="Sakpata's Helm",
			body="Ignominy Cuirass +3",
			hands="Sakpata's Gauntlets",
			legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
			feet="Heath. Sollerets +2",
			neck={ name="Abyssal Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			right_ear="Thrud Earring",
			left_ring="Chirich Ring +1",
			right_ring="Niqmaddu Ring",
			back={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
		}
				
		--Fell Cleave
 sets.precast.WS['Fell Cleave'] ={
			ammo="Knobkierrie",
			head={ name="Fall. Burgeonet +3", augments={'Enhances "Dark Seal" effect',}},
			body="Ignominy Cuirass +3",
			hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
			legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
			feet="Heath. Sollerets +2",
			neck={ name="Abyssal Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			right_ear="Thrud Earring",
			left_ring="Chirich Ring +1",
			right_ring="Petrov Ring",
			back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		}
		
		--Armorbreak
sets.precast.WS['Armor break'] ={
			ammo="Knobkierrie",
			head={ name="Fall. Burgeonet +3", augments={'Enhances "Dark Seal" effect',}},
			body="Ignominy Cuirass +3",
			hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
			legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
			feet="Heath. Sollerets +2",
			neck={ name="Abyssal Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			right_ear="Thrud Earring",
			left_ring="Chirich Ring +1",
			right_ring="Petrov Ring",
			back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		}
 --Steel Cyclone
 
		------------------------------------
		-- Sword Weaponskills
		------------------------------------
 
-- Savage - FTP 4.0, 10.25, 13.75 - MND 50% STR 50% - Fragmentation/Scission
    sets.precast.WS['Savage Blade'] = {    
			ammo="Knobkierrie",
			head="Flam. Zucchetto +2",
			body="Ignominy Cuirass +2",
			hands="Sulev. Gauntlets +2",
			legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
			feet="Sulev. Leggings +2",
			neck={ name="Abyssal Beads +1", augments={'Path: A',}},
			waist="Caudata Belt",
			left_ear="Thrud Earring",
			right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			left_ring="Niqmaddu Ring",
			right_ring="Petrov Ring",
			back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+18 Attack+18','Weapon skill damage +10%',}},
		}
    

 
-- Judgment
    sets.precast.WS['Judgment'] = {}
	

end
 -----------------------------------------------------------------------------
							-- Functions --
-----------------------------------------------------------------------------
 
 
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Remedy" <me>')
    end
end
 

function job_precast(spell, action, spellMap, eventArgs)
 
end
 
 
 
function job_post_precast(spell, action, spellMap, eventArgs)
    -- Make sure abilities using head gear don't swap 
    if spell.type:lower() == 'weaponskill' then
        if player.tp > 2999 then
            equip(sets.BrutalLugra)
        else -- use Lugra + moonshade
        if world.time >= (17*60) or world.time <= (7*60) then
            equip(sets.Lugra)
        else
            -- do nothing.
        end
        end
    end
end
 
 
-- Job-specific hooks for standard casting events.
function job_midcast(spell, action, spellMap, eventArgs)
 
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if buffactive['Dark Seal'] and S{"Drain III"}:contains(spell.english)then
        equip({head="Fallen's Burgeonet +3"})
    end
end
 

function job_aftercast(spell, action, spellMap, eventArgs)
 
end
 
function job_post_aftercast(spell, action, spellMap, eventArgs)
 
end
 
 
 -- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Dark Magic' and Absorbs:contains(spell.english) then
        return 'Absorb'
    end
 
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        if LowTierNuke:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
    end
end
---------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
---------------------------------------------------------------------
 
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
 
end
 
-- Modify the default idle set after it was constructed.
--function customize_idle_set(idleSet)
  --  if state.Buff['Doom'] or state.Buff['Curse'] then
    --    idleSet = set_combine(idleSet, sets.Doom)
    --end
    --return idleSet
--end
function customize_idle_set(idleSet)
    local info = windower.ffxi.get_info()
    local adoulin_zones = S{256, 257} -- East and West Adoulin zone IDs

    local weaponSet = sets[state.WeaponSet.current]
    if weaponSet and (weaponSet.main or weaponSet.sub) then
        idleSet = set_combine(idleSet, {
            main = weaponSet.main,
            sub = weaponSet.sub
        })
    end

    if adoulin_zones:contains(info.zone) and sets.idle.Adoulin then
        equip(sets.idle.Adoulin)
    end

    return idleSet
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'OffenseMode' then
        add_to_chat(122, 'Offense Mode: '..newValue)
    elseif stateField == 'WeaponSet' then
        add_to_chat(122, 'Weapon Set: '..newValue)
    end
    handle_equipping_gear(player.status)
    update_hud()
end


 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    -- Start with base engaged set based on OffenseMode
    if state.OffenseMode.current == 'GSACC' and sets.engaged.GSACC then
        meleeSet = sets.engaged.GSACC
    elseif state.OffenseMode.current == 'ScytheACC' and sets.engaged.ScytheACC then
        meleeSet = sets.engaged.ScytheACC
    elseif state.OffenseMode.current == 'DT' and sets.engaged.DT then
        meleeSet = sets.engaged.DT
    elseif state.OffenseMode.current == 'DTH' and sets.engaged.DTH then
        meleeSet = sets.engaged.DTH
    elseif state.OffenseMode.current == 'AM3' and sets.engaged.AM3 then
        meleeSet = sets.engaged.AM3
    else
        meleeSet = sets.engaged
    end

    -- Always apply selected WeaponSet on top
    local weaponSet = sets[state.WeaponSet.current]
    if weaponSet and (weaponSet.main or weaponSet.sub) then
        meleeSet = set_combine(meleeSet, {
            main = weaponSet.main,
            sub = weaponSet.sub
        })
    end

    -- Apply buffs
    if state.Buff.Souleater and sets.Souleater then
        meleeSet = set_combine(meleeSet, sets.Souleater)
    end
    if state.Buff.Doom or state.Buff.Curse then
        meleeSet = set_combine(meleeSet, sets.Doom)
    end

    return meleeSet
end


 
 
---------------------------------------------------------------------
-- General hooks for other events.
---------------------------------------------------------------------
 
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    handle_equipping_gear(newStatus)
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
    if buff == "Souleater" then
        handle_equipping_gear(player.status)
    end
    if buff == "Doom" or buff == "Curse" then
        if gain then
            equip(sets.doom)
        else
            handle_equipping_gear(player.status)
        end
    end
end
 
----------------------------------------------------------------------
-- User code that supplements self-commands.
-----------------------------------------------------------------------
 

 
 
------------------------------------
-- HUD Functions 
------------------------------------

function job_self_command(cmdParams, eventArgs)
if cmdParams[1]:lower() == 'toggledt' then
    toggledt()
end
end
function toggledt()
    if state.OffenseMode.value == 'DT' then
        state.OffenseMode:set('DTH')
    else
        state.OffenseMode:set('DT')
    end
    dt_toggle_active = true
    handle_equipping_gear(player.status)
    update_hud()
end
function update_hud()
    if hud_text then
        local offense = state.OffenseMode and state.OffenseMode.value or 'N/A'
        local weapon = state.WeaponSet and state.WeaponSet.value or 'N/A'
        local idle = state.IdleMode and state.IdleMode.value or 'N/A'

        local dt_tag = (dt_toggle_active and (offense == 'DT' or offense == 'DTH')) and '*' or ''

        hud_text:text(

            'OffenseMode: ' .. offense .. dt_tag .. '\n' ..
            'WeaponSet: ' .. weapon
        )
        hud_text:show()
    end
end


 

 
function update_melee_groups()
 
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(1, 12)
    else
        set_macro_page(1, 12)
    end
end
