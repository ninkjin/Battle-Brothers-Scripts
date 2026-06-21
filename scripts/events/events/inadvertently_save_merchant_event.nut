this.inadvertently_save_merchant_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null
	},
	function create()
	{
		this.m.ID = "event.inadvertently_save_merchant";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 130.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%townImage%你带着几个佣兵在 %townname% 四处游荡，你转过一个街角，就会发现一个富商被盗贼和土匪包围着。 他们环顾四周，怒目圆睁。 其中一个在击打商人的面部。%SPEECH_ON%好吧，下次我们会抓到你的，你这个混蛋！%SPEECH_OFF%歹徒们很快离开了。 过了一会儿，商人的重装护卫出现了。 在包扎伤口时，商人大声训斥他们。%SPEECH_ON%我不是给过你们这些欠骂的混蛋很多钱了么？ 我第二次遇到麻烦了，你们哪儿去了？ 看看这个人，这才是我应该付钱的人！ 嘿，给你添麻烦了，陌生人。%SPEECH_OFF%商人丢给你一袋克朗，作为“麻烦”你的报酬，尽管你所做的一切只是拐了个弯，然后碰巧赶上了。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "好吧，很好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(25);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]25[/color] 克朗"
				});
			}

		});
	}

	function onUpdateScore()
	{
		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getSize() <= 1 || t.isMilitary())
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 4 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		this.m.Town = town;
		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Town = null;
	}

});

