class Enemy_ShotgunGuy : Enemy_Zombie replaces ShotgunGuy
{
	default
	{
		SpawnID 1;
		Health 30;
		PainChance 170;
		SeeSound "shotguy/sight";
		AttackSound "shotguy/attack";
		PainSound "shotguy/pain";
		DeathSound "shotguy/death";
		ActiveSound "shotguy/active";
		Obituary "$OB_SHOTGUY";

		Entity.XP 10;
		Entity.Renown 0;
		Entity.Type "ShotgunGuy";
		Entity.HasDeathAnim false;
	
		DropItem "Item_Shell", 255;
		DropItem "ItemDrop_Shotgun", 128;
		DropItem "Item_Money", 160;
		DropItem "Item_Money", 72;
		DropItem "Item_Money", 24;
	}

	states
	{
	Spawn:
		SPOS A 0;
		goto Spawn.Final;
	Missile:
		SPOS E 10 A_FaceTarget;
		SPOS FFF 0 A_CustomMissile("EnemyProj_ShotgunGuy", 32, 0, Acc(), CMF_STANDARD, Acc());
		SPOS F 10 BRIGHT;
		SPOS E 10;
		goto See;
	Headshot.Stage1:
		SPOS V 8;
		SPOS W 8 A_ScreamAndUnblock;
		SPOS XYZ 6 A_NoBlocking;
		goto Death.Finish;
	Raise.Headshot:
		SPOS ZYX 6;
		SPOS WV 8;
		goto See;
	}
}