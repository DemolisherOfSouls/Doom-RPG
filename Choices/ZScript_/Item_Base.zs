class Item_Base : CustomInventory
{
	default
	{
		+INVENTORY.HUBPOWER
		+INVENTORY.PERSISTENTPOWER
	}
	states
	{
	Pickup.Fail:
		TNT1 A 0;
		fail
	Pickup.Force:
		TNT1 A 0 HealThing(0);
		stop
	}
}