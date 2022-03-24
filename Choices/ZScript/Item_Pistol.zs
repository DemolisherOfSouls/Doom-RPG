class Item_Pistol : Item_Weapon replaces Pistol
{
	states
	{
	Spawn:
		PIST A 15;
		PIST A 5 Bright;
		Loop;
	Pickup:
		TNT1 A 0 A_JumpIf(!CallACS("WeaponPickup", WT_PISTOL, W_PISTOL), "Pickup.Fail")
		TNT1 A 0 A_GiveInventory("AmmoMag_Pistol", 10);
		Goto Pickup.Force;
	}
}

class Item_PistolDropped : Item_Pistol
{
	states
	{
	Pickup:
		TNT1 A 0 A_JumpIf(!CallACS("WeaponPickup", WT_PISTOL, W_PISTOL), "Pickup.Fail")
		Goto Pickup.Force;
	}
}

class Item_Pistol_Second : Item_Weapon
{
	states
	{
	Spawn:
		DPis A 15;
		DPis A 5 Bright;
		Loop;
	Pickup:
		TNT1 A 0 A_JumpIf(!CallACS("WeaponPickup", WT_PISTOL, W_PISTOL, WM_PISTOL_SECOND), "Pickup.Fail")
		TNT1 A 0 A_GiveInventory("InvMod_Pistol_Second", 1);
		TNT1 A 0 A_GiveInventory("AmmoMag_Pistol", 10);
		TNT1 A 0 A_GiveInventory("AmmoMag_Pistol2", 10);
		Goto Pickup.Force;
	}
}

class Item_PistolDropped_Second : Item_Weapon
{
	states
	{
	Pickup:
		TNT1 A 0 A_JumpIf(!CallACS("WeaponPickup", WT_PISTOL, W_PISTOL, WM_PISTOL_SECOND), "Pickup.Fail");
		TNT1 A 0 A_GiveInventory("InvMod_Pistol_Second", 1);
		Goto Pickup.Force;
	}
}

class Item_Pistol_Silent : Item_Weapon
{
	states
	{
	Spawn:
		SPis A 15
		SPis A 5 Bright
		Loop
	Pickup:
		TNT1 A 0 A_JumpIf(!CallACS("WeaponPickup", WT_PISTOL, W_PISTOL, WM_PISTOL_SILENT), "Pickup.Fail")
		TNT1 A 0 A_GiveInventory("InvMod_Pistol_Silent", 1)
		TNT1 A 0 A_GiveInventory("AmmoMag_Pistol", 10)
		Goto Pickup.Force
	}
}

class Item_PistolDropped_Silent : Item_Pistol_Silent
{
	states
	{
	Pickup:
		TNT1 A 0 A_JumpIf(!CallACS("WeaponPickup", WT_PISTOL, W_PISTOL, WM_PISTOL_SILENT), "Pickup.Fail")
		TNT1 A 0 A_GiveInventory("InvMod_Pistol_Silent", 1)
		Goto Pickup.Force
	}
}