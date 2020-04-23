class Enemy : Entity
{
	int ptime;
	bool painjump;
	
	property PainTime: ptime;
	
	void E_Setup()
	{
		//ACS_NamedExecuteAlways("EnemySetup")
	}
	state E_Death(string type)
	{
		deathtype = type;
		
		let killer_player = RPGPlayer(target);
		let killer_enemy  = Enemy(target);
		let killer_ally   = Ally(target);
		
		if(killer_player)
		{
			ACS_NamedExecuteAlways("PlayerExp", 0, rewardxp);
			ACS_NamedExecuteAlways("PlayerRage", 0, deathtype);
			ACS_NamedExecuteAlways("PlayerRenown", 0, rewardrenown);
		}
		else if(killer_enemy)
		{
			ACS_NamedExecuteAlways("EnemyRenown", 0, rewardrenown);
			ACS_NamedExecuteAlways("EnemyExp", 0, rewardxp);
		}
		else if(killer_ally)
		{
			ACS_NamedExecuteAlways("AllyRenown", 0, rewardrenown);
			ACS_NamedExecuteAlways("AllyExp", 0, rewardxp);
		}
		
		return state(type..".Stage1");
	}
	void E_BossCheck()
	{
		if(bBOSSDEATH) A_BossDeath;
	}
	
	states
	{
	Spawn:
		TNT1 A 0 NoDelay A_Jump(Always, "Spawn.Stage2");
	Spawn.Stage2:
		"----" A 0 A_Jump(Always, "Spawn.Final");
	Spawn.Final:
		"----" A 0 NoDelay E_Setup();
	Idle:
		"####" AAAAAAAAAABBBBBBBBBB 1 A_Look;
		Loop;
	See:
		"----" A 0
		{
			awake = true;
			alert = true;
			if(painjump)
				return state("See.NoDelay");
			return state("See.Real");
		}
	Pain.Actual:
		"----" A 3 A_SetTics(user_paintime);
		"----" A 0 A_Pain;
		"----" A 3 A_SetTics(user_paintime);
		"----" A 0 A_Jump(Always, "See");
	Death:
		"----" A 0 E_Death("Death");
	XDeath:
		"----" A 0 E_Death("XDeath");
	Death.Headshot:
		"----" A 0 E_Death("Headshot");
	Headshot.Stage1:
	XDeath.Stage1:
		"----" A 0 A_Jump(Always, "Death.Stage1");
	Raise.Headshot:
	Raise.XDeath:
		"----" A 0 A_Jump(Always, "Raise.Death");
	Death.Finish:
		"----" A -1 E_BossCheck();
		Stop;
	}
}

class Enemy_Zombie : Enemy
{
	default
	{
		Radius 20;
		Mass 100;
		Speed 4;
		Species "Zombie";
		DamageFactor "Enemy_PistolBullet", 0;
		DamageFactor "Enemy_RifleBullet", 0;
		DamageFactor "Enemy_ShotgunPellet", 0;
		DamageFactor "Enemy_ChaingunBullet", 0;
		Enemy.PainTime 3;
	}
	states
	{
	See.Real:
		"####" AAAABBBBCCCCDDDD 2 A_Chase;
		loop;
	Pain:
		"####" G 0 A_Jump(Always, "Pain.Actual");
	Death.Stage1:
		"####" H 5;
		"####" I 5 A_ScreamAndUnblock;
		"####" JKL 5;
		goto Death.Finish;
	Headshot.Stage1:
	XDeath.Stage1:
		"####" M 5;
		"####" N 5 A_XScream;
		"####" O 5 A_NoBlocking;
		"####" PQRSTU 5;
		Goto Death.Finish;
	Raise.Death:
		"####" LKJIH 5;
		goto See;
	Raise.Headshot:
	Raise.XDeath:
		"####" UTSRQPONM 5;
		goto See;
	}
}

class Enemy_Demonic : Enemy
{
	default
	{
		Speed 8;
		Species "Demon";
		DamageFactor "Enemy_ImpBall", 0;
		DamageFactor "Enemy_CacoBall", 0;
		DamageFactor "Enemy_BaronBall", 0;
		DamageFactor "Enemy_HellKnightBall", 0;
		DamageFactor "Enemy_ImpMelee", 0;
		DamageFactor "Enemy_BaronMelee", 0;
		+MISSILEMORE
	}
}

class Enemy_DemonicFloater : Enemy_Demonic
{
	default
	{
		+FLOAT
		+NOGRAVITY
		+DONTFALL
	}
}

class Enemy_Baron : Enemy_Demonic
{
	default
	{
		Radius 24
		Height 64
		Mass 1000
		PainChance 50
		BloodColor "Green"
		Enemy.PainTime 2;
	}
	states
	{
	See.Real:
		"####" AABBCCDD 3 A_Chase("Attack", "Attack");
		Loop;
	Pain:
		"####" H 0 A_Jump(Always, "Pain.Actual");
	Headshot.Stage1:
	XDeath.Stage1:
	Death.Stage1:
		"####" I 8;
		"####" J 8 A_ScreamAndUnBlock;
		"####" KLMN 8;
		Goto Death.Finish;
	Raise.Headshot:
	Raise.XDeath:
	Raise.Death:
		"####" ONMLKJI 8;
		Goto See;
	}
}

class Enemy_Cyborg : Enemy
{
	default
	{
		Species "Cyborg"
		DamageFactor "Enemy_ArachPlasma", 0
		DamageFactor "Enemy_MancubusShot", 0
		DamageFactor "Enemy_RevenantSeeker", 0
		DamageFactor "Enemy_SpiderBullet", 0
		DamageFactor "Enemy_CyberdemonRocket", 0
		+NOFEAR
		+MISSILEEVENMORE
	}
}