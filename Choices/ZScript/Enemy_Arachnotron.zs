class Enemy_Arachnotron : Enemy_Cyborg replaces Arachnotron
{
	default
	{
		SpawnID 6;
		Health 500;
		Radius 64;
		Height 64;
		Mass 600;
		Speed 12;
		PainChance 128;
		SeeSound "baby/sight";
		PainSound "baby/pain";
		DeathSound "baby/death";
		ActiveSound "baby/active";
		Obituary "$OB_BABY";
		Entity.XP 30;
		Entity.Type "Arachnotron"
		Enemy.PainTime 3;
		+BOSSDEATH;
	}
	
	mixin Mix_Jump;
	
	states
	{
	Spawn.Stage2:
		BSPI A 0;
		goto Spawn.Final;
    
	See.Real:
		BSPI A 20;
  See.NoDelay:
		BSPI A 3 A_BabyMetal;
		BSPI ABBCC 3 A_Chase;
		BSPI D 3 A_BabyMetal;
		BSPI DEEFF 3 A_Chase;
		Loop;
	Missile:
		BSPI A 20 Bright A_FaceTarget;
		BSPI G 4 Bright A_CustomMissile("EnemyProj_ArachnotronPlasma", 32, 0, 0, CMF_STANDARD);
		BSPI H 4 Bright;
		BSPI H 1 Bright A_SpidRefire;
		goto Missile + 1;
	Pain:
		BSPI I 0 E_Pain;
  
	XDeath:
	Death.Headshot:
  Death:
		"----" A 0 E_Death("Death", 2);
	Death.Anim1:
		BSPI J 20 A_Scream;
		BSPI K 7 A_NoBlocking;
		BSPI LMNOP 7;
		goto Death.Finish;
	Death.Anim2:
		BSPI Q 10 A_PlaySound("Arachnotron/AltDeath", Chan_Body);
		BSPI R 8 A_NoBlocking;
		BSPI S 6;
		BSPI TU 6 Bright;
		BSPI V 5 Bright;
		BSPI WXY 4 Bright;
		goto Death.Finish;
		
	Raise.Anim1:
		BSPI PONMLKJ 7;
		goto Raise.Finish;
	Raise.Anim2:
		BSPI YXWVUTSRQ 5;
    goto Raise.Finish;
	}
}
