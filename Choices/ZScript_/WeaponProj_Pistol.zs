class WeaponProj_Pistol : WeaponProj_Bullet
{
	default
	{
		Damage (CallACS("WeaponDamage", WD_PISTOL))
		DamageType "Player_Pistol"
		Decal "BulletChip"
	}
}