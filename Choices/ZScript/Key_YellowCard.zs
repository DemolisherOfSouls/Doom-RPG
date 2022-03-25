class Key_YellowCard : CustomInventory replaces YellowCard
{
  default
  {
    SpawnID 87;
	}
  
	states
	{
	Spawn:
		YKEY A 15;
		YKEY B 5 Bright;
		loop;
	Pickup:
		TNT1 A 0 ACS_NamedExecuteAlways("Item_Key", 0, 3);
		stop;
	}
}