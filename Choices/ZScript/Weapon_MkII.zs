class Weapon_MkII : Weapon_BasePistol
{
  default
  {
    Weapon.AmmoType1 "AmmoMag_MkII";
    Inventory.Icon "Gmk2A0";
    Tag "MkII Sidearm";
	}
	States
	{
	Select:
		MK2G A 0;
		Goto Super::Select;
	
	Ready:
		MK2G A 1 A_WeaponReady(WRF_NoSecNormal);
		Loop;
	
	Fire:
		MK2G A 2 A_JumpIfNoAmmo("Reload.Click");
		MK2G B 5 A_GunFlash("Shoot");
		MK2G C 4;
		MK2G B 4 A_ReFire("Fire");
		Goto Ready;
	
	Shoot:
		MK2F A 0 A_SetArg(2, CallACS("WeaponAccuracy", WT_PISTOL, 21));
		MK2F A 0 A_JumpIfInventory("InvMod_MkII_Silent", 1, "Shoot.Silent");
		MK2F A 0 A_JumpIfInventory("InvMod_MkII_Grip", 1, "Shoot.Grip");
		MK2F A 0 A_JumpIfInventory("InvMod_MkII_Refit", 1, "Shoot.F7");
	Shoot.Normal:
		MK2F A 0 A_FireCustomMissile("WeaponProj_MkII", FRandom(-args[2], args[2]) / 10, true, 0, 0, 0, FRandom(-args[2], args[2]) / 10);
		MK2F A 0 A_AlertMonsters(496);
	Flash:
		MK2F A 0 A_AlertMonsters(496);
	Flash.Less:
		MK2F A 4 Bright A_Light1;
		Goto LightDone;
	
	Shoot.Silent:
		MK2F A 0 A_SetArg(2, args[2] - 3);
		MK2F A 0 A_FireCustomMissile("WeaponProj_MkII_Silent", FRandom(-args[2], args[2]) / 10, true, 0, 0, 0, FRandom(-args[2], args[2]) / 10)
		Goto Flash.Less;
	Shoot.Grip:
		MK2F A 0 A_SetArg(2, args[2] - 7);
		MK2F A 0 A_JumpIfInventory("InvMod_MkII_Refit", 1, "Shoot.F7")
		Goto Shoot.Normal;
	Shoot.F7:
		MK2F A 0 A_SetArg(2, args[2] - 1);
		MK2F A 0 A_FireCustomMissile("WeaponProj_MkII_57", FRandom(-args[2], args[2]) / 10, true, 0, 0, 0, FRandom(-args[2], args[2]) / 10)
		Goto Flash;
	
	Reload.CheckMag:
		MK2G A 0 A_JumpIfInventory("AmmoMag_MkII", 0, "Delay");
	Reload.Start:
		MK2G DEFGHIJKLMNOPQR 2;
		MK2G S 2 A_GunFlash("Reload.Process", GFF_NOEXTCHANGE);
		Goto Ready;
	
	Reload.Process:
		TNT1 A 0 A_GiveInventory("AmmoMag_MkII", 1);
		TNT1 A 0 A_TakeInventory("Ammo_Clip", 1, TIF_NOTAKEINFINITE);
		TNT1 A 0 A_JumpIfInventory("AmmoMag_MkII", 0, "Reload.Process.Done");
		TNT1 A 0 A_JumpIfInventory("Ammo_Clip", 1, "Reload.Process");
	Reload.Process.Done:
		TNT1 A 0 A_PlayWeaponSound("Weapon/MkIIEmpty");
		Stop;
	}
}