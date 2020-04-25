mixin class Mix_Jump
{
	action state Jump(string label)
	{
		return state(label);
	}
}