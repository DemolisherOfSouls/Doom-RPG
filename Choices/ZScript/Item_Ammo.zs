class Item_Ammo : Item
{
  int qty;
  int typ;

  property AmmoType: typ;
  property Quanity: qty;

	default
	{
		Inventory.PickupSound "Pickup/Ammo";
    Item_Ammo.Quanity 1
	}
  states
  {
  Pickup:
		TNT1 A 0
    {
      ACS_NamedExecuteAlways("Item_Ammo", 0, qty, AT_SHELL)
    }
		Stop
  }
}