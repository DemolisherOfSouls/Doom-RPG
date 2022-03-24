class Entity : Actor
{
	string typ;
	
	int rewardxp;
	int rewardrenown;
	
	bool awake;
	bool alert;
	int anim_death;
  int anim_hdeath;
  int anim_xdeath;
	
	int headid;
	int id;
	int level;
	
	string deathtype;
	int deathanim;

	property Type:   typ;
	property XP:     rewardxp;
	property Renown: rewardrenown;
	property DeathAnimCount:  anim_death;
  property HDeathAnimCount: anim_hdeath;
  property XDeathAnimCount: anim_xdeath;
	
	default
	{
    Entity.DeathAnimCount 1;
    Entity.HDeathAnimCount 0;
    Entity.XDeathAnimCount 1;
		Height 56;
		Monster;
		+FLOORCLIP;
		+DONTHARMSPECIES;
		+QUICKTORETALIATE;
	}

	states
	{
	Raise:
		"----" A 0
		{
			if(DeathAnimCount > 1)
				return state("Raise."..deathtype..".Anim"..deathanim);
			return state("Raise."..deathtype);
		}
	}
}