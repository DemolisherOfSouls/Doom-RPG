class WeaponProj_Rifle : WeaponProj_Bullet
  
  
  
  default
  {
    Damage (CallACS("WeaponDamage", WD_RIFLE))
    DamageType "Player_Rifle"
    Decal "BulletChip"
  }
}