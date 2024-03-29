class Enemy_HellKnight : Enemy_Baron replaces HellKnight
{
	SpawnID 113
	Health 500
	SeeSound "knight/sight"
	ActiveSound "knight/active"
	PainSound "knight/pain"
	DeathSound "knight/death"
	HitObituary "$OB_KNIGHTHIT"
	Obituary "$OB_KNIGHT"
	
	DropItem "Item_Soul5", 255
	DropItem "Item_Soul", 64
	DropItem "Item_Soul", 8

	States
	{
	Spawn.Stage2:
		BOS2 A 0 A_SetUserVar("user_rewardxp", 30)
		BOS2 A 0 A_SetUserVar("user_rewardrenown", 2)
		BOS2 A 0 A_SetUserVar("user_type", ET_HELLKNIGHT)
		Goto Spawn.Final
	Attack:
		BOS2 EF 8 A_FaceTarget
		BOS2 G 8 A_CustomComboAttack("EnemyProj_HellKnightBall", 32, 10 * random(1, 8), "baron/melee", "Enemy_HellKnightMelee", true)
		Goto See
	}
}