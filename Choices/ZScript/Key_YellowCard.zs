class Key_YellowCard : KeyBase replaces YellowCard
{
  default
  {
    SpawnID 87;
    KeyBase.Key 3;
	}
  
	states
	{
	Spawn:
		YKEY A 0;
		goto Idle;
	}
}