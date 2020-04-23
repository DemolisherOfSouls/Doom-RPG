class Entity : Actor
{
	string typ;
	
	int rewardxp;
	int rewardrenown;
	
	property Type: typ;
	property XP: rewardxp;
	property Renown: rewardrenown;
	
	bool awake;
	bool alert;
	
	actor head;
	int id;
	int level;
	
	string deathtype;
	int deathanim;
	
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
		"----" A 0 { return state("Raise."..deathtype); }
	
	Raise.Death:
		"----" A 0 { return state("Raise."..deathtype.."."..deathanim); } // Raise.Death.x
	}
}