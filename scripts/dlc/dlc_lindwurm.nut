local gt = this.getroottable();

if (!("DLC" in gt.Const))
{
	gt.Const.DLC <- {};
	gt.Const.DLC.Mask <- 0;
}

if (!("Lindwurm" in gt.Const.DLC) || !this.Const.DLC.Lindwurm)
{
	this.Const.DLC.Lindwurm <- this.hasDLC(732460);

	if (this.Const.DLC.Lindwurm)
	{
		this.Const.DLC.Mask = this.Const.DLC.Mask | 2;
		this.Const.PlayerBanners.push("banner_22");
		this.Const.LoadingScreens.push("ui/screens/loading_screen_05.jpg");
	}
}

