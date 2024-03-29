class Enemy_Zombieman : Enemy_Zombie replaces Zombieman
{
	default
	{
		SpawnID 4;
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
		POSS A 0 NoDelay Jump("Spawn.Final");
	Missile:
		POSS E 10 A_FaceTarget;
		POSS F 8 Bright EZ_FireBullet("Zombieman")
		POSS E 8;
		goto See;
	}
}