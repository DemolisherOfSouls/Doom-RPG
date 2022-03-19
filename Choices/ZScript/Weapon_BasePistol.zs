class Weapon_BasePistol : Weapon_Base
{
	default
	{
    Weapon.SlotNumber 2;
    Weapon.SelectionOrder 5;
    
    Weapon.AmmoType2 "Ammo_Clip";

    +WEAPON.WIMPY_WEAPON
	}
  
  mixin Mix_Pistol;
	
	states
	{
	Reload.Click:
		"####" A 1;
		"####" A 5 A_PlayWeaponSound("Weapon/PistolEmpty");
	Reload:
		"####" A 0 A_JumpIfInventory("Ammo_Clip", 1, "Reload.CheckMag");
		goto Ready.CheckAmmo;
	}
}