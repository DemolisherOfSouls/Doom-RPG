class Item_Shell : Item_Ammo replaces Shell
{
  default
  {
    SpawnID 12
    Item_Ammo.Type AT_SHELL;
    Item_Ammo.Quantity 4;
	}
  
	States
	{
	Spawn:
		SHEL A 15
		SHEL A 5 Bright
		Loop
	}
}