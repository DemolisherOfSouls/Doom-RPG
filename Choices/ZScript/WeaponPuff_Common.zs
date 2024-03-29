class Puff_Repeater
{
  default
  {
    Radius 3
    Height 3
    RenderStyle Add
    Alpha 0.75
    +AlwaysPuff
    +PuffOnActors
    +NoGravity
    +NoBlockMap
    +PuffGetsOwner
    +ForceRadiusDmg
    +BloodlessImpact
    +Bright
    SeeSound "Weapons/RepeaterHit"
    Decal MummyScorch
  }
	States
	{
	Spawn:
		RepP A 3 A_Explode(8, 40, XF_HURTSOURCE)
		RepP BCDEFG 3
		Stop
	}
}