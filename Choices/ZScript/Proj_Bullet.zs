class Proj_Bullet : Proj
{
	
	
	bool seek;
	
	void P_TryHome(bool trace)
	{
    if(seek)
      A_SeekerMissile(1, 2, SMF_SEEK, 128, 5);
    if(trace)
      A_SpawnItemEx("Proj_TracerTrail", 0, 0, 0, velx / 64, vely / 64, velz / 64, 0, SXF_TRACERTRAIL);
	}

	default
	{
		Height 4
		Radius 2
		Speed 64
		
		+BLOODSPLATTER
	}
	
	states
	{
	Spawn:
		BULL A 0 NoDelay
		{
			A_GiveInventory("Action_Set_ExtremeDeath", 1);
			let shooter = RPGPlayer(target);
			if(shooter)
				seek = shooter.getSkill(SKILL_HomingRounds);
			else
				seek = false;
			return state("Select");
		}
	Select:
		BULL A 0 A_Jump(Always, "Normal");
	Normal:
		BULL A 1 P_TryHome(false)
    wait;
	Tracer:
		BULL B 1 P_TryHome(true)
		wait;
	Death:
		TNT1 A 0 A_SpawnItem("BulletPuff");
	XDeath:
		TNT1 A 1 A_AlertMonsters(32);
		stop;
	}
}