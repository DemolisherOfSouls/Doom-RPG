mixin class Mix_Jump
{
	action state Jump(string label)
	{
		return state(label);
	}
}

mixin class Mix_ACS
{
	void ACS_ExecInt(string s, int a)
	{
		ACS_NamedExecuteAlways(s, 0, a);
	}
  
  void ACS_ExecStr(string s, string a)
  {
    ACS_NamedExecuteAlways(s, 0, a);
  }
}

mixin class Mix_Weapon
{
  string GetWeaponAmmoClass(int slot, int var) {
		//exceptions go here
	
		return "Ammo_"..AmmoClass[slot];
	}
	string GetAmmoMagClass (int slot, int var) {
		return "AmmoMag_"..WeaponClass[slot][var-1];
	}
	string GetWeaponClass(int slot) {
		int var = RPGPlayer(owner).cur_weapon[slot];
		return "Weapon_"..WeaponClass[slot][var-1];
	}
	bool HasAmmo(int slot, int var) {
		return CheckInventory(GetWeaponAmmoClass(type, var)) + CheckInventory(GetAmmoMagClass(type, var)) > 0;	
	}
	bool TryWeapon(int slot) {
		let player = RPGPlayer(self.player);
		
		if(player == NULL)
			return false;
		
		string w = GetWeaponClass(slot)
		int var = player.cur_weapon[slot];
		
		let weap = Weapon(player.FindInventory(w));
		
		if( CheckInventory(w) && HasAmmo(slot, var) && player.ReadyWeapon != weap)
			player.PendingWeapon = weap;
	}
	void W_RaiseWeapon() {
		int skill = RPGPlayer(owner).GetSkill(SKILL_QuickDraw);
		A_Raise(6 * (skill + 1));
	}
	void W_LowerWeapon() {
		int skill = RPGPlayer(owner).GetSkill(SKILL_QuickDraw);
		A_Lower(6 * (skill + 1))
	}
	void W_ChangeWeapon() {
		for(int w = 0; w < 10; w++)
		{
			int type = RPGPlayer(owner).weaponorder[w];
			
			if(TryWeapon(type))
				return;
		}
	}
}

mixin class Mix_Pistol
{
  void FirePistol (bool offhand)
  {
    
  }
  
  void EmptyPistol (bool offhand)
  {
    //GiveAmmo("AmmoMag_Pistol", 1)
    //GiveInventory(Class<Inventory> type, int amount, bool givecheat = false)
    //TakeInventory("Ammo_Clip", 1, , true)
		A_TakeInventory("Ammo_Clip", 1, TIF_NOTAKEINFINITE)
		A_JumpIfInventory("AmmoMag_Pistol", 0, "LightDone")
		A_JumpIfInventory("Ammo_Clip", 1, "Reload.Process")
		A_PlayWeaponSound("Weapon/PistolEmpty")
  }
}