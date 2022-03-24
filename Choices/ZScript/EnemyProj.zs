class EnemyProj_Ball : Proj
{
	default
	{
		Radius 6;
		Height 8;
		Speed 10;
		Species "DemonThru";
		+RANDOMIZE;
		RenderStyle Add;
		Alpha 0.8;
	}
	
	states
	{
	Death:
		"####" CDE 6;
		stop;
	}
}

class EnemyProj_ZombieBullet : Proj_Bullet
{
	default
	{
		Species "ZombieThru";
	}
}

class EnemyProj_Zombieman : EnemyProj_ZombieBullet
{
	default
	{
		Damage (8);
		DamageType "Enemy_RifleBullet";
	}
}

class EnemyProj_ShotgunGuy : EnemyProj_ZombieBullet
{
	default
	{
		Damage (7);
		DamageType "Enemy_ShotgunPellet";
	}
}

class EnemyProj_ChaingunGuy : EnemyProj_ZombieBullet
{
	default
	{
		Damage (7);
		DamageType "Enemy_ChaingunBullet";
	}
}

class EnemyProj_CyborgBullet : Proj_Bullet
{
	default
	{
		Species "CyborgThru";
	}
}

class EnemyProj_ImpBall : EnemyProj_Ball replaces DoomImpBall
{
	default
	{
		SpawnID 10;
		Damage (12);
		DamageType "Enemy_ImpBall";
		SeeSound "imp/attack";
		DeathSound "imp/shotx";
		Decal "DoomImpScorch";
	}
	
	states
	{
	Spawn:
		BAL1 AB 4;
		loop;
	}
}

class EnemyProj_CacodemonBall : EnemyProj_Ball replaces CacodemonBall
{
	default
	{
		SpawnID 126;
		Damage (20);
		DamageType "Enemy_CacoBall";
		SeeSound "caco/attack";
		DeathSound "caco/shotx";
		Decal "CacoScorch";
	}
	
	states
	{
	Spawn:
		BAL2 AB 4;
		loop;
	}
}

class EnemyProj_ArachnotronPlasma : EnemyProj_Ball replaces ArachnotronPlasma
{
	default
	{
		SpawnID 129;
		Radius 13;
		Speed 25;
		Damage (20);
		DamageType "Enemy_ArachPlasma";
		SeeSound "baby/attack";
		DeathSound "baby/shotx";
		Decal "ArachnotronScorch";
	}
	
	states
	{
	Spawn:
		APLS AB 5;
		loop;
	Death:
		APBX ABCDE 5;
		stop;
	}
}

class EnemyProj_BaronBall : EnemyProj_Ball replaces BaronBall
{
	default
	{
		SpawnID 154;
		Height 16;
		Speed 15;
		Damage (32);
		DamageType "Enemy_BaronBall";
		SeeSound "baron/attack";
		DeathSound "baron/shotx";
		Decal "BaronScorch";
	}
	
	states
	{
	Spawn:
		BAL7 AB 4;
		loop;
	}
}

class EnemyProj_HellKnightBall : EnemyProj_BaronBall
{
	default
	{
		DamageType "Enemy_HellKnightBall";
		Decal "BaronScorch";
	}
}