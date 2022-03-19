class Enemy : Entity
{
	int ptime;
  string returnstate;

	mixin Mix_Jump;
  mixin Mix_ACS;
  mixin Mix_AI;
	
	property PainTime: ptime;
	property AlertState: returnstate;
  
  default
  {
    Enemy.AlertState "See";
    Enemy.PainTime 3;

  }
 
	states
	{
	Spawn:
		TNT1 A 0 NoDelay Jump("Spawn.Stage2");
	Spawn.Final:
		"----" A 0 NoDelay E_Setup();
	Idle:
		"####" AAAAAAAAAABBBBBBBBBB 1 A_Look;
		Loop;
	See:
		"----" A 0 E_See();
	Pain.Actual:
		"----" A 3 A_SetTics(ptime);
		"----" A 0 A_Pain;
		"----" A 3 A_SetTics(ptime);
		"----" A 0 Jump("See");
	Death:
		"----" A 0 E_Death("Death");
	XDeath:
		"----" A 0 E_Death("XDeath");
	Death.Headshot:
		"----" A 0 E_Death("Headshot");
	Headshot.Stage1:
    "----" A 0 Jump("XDeath.Stage1");
	XDeath.Stage1:
		"----" A 0 Jump("Death.Stage1");
	Raise.Headshot:
    "----" A 0 Jump("Raise.XDeath");
	Raise.XDeath:
		"----" A 0 Jump("Raise.Death");
  Raise.Finish:
    "####" A 0 E_RaiseFinish(AlertState);
	Death.Finish:
		"----" A -1 E_BossCheck();
		stop;
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
	}
  
  float Acc()
  {
    return FRandom(-5.75,5.75);
  }
  
  action void EZ_FireBullet(string type, int bullets = 1)
  {
    for(int i = 0; i< bullets; i++)
      A_CustomMissile("EnemyProj_"..type, 32, 0, Acc(), CMF_STANDARD, Acc());
  }
  
	states
	{
	See.Real:
		"####" AAAABBBBCCCCDDDD 2 A_Chase;
		loop;
	Pain:
		"####" G 0 Jump("Pain.Actual");
	Death.Stage1:
		"####" H 5;
		"####" I 5 A_ScreamAndUnblock;
		"####" JKL 5;
		goto Death.Finish;
	XDeath.Stage1:
		"####" M 5;
		"####" N 5 A_XScream;
		"####" O 5 A_NoBlocking;
		"####" PQRSTU 5;
		goto Death.Finish;
	Raise.Death:
		"####" LKJIH 5;
		goto See;
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
		+MISSILEMORE;
	}
}

class Enemy_DemonicFloater : Enemy_Demonic
{
	default
	{
		+FLOAT;
		+NOGRAVITY;
		+DONTFALL;
	}
}

class Enemy_Baron : Enemy_Demonic
{
	default
	{
		Radius 24;
		Height 64;
		Mass 1000;
		PainChance 50;
		BloodColor "Green";
		Enemy.PainTime 2;
	}

	states
	{
	See.Real:
		"####" AABBCCDD 3 A_Chase("Attack", "Attack");
		loop;
	Pain:
		"####" H 0 Jump("Pain.Actual");
	Headshot.Stage1:
	XDeath.Stage1:
	Death.Stage1:
		"####" I 8;
		"####" J 8 A_ScreamAndUnBlock;
		"####" KLMN 8;
		goto Death.Finish;
	Raise.Headshot:
	Raise.XDeath:
	Raise.Death:
		"####" ONMLKJI 8;
		goto See;
	}
}

class Enemy_Cyborg : Enemy
{
	default
	{
		Species "Cyborg";
		DamageFactor "Enemy_ArachPlasma", 0;
		DamageFactor "Enemy_MancubusShot", 0;
		DamageFactor "Enemy_RevenantSeeker", 0;
		DamageFactor "Enemy_SpiderBullet", 0;
		DamageFactor "Enemy_CyberdemonRocket", 0;
		+NOFEAR;
		+MISSILEEVENMORE;
    
    Enemy.AlertState "See.NoDelay";
	}
  
  states
  {
  
  }
}