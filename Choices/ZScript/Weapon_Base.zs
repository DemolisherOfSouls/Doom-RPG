class Weapon_Base : Weapon
{
	default
	{
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
	
	string GetWeaponAmmoClass(int slot, int var)
	{
		//exceptions go here
	
		return "Ammo_"..AmmoClass[slot];
	}
	string GetAmmoMagClass (int slot, int var)
	{
		return "AmmoMag_"..WeaponClass[slot][var-1];
	}
	string GetWeaponClass(int slot)
	{
		int var = RPGPlayer(owner).cur_weapon[slot];
		return "Weapon_"..WeaponClass[slot][var-1];
	}
	bool HasAmmo(int slot, int var)
	{
		return CheckInventory(GetWeaponAmmoClass(type, var)) + CheckInventory(GetAmmoMagClass(type, var)) > 0;	
	}
	bool TryWeapon(int slot)
	{
		let player = RPGPlayer(self.player);
		
		if(player == NULL)
			return false;
		
		string w = GetWeaponClass(slot)
		int var = player.cur_weapon[slot];
		
		let weap = Weapon(player.FindInventory(w));
		
		if( CheckInventory(w) && HasAmmo(slot, var) && player.ReadyWeapon != weap)
			player.PendingWeapon = weap;
	}
	
	void W_RaiseWeapon()
	{
		int skill = RPGPlayer(owner).GetSkill(SKILL_QuickDraw);
		A_Raise(6 * (skill + 1));
	}
	void W_LowerWeapon()
	{
		int skill = RPGPlayer(owner).GetSkill(SKILL_QuickDraw);
		A_Lower(6 * (skill + 1))
	}
	void W_ChangeWeapon()
	{
		for(int w = 0; w < 10; w++)
		{
			int type = RPGPlayer(owner).weaponorder[w];
			
			if(TryWeapon(type))
				return;
		}
	}
	
	/*
	0 - (CHG - Current Speed)
	1 - (CHG - Tics in Frame, PIS - Firing Flags)
	2 - Accuracy
	3 - (CHG - Speed Offset before Firing)
	4 - (CHG - Slow Speed)
	*/
	
	states
	{
	
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