this.oathtakers_lore_event <- this.inherit("scripts/events/event", {
	m = {
		Oathtaker = null,
		Town = null,
		Replies = [],
		Results = [],
		Texts = []
	},
	function create()
	{
		this.m.ID = "event.oathtakers_lore";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Texts.resize(4);
		this.m.Texts[0] = "谈论誓言。";
		this.m.Texts[1] = "谈谈年轻的安瑟姆(Young Anselm)。";
		this.m.Texts[2] = "谈谈那些糟糕的东西。";
		this.m.Texts[3] = "我们已经说了所有需要说的话。";
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_97.png[/img]{%townname%的人民为见到%companyname%感到高兴。对于一支雇佣兵，这是一个不同寻常的接待，但是这表明人们对你们的誓言方面的业务非常敬重。%SPEECH_ON%是时候有人将荣耀和骄傲带回这片土地了。%SPEECH_OFF%一个农民说道。妇女会用鲜花和其他好处来装饰你们。当你们停下马车时，一群孩子涌上前来，想要触摸年轻的安瑟姆的头骨。%SPEECH_ON%它会给我们力量吗？还是会让我生病吗？%SPEECH_OFF%另一个孩子走上来将他挤开。%SPEECH_ON%让他告诉我们这些誓言和头骨到底是什么！前些天我们听说了忠诚者，那么你们有什么不同？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.addReplies(this.Options);
			}

		});
		this.m.Screens.push({
			ID = "B0",
			Text = "[img]gfx/ui/events/event_97.png[/img]{你把手放在安瑟姆的头上，向他们解释誓言的含义。%SPEECH_ON%每一天，当我们起床向这个世界贡献自己时，我们都在发誓。向自己、我们所爱的人、我们的邻居，甚至地球上的动物。我们向整个世界发誓。%SPEECH_OFF%一个孩子咬着一只苹果说。%SPEECH_ON%如果每个人都发誓，那你们发誓者有何不同？那岂不是我们都是发誓者了吗？%SPEECH_OFF%你微笑着点头。%SPEECH_ON%没错。我们确实都是发誓者。但是，如果我能让你们知道一个小秘密...%SPEECH_OFF%孩子们一起聚在一起，轻声互语。你继续解释。%SPEECH_ON%当你出生时，你并不知道这个世界的所有。领会誓言也是一样。我们的古神希望我们探索这个世界的全貌，而不是所有的奥秘都交于我们手中。如果所有的奥秘都轻易地呈现在我们面前，我们今天还会在这里吗？还是我们的满足感让我们一直呆在自己的角落里？我们，发誓者，正在探索古神加强我们时的极限，同时也在寻求弱点。在寻找我们的极限过程中，我们将更接近古神，并更加亲近所有人。%SPEECH_OFF%一个孩子踢了一脚泥土，问你的马车里有没有甜派。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Replies[0] = true;
				_event.addReplies(this.Options);
			}

		});
		this.m.Screens.push({
			ID = "B1",
			Text = "[img]gfx/ui/events/event_97.png[/img]{你轻敲了安瑟姆年轻时的头骨。%SPEECH_ON%安瑟姆年轻时是第一位誓言守护者，也是誓言守护者运动的开端。他最早意识到，真正的人性需要牺牲。他相信，而且是正确的，当人类最初在这个星球上游荡时，他身处痛苦之中，正是在那种状态下让他做出最伟大的进步。而现在的我们，离事情发生的那时已经很远了。现在的一切太过美好。%SPEECH_OFF%其中一个孩子刮掉了一个黑色的疙瘩，然后把它弹到另一个孩子的脸上。另一个孩子擦掉它，然后挤出一个脓包，把脓液涂在另一个孩子的身上。当他们争吵的时候，你继续前进。%SPEECH_ON%安瑟姆年轻时认识到这个世界需要回到一种牺牲的生活方式，放弃享受的元素，锤炼自己在苦难的磨石中。当然，这让安瑟姆年轻时招来了很多敌人。%SPEECH_OFF%其中一个孩子抬起头问安瑟姆年轻时是怎么死的。你微笑着说那是另一个时候的故事。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Replies[1] = true;
				_event.addReplies(this.Options);
			}

		});
		this.m.Screens.push({
			ID = "B2",
			Text = "[img]gfx/ui/events/event_97.png[/img]{其中一个孩子开口说道。%SPEECH_ON%几天前，我们镇上也有一群像你们一样的男人，他们名叫‘誓言使者’。他们是你们兄弟吗？%SPEECH_OFF%当你想回答时，%oathtaker%插话了。%SPEECH_ON%誓言使者是亵渎者！他们是异教徒，不是守护誓言的人，而是违背誓言的人！他们偷走了年轻安瑟姆的下颌骨，我们发誓要杀死每一个誓言使者，直到找回来。%SPEECH_OFF%孩子说，誓言使者说要从你这里得到骷髅，因为你们是真正的异教徒。%oathtaker%的愤怒达到了顶点。%SPEECH_ON%誓言使者说了很多废话！他们是对外兜售谎言、无聊和歇斯底里的商贩，以及残忍歧视他们的商品的人！%SPEECH_OFF%你盯着誓言使者一会儿，然后在他的肩膀上轻拍一下，告诉他也许他应该去数一下库存，冷静一下。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Replies[2] = true;
				_event.addReplies(this.Options);
			}

		});
	}

	function addReplies( _to )
	{
		local n = 0;

		for( local i = 0; i < 3; i = ++i )
		{
			if (!this.m.Replies[i])
			{
				local result = this.m.Results[i];
				_to.push({
					Text = this.m.Texts[i],
					function getResult( _event )
					{
						return result;
					}

				});
				n = ++n;

				if (n >= 4)
				{
					break;
				}

				  // [034]  OP_CLOSE          0      4    0    0
			}
		}

		if (n == 0)
		{
			_to.push({
				Text = this.m.Texts[3],
				function getResult( _event )
				{
					return 0;
				}

			});
		}
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.paladins")
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() || t.isMilitary())
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
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

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local haveSkull = false;

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.paladin")
			{
				candidates.push(bro);
			}

			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && (item.getID() == "accessory.oathtaker_skull_01" || item.getID() == "accessory.oathtaker_skull_02"))
			{
				haveSkull = true;
			}
		}

		if (!haveSkull)
		{
			local stash = this.World.Assets.getStash().getItems();

			foreach( item in stash )
			{
				if (item != null && (item.getID() == "accessory.oathtaker_skull_01" || item.getID() == "accessory.oathtaker_skull_02"))
				{
					haveSkull = true;
					break;
				}
			}
		}

		if (!haveSkull)
		{
			return;
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Oathtaker = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Town = town;
		this.m.Score = 25;
	}

	function onPrepare()
	{
		this.m.Replies = [];
		this.m.Replies.resize(3, false);
		this.m.Results = [];
		this.m.Results.resize(3, "");

		for( local i = 0; i < 3; i = ++i )
		{
			this.m.Results[i] = "B" + i;
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"oathtaker",
			this.m.Oathtaker.getName()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Oathtaker = null;
		this.m.Town = null;
	}

});

