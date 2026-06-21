this.defeat_undead_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.defeat_undead";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "亡灵正在大地上崛起并杀死和吞噬它们看到的一切。\n我们必须结束这一切，否则很快我们所知的世界将不复存在！";
		this.m.UIText = "击败亡灵天灾";
		this.m.TooltipText = "击败亡灵天灾！ 每一份反对他们的合同，每一支被摧毁的军队或地点，都将使你们离拯救人类世界更近。";
		this.m.SuccessText = "[img]gfx/ui/events/event_73.png[/img]穿着破布蹒跚而行的尸体。 很快，每个村庄的墓地都开始把他们吐出来，但这只是开始。 古代军团觉醒了。 他们从不疲倦，从不畏惧，像一台冰冷的机器一样前进，永远向前。 他们曾经征服过已知的世界，如果不是因为一群紧密团结的雇佣军，他们很可能再次征服这个世界。%SPEECH_ON%行军的死人，穿着外国盔甲行走的骨头，不是来自这个世界的东西…我从没想过我会看到这样的恐怖。但是我们赢了！%SPEECH_OFF%%bravest_brother% 高举武器，好像要发出冲锋的信号。%SPEECH_ON%%companyname% 甚至战胜了这个敌人！ 现在谁还敢对抗我们？%SPEECH_OFF%谁，可以？";
		this.m.SuccessButtonText = "人类的世界得救了。暂时的。";
	}

	function getUIText()
	{
		local f = this.World.FactionManager.getGreaterEvil().Strength / this.Const.Factions.GreaterEvilStartStrength;
		local text;

		if (f >= 0.95)
		{
			text = "困难重重";
		}
		else if (f >= 0.5)
		{
			text = "悬而未决";
		}
		else if (f >= 0.25)
		{
			text = "看到曙光";
		}
		else
		{
			text = "胜利在望";
		}

		return this.m.UIText + " (" + text + ")";
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isUndeadScourge())
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 1500)
		{
			return;
		}

		this.m.Score = 10;
	}

	function onCheckSuccess()
	{
		if (this.World.FactionManager.getGreaterEvil().Type == 0 && this.World.FactionManager.getGreaterEvil().LastType == 3)
		{
			return true;
		}

		this.World.Ambitions.updateUI();
		return false;
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
	}

});

