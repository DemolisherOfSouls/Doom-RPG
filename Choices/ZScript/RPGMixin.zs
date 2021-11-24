mixin class Mix_Jump
{
	action state Jump(string label)
	{
		return state(label);
	}
}

mixin class WeaponExt_Pistol
{
  void FirePistol (bool offhand)
  {
    
  }
  
  void EmptyPistol (bool offhand)
  {
    GiveAmmo("AmmoMag_Pistol", 1)
    GiveInventory(Class<Inventory> type, int amount, bool givecheat = false)
    TakeInventory("Ammo_Clip", 1, , true)
		A_TakeInventory("Ammo_Clip", 1, TIF_NOTAKEINFINITE)
		A_JumpIfInventory("AmmoMag_Pistol", 0, "LightDone")
		A_JumpIfInventory("Ammo_Clip", 1, "Reload.Process")
		A_PlayWeaponSound("Weapon/PistolEmpty")
  }
}