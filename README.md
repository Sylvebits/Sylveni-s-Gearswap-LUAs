HELLO! Sylveni of Asura here!

The posted LUAs are considered MOSTLY functioning, and are designed around my use with XIVCrossbar - though they can be used without it. 
  Currently RUN, RDM, and DRK are considered complete, with COR being remade at the moment and to be posted.

There's minimal to no auto-reacting to actions or the environment; the means if you are silenced you must use echo drops manually, go into your doom set yourself, and won't 
  change basedd on your haste amount

There are toggles, though sensible, and designed around controller play but can be used for keyboard.
     
    DRK: Has toggles for weaponset and offensemode, with offense mode being broken down into another serperate toggle
          Weaponset: gs c cycle Weaponset cycles through your weapons defined in sets. at the the top. You can also do: gs c set WeaponSet "name of set here"
          Offensemode: gs c cycle Offensemode cycles through your engage sets, and has a similar function to picking weaponsets gs c set OffenseMode "name of set here"
            - I also made the option to select between DT(damage taken) and DTH(Damage taken hybrid), through gs c toggledt. This is basically gs c cycle Offensemode, 
              but only cycles between DT and DTH. gs c cycle Offensemode still cycles all offensemodes, but gs c toggledt specifically does it only for DT and DTH
     
    RDM: Has toggles for castingmode, idle, weaponset, and offense mode
          Offensemode: Offensemodes are single(single wielding) and Dual(for dual wielding). If youre subjob is NIN is or DNC, you'll automatically be toggled into Dual, but
              can switch to Single. The main difference with Single and Dual mode, is that when you are in dual mode in combat your main/sub/range/ammo slots are
              locked as to not lose TP midfight. You can override this by switching your casting mode to "resist" which basically says "TP be damned i need all the MACC
              I can get to land this debuff." Single mode will swap weapons in combat regardless of casting mode. NOTE: Casting cures in combat don't swap weapons either
              unless you're in resist mode.
          Weaponset:  Switches through the defined weaponsets.  Can be done freely midcombat as toggling this is an exception to dual mode and an understood reason to lose
              TP. Also when in dual mode, you can swap through the defined DW sets only. And vice versa, if you are in single mode, you only swap between the defined weaponsets.
          Castingmode: Casting modes are simple normal and resist. Normal sets are used with normal, resist mode uses  resist sets as well as unlocks weaponslots in dual mode noted above.    
          Idlemode: Quite simple; a Single wield and DT set, and a DW and DWST set.
              
     How this plays out in pracice: 
            1) You go to the moogle, and change to RDM/NIN. You're Offensemode is set to Dual and DWSword by default. 
            2) Prior to starting an encounter, you buff up, changing all gear slots where defined.
            3) You debuff your target out of combat, all gear slots are changed where defined.
            4) You enter combat. If youre not in your current offense modes weapons, it swaps. You fight as normal.
            5A) A debuff falls off, you cast to reapply - your main/sub/range/ammo don't change, keeping your TP.
            5B) A debuff falls off, you cast to reapply, you get a resist. You switch to casting mode resist. You cast again to reapply,
            all slots are changed, and you land the spell. You switch back to normal casting mode to lock your weapons again
            6) Sudden the enemy is immune to slashing. You toggle to weaponset DWclub and swap to those weapons. You're losing and need to run.
            7) You disengage, cast Sleep II - all your slots including weapons change. 
            8) You run. 

      RUN: Arguably the simplest of the toggling. 
            Offensemode: Swaps between a TP set, a ParryTank set, A full tank set, HybridDD/Tank set, and a TPACC set. Self-explainitory. 
            Idlemode: Swaps between a normal idle set, an IdleTank set, and an MEVA focused IDLEMEVA set. 
            Castingmode: Swaps between fast cast for normal, and SIRD mode.
