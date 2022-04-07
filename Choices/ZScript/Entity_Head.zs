class Entity_Head
{
  default
  {
    Height 16
    Radius 17
    Health 10000
    RenderStyle None
    +SHOOTABLE
    +THRUSPECIES
    +NOGRAVITY
    +LOOKALLAROUND
    +NORADIUSDMG
    +QUICKTORETALIATE
    +STANDSTILL
	}
  
	states
	{
	Spawn:
		TNT1 A -1;
		Stop;
	}
}