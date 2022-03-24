class Proj_TracerTrail
{
  default
  {
    Height 4;
    Radius 2;
    +NOGRAVITY;
    +NOINTERACTION;
  }
  
  action void P_Trail(bool dospawn)
  {
    int offset = 0;
    
    if(dospawn)
    {
      do
      {
        A_SpawnItemEx("Proj_TracerTrail2", cos(pitch) * offset, 0, sin(pitch) * offset, velx, vely, velz, 0, SXF_TRACERTRAIL);
        offset += 7;
      } while (offset < 56)
    }
    A_FadeOut(0.05, true);
  }
	
	states
	{
	Spawn:
		BULL B 1 NoDelay P_Trail(true);
    wait;
	}
}

class Proj_TracerTrail2 : Proj_TracerTrail
{
	states
	{
	Spawn:
		BULL B 1 NoDelay P_Trail(false);
    wait;
	}
}