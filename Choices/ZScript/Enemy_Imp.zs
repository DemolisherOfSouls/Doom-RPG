class Enemy_Imp : Enemy_Demonic replaces DoomImp
{
  mixin Mixin_Imp;

  default
  {
    SpawnID 5;
    Health 60;
    Radius 20;
    Mass 100;
    PainChance 200;
    SeeSound "imp/sight";
    PainSound "imp/pain";
    DeathSound "imp/death";
    ActiveSound "imp/active";
    HitObituary "$OB_IMPHIT";
    Obituary "$OB_IMP";
    
    Entity.XP 10;
		Entity.Renown 0;
		Entity.Type "Imp";
		Entity.HasDeathAnim false;
    Enemy.PainTime 2;
    
    DropItem "Item_Soul", 255;
    DropItem "Item_Soul", 128;
    DropItem "Item_Soul", 16;
  }
  
	States
	{
	Spawn.Stage2:
		TROO A 0;
		goto Spawn.Final;
	
	See.Real:
		TROO AABBCCDD 3 A_Chase("Attack", "Attack");
		Loop;
	Attack:
		TROO EF 8 A_FaceTarget;
		TROO G 6 E_ImpAttack;
		Goto See;
	
	Pain:
		TROO H 0 Jump("Pain.Actual");
	
	Death.Stage1:
		TROO I 0 A_Jump(Always, "Death.Anim1", "Death.Anim2", "Death.Anim3", "Death.Anim4")
	
	Death.Anim1:
		TROO I 8 A_SetUserVar("user_deathanim", 1);
		TROO J 8 A_ScreamAndUnblock;
		TROO KLM 6;
		Goto Death.Finish
	Death.Anim2:
		TROO I 8 A_SetUserVar("user_deathanim", 2);
		TROO J 8 A_ScreamAndUnblock;
		TROO KLM 6;
		Goto Death.Finish;
	Death.Anim3:
		TROO I 8 A_SetUserVar("user_deathanim", 3);
		TROO J 8 A_ScreamAndUnblock;
		TROO KLM 6;
		Goto Death.Finish;
	Death.Anim4:
		TROO I 8 A_SetUserVar("user_deathanim", 4);
		TROO J 8 A_ScreamAndUnblock;
		TROO KLM 6;
		Goto Death.Finish;
	
	Headshot.Stage1:
		TROO V 8;
		TROO W 8 A_ScreamAndUnblock;
		TROO XYZ 6;
		Goto Death.Finish;
	XDeath.Stage1:
		TROO N 5
		TROO O 5 A_XScream;
		TROO P 5;
		TROO Q 5 A_NoBlocking;
		TROO RSTU 5;
		Goto Death.Finish;
	
	Raise.Anim1:
		TROO MLK 6;
		TROO JI 8;
		Goto See;
	Raise.Anim2:
		TROO MLK 6;
		TROO JI 8;
		Goto See
	Raise.Anim3:
		TROO MLK 6
		TROO JI 8
		Goto See;
	Raise.Anim4:
		TROO MLK 6;
		TROO JI 8;
		Goto See;
	
	Raise.Headshot:
		TROO ZYX 6;
		TROO WV 8;
		Goto See;
	Raise.XDeath:
		TROO UTSRQPON 5;
		Goto See;
	}
}