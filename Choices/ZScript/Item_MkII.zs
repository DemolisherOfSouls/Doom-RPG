Actor Item_MkII : Item_Weapon
{
	States
	{
	Spawn:
		GMk2 A 15;
		GMk2 A 5 Bright;
		Loop;
	Pickup:
		TNT1 A 0 A_JumpIf(!CallACS("WeaponPickup", WT_PISTOL, W_MKII), "Pickup.Fail");
		TNT1 A 0 A_GiveInventory("AmmoMag_MkII", 12);
		Goto Pickup.Force;
	}
}

Actor Item_MkIIDropped : Item_MkII
{
	States
	{
	Pickup:
		TNT1 A 0 A_JumpIf(!CallACS("WeaponPickup", WT_PISTOL, W_MKII), "Pickup.Fail");
		Goto Pickup.Force;
	}
}