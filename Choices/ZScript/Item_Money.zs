class Item_Money : Item
{
  int value;
  
  property Value: value;
  
  default
  {
    Item_Money.Value 1;
  }

	void I_Money(int amt)
	{
		let p = RPGPlayer(self.owner)
		
		if(p == null)
			return;
		
		p.moneyfound += amt;
		p.moneyqueue += amt;
	}
	
	states
	{
	Spawn:
		GOLD A 5 Bright;
		GOLD A 15;
		loop;
	Pickup:
		TNT1 A 0 I_Money(value);
		stop;
	}
}

class Item_Money10 : Item_Money
{
  default
  {
    Item_Money.Value 10;
  }

	states
	{
	Spawn:
		GOLD B 5 Bright;
		GOLD B 15;
		loop;
	}
}

class Item_Money25 : Item_Money
{
  default
  {
    Item_Money.Value 25;
  }

	states
	{
	Spawn:
		GOLD C 5 Bright;
		GOLD C 15;
		loop;
	}
}