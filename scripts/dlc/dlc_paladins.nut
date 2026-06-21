local gt = this.getroottable();

if (!("DLC" in gt.Const))
{
	gt.Const.DLC <- {};
	gt.Const.DLC.Mask <- 0;
}

if (!("Paladins" in gt.Const.DLC) || !this.Const.DLC.Paladins)
{
	this.Const.DLC.Paladins <- this.hasDLC(1910050) && this.Const.Serialization.Version >= 64;

	if (this.Const.DLC.Paladins)
	{
		this.Const.DLC.Mask = this.Const.DLC.Mask | 256;
		this.Const.LoadingScreens.push("ui/screens/loading_screen_11.jpg");
		local tips = [
			"使用“解剖学家”起源，击败新的敌人将授予药剂，可以改变你的队员，使他们获得特殊能力。",
			"选择“宣誓者”出身，你将选择誓言而非抱负，以获得特殊的福利和负担。"
		];
		this.Const.TipOfTheDay.extend(tips);
		this.Const.PlayerBanners.push("banner_32");
		this.Const.PlayerBanners.push("banner_33");
	}
}

