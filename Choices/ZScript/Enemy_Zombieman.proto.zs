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

	}

  float Acc()
  {
    return FRandom(-5.75,5.75);
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

class Enemy_Zombieman : Enemy_Zombie replaces Zombieman
{
	default
	{
		SpawnID 4;
		Radius 20;
		Mass 100;
		Speed 4;
		Species "Zombie";
		DamageFactor "Enemy_PistolBullet", 0;
		DamageFactor "Enemy_RifleBullet", 0;
		DamageFactor "Enemy_ShotgunPellet", 0;
		DamageFactor "Enemy_ChaingunBullet", 0;
		Health 20;
		PainChance 200;
		SeeSound "grunt/sight";
		AttackSound "grunt/attack";
		PainSound "grunt/pain";
		DeathSound "grunt/death";
		ActiveSound "grunt/active";
		Obituary "$OB_ZOMBIE";

		Entity.XP 5;
		Entity.Renown 0;
		Entity.Type "Zombieman";
		Entity.DeathAnims

		DropItem "Item_Clip", 255;
		DropItem "Item_Clip", 128;
		DropItem "ItemDrop_Pistol", 16;
		DropItem "Item_Money", 128;
		DropItem "Item_Money", 32;
	}

	states
	{
	Spawn:
		POSS A 0 NoDelay E_Setup;
	Idle:
		POSS AB 10 A_Look;
		Loop;
	Missile:
		POSS E 10 A_FaceTarget;
		POSS F 8 Bright EZ_FireBullet("Zombieman")
		POSS E 8;
		goto See;
	}
}