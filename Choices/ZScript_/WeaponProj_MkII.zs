class WeaponProj_MkII : WeaponProj_Bullet
{
	default
	{
		Damage (CallACS("WeaponDamage", WD_MKII));
		DamageType "Player_Pistol";
		SeeSound "Weapon/MkII";
		Decal "BulletChip";
	}
}

class WeaponProj_MkII_57 : WeaponProj_MkII
{
	default
	{
		Speed 80;
		Decal "BulletChip";
	}
}

class WeaponProj_MkII_Silent : WeaponProj_MkII
{
	default
	{
		SeeSound "Weapon/MkIISilent";
		Decal "BulletChip";
	}
}