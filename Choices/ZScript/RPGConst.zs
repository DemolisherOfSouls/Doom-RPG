//for A_Jump
const int Always	= 256;

const int SXF_TRACERTRAIL = SXF_NOCHECKPOSITION|SXF_TRANSFERPITCH|SXF_TRANSFERTRANSLATION;
const int SMF_SEEK = SMF_LOOK|SMF_PRECISE;

const int WRF_NoSecNormal = WRF_NOSECONDARY|WRF_ALLOWRELOAD;

//skills
const int SKILL_OldSchool		= 0;
const int SKILL_Underdog		= 1;
const int SKILL_BloodyMess		= 2;
const int SKILL_HomingRounds	= 3;
const int SKILL_QuickDraw		= 4;
const int SKILL_Observant		= 5;
const int SKILL_Gunner			= 6;
const int SKILL_Heavy			= 7;
const int SKILL_Finesse			= 8;
const int SKILL_PackMule		= 9;
const int SKILL_Reloader		= 10;
const int SKILL_PlasmaSpaz		= 11;
const int SKILL_FleshWound		= 12;
const int SKILL_Pyro			= 13;
const int SKILL_Fortunate		= 14;
const int SKILL_FieldMedic		= 15;

//perks
const int PERK_Craft = 0;
const int PERK_Skill = 1;
const int PERK_Skill2 = 2;
const int PERK_Rage = 3;
const int PERK_Pure = 4;
const int PERK_RageAssist = 5;
const int PERK_WeaponTech = 6;

const string WeaponClass[10][8] =
{
	{
		"Fist"
	},{
		"Chainsaw"
	},{
		"Pistol",
		"MkII"
	},{
		"Shotgun",
		"Riotgun",
		"Striker"
	},{
		"SuperShotgun"
	},{
		"Chaingun",
		"Minigun",
		"Grinder"
	},{
		"RocketLauncher"
	},{
		"PlasmaRifle",
		"LaserRifle",
		"PlasmaThrower"
	},{
		"BFG9000",
		"BFG10K"
	},{
		"Rifle",
		"AssaultRifle",
		"LightMachinegun",
		"HeavyMachinegun",
		"SubMachinegun"
	}
};

const string AmmoClass[10] =
{
	"None",
	"None",
	"Clip",
	"Shell",
	"Shell",
	"Clip",
	"Rocket",
	"Cell",
	"Cell",
	"Clip"
};