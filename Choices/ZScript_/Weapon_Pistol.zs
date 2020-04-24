class Weapon_Pistol : Weapon_BasePistol
{
	default
	{
		Weapon.AmmoType1 "AmmoMag_Pistol"
		
		Inventory.Icon "PISTA0"
		
		Tag "Standard Issue Pistol"
	}
	
	states
	{
	
	//******************************************************
	//	Ready
	//******************************************************
	
	Ready:
		PISG A 0 A_JumpIfInventory("InvMod_Pistol_Second", 1, "Ready.Second")
		PISG A 0 A_JumpIfInventory("InvMod_Pistol_Silent", 1, "Ready.Silent")
		PISG A 1 A_WeaponReady(WRF_NOSECONDARY|WRF_ALLOWRELOAD)
		Loop
	Ready.Second:
		PisD A 1 A_WeaponReady(WRF_ALLOWRELOAD)
		Loop
	Ready.Silent:
		PisS A 1 A_WeaponReady(WRF_NOSECONDARY|WRF_ALLOWRELOAD)
		Loop
	
	//******************************************************
	//	Select
	//******************************************************
	
	Select:
		PISG A 0 A_JumpIfInventory("InvMod_Pistol_Second", 1, "Select.Second")
		PISG A 0 A_JumpIfInventory("InvMod_Pistol_Silent", 1, "Select.Silent")
		Goto Super::Select
	Select.Second:
		PISD A 0
		Goto Super::Select
	Select.Silent:
		PisS A 0
		Goto Super::Select
	
	//******************************************************
	//	Firing - Left - Flash A
	//******************************************************
	
	Fire.Second:
		PISD A 0 A_GunFlash("Fire.Left")
		Goto Fire.Left.Waiting
	
	Fire.Left.Waiting:
		PISD A 0 A_JumpIf(CallACS("GetKeyPress", MODINPUT_BUTTONS, BT_ALTATTACK), "Fire.Right")
		PISD A 1 A_JumpIf(args[1] == 0, "Ready.Second")
		Loop
	
	//******************************************************
	//	Firing - Left - Flash B
	//******************************************************
	
	Fire.Left:
		TNT1 A 0 A_SetArg(1, args[1]|1)
		TNT1 A 2 A_JumpIfInventory("AmmoMag_Pistol", 1, "Fire.Left.Ammo")
		Goto Reload.Left.Click
	Fire.Left.Ammo:
	
		PISD B 0 A_TakeInventory("AmmoMag_Pistol", 1)
		PISD B 0 A_SetArg(2, CallACS("WeaponAccuracy", WT_PISTOL, 25))
		PISD B 0 A_JumpIfInventory("InvMod_Pistol_Silent", 1, "Fire.Left.Silent")
		
		Fire.Left.Loud:
			PISD B 0 A_AlertMonsters(512)
			PISD B 0 A_PlayWeaponSound("Weapon/Pistol")
			Goto Fire.Left.Finish
			
		Fire.Left.Silent:
			PISD B 0 A_PlayWeaponSound("Weapon/SilentPistol")
			
		Fire.Left.Finish:
			PISD B 0 A_FireCustomMissile("WeaponProj_Pistol", FRandom(-args[2], args[2]) / 10, false, -12, 0, 0, FRandom(-args[2], args[2]) / 10)
		
		PISD B 3 A_Light(1)
		TNT1 A 2 A_Light(0)
		
		TNT1 A 0 A_JumpIf(CallACS("GetKeyPress", MODINPUT_BUTTONS, BT_ATTACK), "Fire.Left")
		TNT1 A 0 A_SetArg(1, args[1] & ~1)
		TNT1 A 0 A_JumpIf(args[1] != 0, "Fire.Left.Watcher")
		Stop
		
	Fire.Left.Watcher:
		TNT1 A 1
		TNT1 A 0 A_JumpIf(CallACS("GetKeyPress", MODINPUT_BUTTONS, BT_ATTACK), "Fire.Left")
		TNT1 A 0 A_JumpIf(args[1] == 0, "LightDone")
		Loop
	
	Reload.Left.Click:
		TNT1 A 0 A_PlayWeaponSound("Weapon/PistolEmpty")
		TNT1 A 0 A_JumpIfInventory("Ammo_Clip", 1, "Reload.Left.Anim")
		TNT1 A 0 A_SetArg(1, args[1] & ~1)
		TNT1 A 0 A_JumpIf(args[1] != 0, "Fire.Left.Watcher")
		TNT1 A 0 A_JumpIfInventory("AmmoMag_Pistol2", 1, "LightDone")
		Goto ChangeWeapon
	
	Reload.Left.Anim:
		PISG ABCBA 3
	
	Reload.Left.Process:
		TNT1 A 0 A_GiveInventory("AmmoMag_Pistol", 1)
		TNT1 A 0 A_TakeInventory("Ammo_Clip", 1, TIF_NOTAKEINFINITE)
		TNT1 A 0 A_JumpIfInventory("AmmoMag_Pistol", 0, "Reload.Left.Done")
		TNT1 A 0 A_JumpIfInventory("Ammo_Clip", 1, "Reload.Left.Process")
		Goto Reload.Left.Done
	
	Reload.Left.Done:
		TNT1 A 0 A_JumpIf(CallACS("GetKeyPress", MODINPUT_BUTTONS, BT_ATTACK), "Fire.Left.Ammo")
		TNT1 A 0 A_SetArg(1, args[1] & ~1)
		TNT1 A 0 A_JumpIf(args[1] != 0, "Fire.Left.Watcher")
		Stop
	
	//******************************************************
	//	Firing - Right - Flash A
	//******************************************************
	
	AltFire.Second:
		PISD C 0 A_GunFlash("Fire.Left.Watcher")
		Goto Fire.Right
	
	Fire.Right:
		PISD A 0 A_SetArg(1, args[1]|2)
		PISD A 2 A_JumpIfInventory("AmmoMag_Pistol2", 1, "Fire.Right.Ammo")
		Goto Reload.Right.Click
	Fire.Right.Ammo:
		
		PISD C 0 A_TakeInventory("AmmoMag_Pistol2", 1)
		PISD C 0 A_SetArg(2, CallACS("WeaponAccuracy", WT_PISTOL, 25))
		PISD C 0 A_JumpIfInventory("InvMod_Pistol_Silent", 1, "Fire.Right.Silent")
		
		Fire.Right.Loud:
			PISD C 0 A_AlertMonsters(512)
			PISD C 0 A_PlayWeaponSound("Weapon/Pistol")
			Goto Fire.Right.Finish
			
		Fire.Right.Silent:
			PISD C 0 A_PlayWeaponSound("Weapon/SilentPistol")
			
		Fire.Right.Finish:
			PISD C 0 A_FireCustomMissile("WeaponProj_Pistol", FRandom(-args[2], args[2]) / 10, false, 12, 0, 0, FRandom(-args[2], args[2]) / 10)
		
		
		PISD C 3 A_Light(1)
		PISD A 2 A_Light(0)
		
		PISD A 0 A_JumpIf(CallACS("GetKeyPress", MODINPUT_BUTTONS, BT_ALTATTACK), "Fire.Right")
		PISD A 0 A_SetArg(1, args[1] & ~2)
		Goto Fire.Left.Waiting
	
	Reload.Right.Click:
		TNT1 A 0 A_PlayWeaponSound("Weapon/PistolEmpty")
		TNT1 A 0 A_JumpIfInventory("Ammo_Clip", 1, "Reload.Right.Anim")
		TNT1 A 0 A_SetArg(1, args[1] & ~2)
		TNT1 A 0 A_JumpIf(args[1] != 0, "Fire.Left.Waitng")
		TNT1 A 0 A_JumpIfInventory("AmmoMag_Pistol", 1, "Ready.Second")
		Goto ChangeWeapon
	
	Reload.Right.Anim:
		PISG ABCBA 3
	
	Reload.Right.Process:
		TNT1 A 0 A_GiveInventory("AmmoMag_Pistol2", 1)
		TNT1 A 0 A_TakeInventory("Ammo_Clip", 1, TIF_NOTAKEINFINITE)
		TNT1 A 0 A_JumpIfInventory("AmmoMag_Pistol2", 0, "Reload.Right.Done")
		TNT1 A 0 A_JumpIfInventory("Ammo_Clip", 1, "Reload.Right.Process")
		Goto Reload.Right.Done
		
	Reload.Right.Done:
		TNT1 A 0 A_JumpIf(CallACS("GetKeyPress", MODINPUT_BUTTONS, BT_ALTATTACK), "Fire.Right.Ammo")
		TNT1 A 0 A_SetArg(1, args[1] & ~2)
		TNT1 A 0 A_JumpIf(args[1] != 0, "Fire.Left.Waitng")
		Goto Ready.Second
	
	
	//******************************************************
	//	Firing - AltFire
	//******************************************************
	
	AltFire:
		Goto AltFire.Second
	
	//******************************************************
	//	Reloading - Manual
	//******************************************************
	
	Reload.Second:
		TNT1 A 0 A_JumpIfInventory("Ammo_Clip", 1, "Reload.Second.Ammo")
		TNT1 A 0 A_JumpIfInventory("AmmoMag_Pistol", 1, "Delay")
		TNT1 A 0 A_JumpIfInventory("AmmoMag_Pistol2", 1, "Delay")
		Goto ChangeWeapon
	Reload.Second.Ammo:
		TNT1 A 0 A_JumpIfInventory("AmmoMag_Pistol", 0, "Reload.Second.Right")
		PISG ABCBA 3
		TNT1 A 0 A_GunFlash("Reload.Process", GFF_NOEXTCHANGE)
	Reload.Second.Right:
		TNT1 A 0 A_JumpIfInventory("AmmoMag_Pistol2", 0, "Delay")
		PISG ABCBA 3
		TNT1 A 0 A_GunFlash("Reload.Process2", GFF_NOEXTCHANGE)
		Goto Ready.Second
	
	//******************************************************
	//	Firing - Single
	//******************************************************
	
	Fire:
		PISG A 0 A_JumpIfInventory("InvMod_Pistol_Second", 1, "Fire.Second")
		PISG A 4 A_JumpIfNoAmmo("Reload.Click")
		
		PISG B 0 A_TakeInventory("AmmoMag_Pistol", 1)
		PISG B 0 A_SetArg(2, CallACS("WeaponAccuracy", WT_PISTOL, 21))
		
		PISG B 0 A_JumpIfInventory("InvMod_Pistol_Silent", 1, "Fire.Silent")
		
		Fire.Loud:
			PISG B 0 A_AlertMonsters(512)
			PISG B 0 A_PlayWeaponSound("Weapon/Pistol")
			PISG B 0 A_GunFlash("Flash", GFF_NOEXTCHANGE)
			Goto Fire.Finish
			
		Fire.Silent:
			PISG B 0 A_PlayWeaponSound("Weapon/SilentPistol")
			
		Fire.Finish:
			PISG B 6 A_FireCustomMissile("WeaponProj_Pistol", FRandom(-args[2], args[2]) / 10, false, 0, 0, 0, FRandom(-args[2], args[2]) / 10)
		
		PISG C 4
		PISG B 5 A_ReFire("Fire")
		Goto Ready
	
	Flash:
		PISF A 4 Bright A_Light1
		Goto LightDone
	
	Reload:
		PISG A 0 A_JumpIfInventory("InvMod_Pistol_Second", 1, "Reload.Second")
		Goto super::Reload
	Reload.CheckMag:
		PISG A 0 A_JumpIfInventory("AmmoMag_Pistol", 0, "Delay")
	Reload.Start:
		PISG A 1 Offset(0,48)
		PISG A 1 Offset(0,56)
		PISG A 1 Offset(0,64)
		PISG A 1 Offset(0,72)
		PISG A 1 Offset(0,80)
		PISG A 1 Offset(0,88) A_GunFlash("Reload.Process", GFF_NOEXTCHANGE)
		PISG A 1 Offset(0,80)
		PISG A 1 Offset(0,72)
		PISG A 1 Offset(0,64)
		PISG A 1 Offset(0,56)
		PISG A 1 Offset(0,48)
		Goto Ready
	
	Reload.Process:
		TNT1 A 0 A_GiveInventory("AmmoMag_Pistol", 1)
		TNT1 A 0 A_TakeInventory("Ammo_Clip", 1, TIF_NOTAKEINFINITE)
		TNT1 A 0 A_JumpIfInventory("AmmoMag_Pistol", 0, "LightDone")
		TNT1 A 0 A_JumpIfInventory("Ammo_Clip", 1, "Reload.Process")
		TNT1 A 0 A_PlayWeaponSound("Weapon/PistolEmpty")
		Stop
	Reload.Process2:
		TNT1 A 0 A_GiveInventory("AmmoMag_Pistol2", 1)
		TNT1 A 0 A_TakeInventory("Ammo_Clip", 1, TIF_NOTAKEINFINITE)
		TNT1 A 0 A_JumpIfInventory("AmmoMag_Pistol2", 0, "LightDone")
		TNT1 A 0 A_JumpIfInventory("Ammo_Clip", 1, "Reload.Process")
		TNT1 A 0 A_PlayWeaponSound("Weapon/PistolEmpty")
		Stop
	}
}