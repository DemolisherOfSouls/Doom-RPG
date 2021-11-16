class RPGPlayer : DoomPlayer
{
	// main
	int level;
	int renown;
	int experience;
	
	// rage
	int rage;
	
	// secondary
	int accuracy[10];
	int disableweapon[10];
	
	// waiting
	int skillpoints;
	int perkpoints;
	
	// message queue
	int ammoqueue[5];
	int moneyqueue;
	int soulsqueue;
	
	// weapons
	int cur_weapon[10];
	int cur_mod[10];
	int weaponorder[10];
	bool autoswitch;
	
	// counters
	int total_moneyfound;
	int total_keysfound;
	int total_soulsfound;
	
	// stats
	int player_perks[20];
	int player_skills[200];
	int player_achievements[50];
	
	// missions
	int mission_type[1024];
	int mission_status[1024];
	int mission_map[1024];
	int mission_owner[1024];
	
	// props
	actor head;
	
	// functions
	bool hasPerk (int index)
	{
		return player_perks[index] > 0;
	}
	int getSkill (int index)
	{
		return player_skills[index];
	}
	void addRage (int amt)
	{
		if(hasPerk(PERK_Rage))
			rage += amt;
	}

	default
	{
		Species "Player";
		
		//DamageFactor "Player_Fist", 0;
		//DamageFactor "Player_Chainsaw", 0;
		//DamageFactor "Player_Pistol", 0;
		//DamageFactor "Player_Shotgun", 0;
		//DamageFactor "Player_SuperShotgun", 0;
		//DamageFactor "Player_Chaingun", 0;
		//DamageFactor "Player_RocketLauncher", 0;
		//DamageFactor "Player_PlasmaRifle", 0;
		//DamageFactor "Player_BFG", 0;
		//DamageFactor "Player_Rifle", 0;
		
		DamageFactor "Marine_Fist", 0;
		DamageFactor "Marine_Chainsaw", 0;
		DamageFactor "Marine_Pistol", 0;
		DamageFactor "Marine_Shotgun", 0;
		DamageFactor "Marine_SuperShotgun", 0;
		DamageFactor "Marine_Chaingun", 0;
		DamageFactor "Marine_RocketLauncher", 0;
		DamageFactor "Marine_PlasmaRifle", 0;
		DamageFactor "Marine_BFG", 0;
		DamageFactor "Marine_Rifle", 0;
		
		Player.DisplayName "Marine";
		
		Player.StartItem "Weapon_Pistol";
		Player.StartItem "AmmoMag_Pistol", 10;
		Player.StartItem "Ammo_Clip", 50;
		Player.StartItem "Inv_Money", 10;
	}
	
	states
	{
	Pain.Terrain_Nukage:
		PLAY G 0 ACS_NamedExecuteAlways("Pain_Nukage");
		Goto Pain;
	Pain.Terrain_Lava:
		PLAY G 0 ACS_NamedExecuteAlways("Pain_Lava");
		Goto Pain;
	}
}

class Player_Head
{
	default
	{
		Height 16;
		Radius 17;
		PainChance 255;
		Health 10000;
		
		Species "PlayerThru";
		
		+ISMONSTER
		+SHOOTABLE
		+THRUSPECIES
		+NOGRAVITY
		+LOOKALLAROUND
		+NORADIUSDMG
		+QUICKTORETALIATE
		+STANDSTILL
	}
	
	states
	{
	Spawn:
		TNT1 A -1;
		stop;
	}
}