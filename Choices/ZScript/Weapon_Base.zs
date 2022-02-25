class Weapon_Base : Weapon {
	default {
		Weapon.AmmoUse1 1;
		Weapon.AmmoUse2 0;
		Weapon.AmmoGive1 0;
		Weapon.AmmoGive2 0;
		+INVENTORY.UNTOSSABLE
		+WEAPON.NOAUTOAIM
		+WEAPON.AMMO_OPTIONAL
		+WEAPON.CHEATNOTWEAPON
		+WEAPON.NOALERT
	}
 
	mixin Mix_Jump;
  mixin Mix_Weapon;
	
	/*
	0 - (CHG - Current Speed)
	1 - (CHG - Tics in Frame, PIS - Firing Flags)
	2 - Accuracy
	3 - (CHG - Speed Offset before Firing)
	4 - (CHG - Slow Speed)
	*/
	
	states {
	
	//******************************************************
	//	ChangeWeapon
	//******************************************************
	
	ChangeWeapon:
		"----" A 0 W_ChangeWeapon();
		"----" A 0 Jump(state("Ready.NoFire"));
	
	//******************************************************
	//	CheckAmmo
	//******************************************************
	
	Ready.CheckAmmo:
	"----" A 0 A_JumpIfNoAmmo("ChangeWeapon");
		goto Delay;
	
	//******************************************************
	//	Ready / Delay
	//******************************************************
	
	Delay:
		"----" A 1;
		"----" A 0 Jump(state("Ready"));
	Ready:
		"----" A 1 A_WeaponReady(WRF_NOSECONDARY | WRF_ALLOWRELOAD);
		loop;
	Ready.NoFire:
		"----" A 1 A_WeaponReady(WRF_NOFIRE | WRF_ALLOWRELOAD);
		loop;
	
	//******************************************************
	//	Select / Deselect
	//******************************************************
	
	Select:
		"----" A 1 W_RaiseWeapon();
		loop;
		
	Deselect:
		"----" A 1 W_LowerWeapon();
		loop;
	
	//******************************************************
	//	Filler
	//******************************************************
	
	Fire:
		"----" A 1;
		Goto Reload;
	}
}