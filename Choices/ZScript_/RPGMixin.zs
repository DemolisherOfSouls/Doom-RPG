mixin class Jumper
{
	action state Jump(statelabel label)
	{
		return ResolveState(label);
	}
}