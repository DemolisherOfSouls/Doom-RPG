class Item_ShellBox : Item_Ammo replaces ShellBox
{
	default
	{
		SpawnID 143;
		Item_Ammo.Type AT_SHELL;
    Item_Ammo.Quantity 16;
	}

	states
	{
	Spawn:
		SBOX A 15;
		SBOX A 5 Bright;
		Loop;
	}
}