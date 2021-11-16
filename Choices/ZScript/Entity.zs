class Entity : Actor
{
	string typ;
	
	int rewardxp;
	int rewardrenown;
	
	bool awake;
	bool alert;
	bool useanim;
	
	actor head;
	int id;
	int level;
	
	string deathtype;
	int deathanim;

	property Type: typ;
	property XP: rewardxp;
	property Renown: rewardrenown;
	property HasDeathAnim: useanim;
	
	default
	{
		Height 56;
		Monster;
		+FLOORCLIP
		+DONTHARMSPECIES
		+QUICKTORETALIATE
	}

	states
	{
	Raise:
		"----" A 0
		{
			if(useanim)
				return state("Raise."..deathtype.."."..deathanim);
			return state("Raise."..deathtype);
		}
	}
}