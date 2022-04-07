class Item_AssaultRifle : Item_Weapon
{
	states
	{
	Spawn:
		GARf A 15;
		GARf A 5 Bright;
		Loop;
	Pickup:
		TNT1 A 0 A_JumpIf(!CallACS("WeaponPickup", WT_RIFLE, W_ASSAULTRIFLE), "Pickup.Fail");
		TNT1 A 0 A_GiveInventory("AmmoMag_AssaultRifle", 30);
		Goto Pickup.Force;
	}
}

class Item_AssaultRifleDropped : Item_AssaultRifle
{
	states
	{
	Pickup:
		TNT1 A 0 A_JumpIf(!CallACS("WeaponPickup", WT_RIFLE, W_ASSAULTRIFLE), "Pickup.Fail");
		Goto Pickup.Force;
	}
}