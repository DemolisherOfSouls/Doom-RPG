//Needs SKILL_Reloader implementation
//Needs Accuracy implementation

class Weapon_PlasmaRifle : Weapon_BaseEnergy
{
  
  mixin Mix_Jump;

  int acc;

  default
  {
    Weapon.AmmoType1 "AmmoMag_PlasmaRifle";
    Inventory.Icon "PLASA0";
    Tag "Plasma Rifle";
  }
  
	states
	{
	Ready:
		PLSG A 1 A_WeaponReady(WRF_NoSecNormal);
		Loop;
	Select:
		PLSG A 0;
		Goto Super::Select;
	
	Fire:
		PLSG A 0 A_JumpIfNoAmmo("Reload.Click");
		PLSG A 3 A_GunFlash("Fire.Actual");
		Goto Ready;
	
	Fire.Actual:
		PLSF A 0 A_SetArg(2, CallACS("WeaponAccuracy", WT_ENERGY, 07));
		PLSF A 0 A_FireCustomMissile("WeaponProj_PlasmaBall", FRandom(-args[2], args[2]) / 10, true, 0, 0, 0, FRandom(-args[2], args[2]) / 10);
		PLSF A 0 A_AlertMonsters(640);
		PLSF A 0 Jump("Flash.A", "Flash.B");
	Flash.A:
		PLSF A 3 Bright A_Light1;
		Goto LightDone;
	Flash.B:
		PLSF B 3 Bright A_Light1;
		Goto LightDone;
	
	Reload.Start:
		PLSG B 20 A_JumpIfInventory("AmmoMag_PlasmaRifle", 0, "Delay");
		PLSG A 0 A_GunFlash("Reload.Process", GFF_NOEXTCHANGE);
		Goto Ready;
	
	Reload.Process:
		TNT1 A 0 A_GiveInventory("AmmoMag_PlasmaRifle", 1);
		TNT1 A 0 A_TakeInventory("Ammo_Cell", 1, TIF_NOTAKEINFINITE);
		TNT1 A 0 A_JumpIfInventory("AmmoMag_PlasmaRifle", 0, "LightDone");
		TNT1 A 0 A_JumpIfInventory("Ammo_Cell", 1, "Reload.Process");
		Stop;
	}
}