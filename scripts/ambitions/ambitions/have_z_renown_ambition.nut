this.have_z_renown_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.have_z_renown";
		this.m.Duration = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "历史上很少有传奇雇佣兵战队。\n我们即将让我们的名字成为不朽，并被列入其中！";
		this.m.UIText = "达到“无敌”声望";
		this.m.TooltipText = "以“无敌”（8000声望）闻名在历史上留下你的印记。 你可以通过完成合同和赢得战斗来提高自己的声望。";
		this.m.SuccessText = "[img]gfx/ui/events/event_82.png[/img]血流成河，一百座被烧毁的堡垒，一万只肥壮的乌鸦在你的背后欢宴，你的战队的辉煌故事将永垂不朽。 在这个已知世界的每一个角落，“%companyname%”这个名字被人们以胜利的呼喊和肃然起敬的声音提起。 父亲们用你们最勇敢的人的名字给他们的儿子取名，这些孩子们长大后会模仿你们参加过的许多著名战役。\n\n你现在名声大噪，去任何比小村庄还大的地方都会带来不便。 无论你旅行到哪里，你都日夜忙碌。 符合条件的少女们为了争夺男人们的注意力，最终以拳打脚踢告终。 店主们认为你非常富有，他们会随时带着他们的商品来拜访你。 最糟糕的是，这片土地上的每一个吹牛者都想挑战你的人，而民兵正等着结果，希望在街上打架的简单罚款会被提高到血债。\n\n但你实现了你的目标，即使结果与你预期的不完全一样。 不管你的命运如何，%companyname% 已经在世界历史上成为不朽。";
		this.m.SuccessButtonText = "%companyname% 的名字将永垂不朽！";
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 60)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() <= 4000 || this.World.Assets.getBusinessReputation() >= 7800)
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.Assets.getBusinessReputation() >= 8000)
		{
			return true;
		}

		return false;
	}

	function onReward()
	{
		if (!this.World.Assets.getOrigin().isFixedLook())
		{
			if (this.World.Assets.getOrigin().getID() == "scenario.southern_quickstart")
			{
				this.World.Assets.updateLook(15);
			}
			else
			{
				this.World.Assets.updateLook(3);
			}

			this.m.SuccessList.push({
				id = 10,
				icon = "ui/icons/special.png",
				text = "你在世界地图上的形象已经更新了"
			});
		}
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

