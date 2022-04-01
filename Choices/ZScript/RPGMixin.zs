const NoParam = "@@@@@";

mixin class Mix_Jump
{
	action state Jump(string label, string label2 = NoParam)
	{
    if(label2 == NoParam || Random(1, 2) == 1)
      return state(label);
    else
      return state(label2);
	}
}

mixin class Mix_ACS
{
	void ACS_ExecInt(string s, int a)
	{
		ACS_NamedExecuteAlways(s, 0, a);
	}

  void ACS_ExecStr(string s, string a)
  {
    ACS_NamedExecuteAlways(s, 0, a);
  }

  void ACS_Exec(string s)
  {
    ACS_NamedExecuteAlways(s, 0);
  }
}

mixin class Mix_AI
{
  bool painjump;
  bool awake;
  bool alert;

  int deathanim;
  string deathtype;

  mixin Mix_Jump;
  mixin Mix_ACS;

  void E_See() {
    awake = true;
    alert = true;
    if(painjump)
      Jump("See.NoDelay");
    Jump("See.Real");
  }

  void E_RaiseFinish(string next = "See")
  {
    painjump = false;
    Jump(next);
  }

  void E_Pain()
  {
    painjump = true;
		Jump("Pain.Actual");
  }
  action void EZ_FireBullet(string type, int bullets = 1)
  {
    for(int i = 0; i< bullets; i++)
      A_CustomMissile("EnemyProj_"..type, 32, 0, Acc(), CMF_STANDARD, Acc());
  }
  void E_Setup() {
		//ACS_Exec("EnemySetup")
	}
	state E_Death(string type, int anims = 1) {
		if(RPGPlayer(target))
		{
			ACS_ExecInt("PlayerExp", rewardxp);
			ACS_ExecInt("PlayerRenown", rewardrenown);
      ACS_ExecStr("PlayerRage", type);
		}
		else if(Enemy(target))
		{
			ACS_ExecInt("EnemyRenown", rewardrenown);
			ACS_ExecInt("EnemyExp", rewardxp);
		}
		else if(Ally(target))
		{
			ACS_ExecInt("AllyRenown", rewardrenown);
			ACS_ExecInt("AllyExp", rewardxp);
		}

    deathanim = Random(1, anims);
    deathtype = type;

    if(anims > 1)
      return state(type..".Anim"..r);

		return state(type..".Stage1");
	}
	void E_BossCheck() {
		if(BOSSDEATH) A_BossDeath;
	}
}

mixin class Mix_Weapon
{
  string GetWeaponAmmoClass(int slot, int var) {
		//exceptions go here

		return "Ammo_"..AmmoClass[slot];
	}
	string GetAmmoMagClass (int slot, int var) {
		return "AmmoMag_"..WeaponClass[slot][var-1];
	}
	string GetWeaponClass(int slot) {
		int var = RPGPlayer(owner).cur_weapon[slot];
		return "Weapon_"..WeaponClass[slot][var-1];
	}
	bool HasAmmo(int slot, int var) {
		return CheckInventory(GetWeaponAmmoClass(type, var)) + CheckInventory(GetAmmoMagClass(type, var)) > 0;
	}
	bool TryWeapon(int slot) {
		let player = RPGPlayer(self.player);

		if(player == NULL)
			return false;

		string w = GetWeaponClass(slot)
		int var = player.cur_weapon[slot];

		let weap = Weapon(player.FindInventory(w));

		if( CheckInventory(w) && HasAmmo(slot, var) && player.ReadyWeapon != weap)
			player.PendingWeapon = weap;
	}
	void W_RaiseWeapon() {
		int skill = RPGPlayer(owner).GetSkill(SKILL_QuickDraw);
		A_Raise(6 * (skill + 1));
	}
	void W_LowerWeapon() {
		int skill = RPGPlayer(owner).GetSkill(SKILL_QuickDraw);
		A_Lower(6 * (skill + 1))
	}
	void W_ChangeWeapon() {
		for(int w = 0; w < 10; w++)
		{
			int type = RPGPlayer(owner).weaponorder[w];

			if(TryWeapon(type))
				return;
		}
	}
}

mixin class Mix_Pistol
{
  void FirePistol (bool offhand)
  {

  }

  void EmptyPistol (bool offhand)
  {
    //GiveAmmo("AmmoMag_Pistol", 1)
    //GiveInventory(Class<Inventory> type, int amount, bool givecheat = false)
    //TakeInventory("Ammo_Clip", 1, , true)
		A_TakeInventory("Ammo_Clip", 1, TIF_NOTAKEINFINITE)
		//A_JumpIfInventory("AmmoMag_Pistol", 0, "LightDone")
		A_JumpIfInventory("Ammo_Clip", 1, "Reload.Process")
		A_PlayWeaponSound("Weapon/PistolEmpty")
  }
}

mixin class Mix_Imp
{
  void E_ImpAttack()
  {
    A_CustomComboAttack("EnemyProj_ImpBall", 32, 3 * random(1, 8), "imp/melee", "Enemy_ImpMelee", true)
  }
}