class KeyBase : CustomInventory
{
  int keynum;
  
  property Key: keynum;
  
	states
	{
  Idle:
		"####" A 15;
		"####" B 5 Bright;
		loop;
	Pickup:
		TNT1 A 0 ACS_NamedExecuteAlways("Item_Key", 0, keynum);
		stop;
	}
}