this.oathtaker_joins_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.oathtaker_joins";
		this.m.Title = "在途中…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_180.png[/img]{一个身穿盔甲的男子走向队伍。他看起来很平凡，但是一旦他张开嘴巴，你会觉得他很不同。%SPEECH_ON%各位听着，我是一位自豪的守誓者！现在，我看到你们也似乎很重视做正确的事情。这让我相信，你们也是守誓者。所以！我只有一个问题：你项链上挂着的那颗骷髅，它的名字是什么？如果是我寻找的那个人，那么你们就会得到我的帮助。%SPEECH_OFF% | 现在，穿盔甲的人在路上已经不再是一个罕见的景象，但这个人有一定的气派和戏剧性，这吸引了人们的眼球，正如他自信地走向你一样。%SPEECH_ON%当我在当地的酒吧狂欢的时候，得知一群守誓者正在这些土地上穿行。现在，要不这是一些坟场的诡计挂在你的脖子上，要不就是......你告诉我。给我那个头骨的正确名字，我就马上加入你们。%SPEECH_OFF% | 你看到一个穿着盔甲的男人，他站在路中间，好像是想用自己的命去雇佣兵，或者想为了一枚硬币拼上自己的脑袋。当你走近时，他招手示意你停下来。%SPEECH_ON%啊，正是我在找的人。你们是与队长同行的Oathtakers吗？我想加入你们的队伍。走上那条……%SPEECH_OFF%他停了一下，指向队伍中的那颗头骨。哦，他是指…… | 一个穿着盔甲的男子匆匆走到路上。你放手搭在剑柄上，但他仅仅行了一个行刑者会行的屈膝致敬。%SPEECH_ON%我曾经向古老的神祈求坚定我的美德，引领我走上正路。陌生人，那确实是他的徽记挂在你的脖子上吗？如果是，我愿意立刻加入你的队伍并为你们的誓言发誓。请告诉我，那齿不全的颅骨是我们亲爱的...我们的...%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "年轻的安瑟姆.(Young Anselm)",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "Hugo.",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"paladin_background"
				]);
				local dudeItems = _event.m.Dude.getItems();

				if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Head) != null && dudeItems.getItemAtSlot(this.Const.ItemSlot.Head).getID() == "armor.head.adorned_full_helm")
				{
					dudeItems.unequip(dudeItems.getItemAtSlot(this.Const.ItemSlot.Head));
					dudeItems.equip(this.new("scripts/items/helmets/adorned_closed_flat_top_with_mail"));
				}

				if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Body) != null && dudeItems.getItemAtSlot(this.Const.ItemSlot.Body).getID() == "armor.body.adorned_heavy_mail_hauberk")
				{
					dudeItems.unequip(dudeItems.getItemAtSlot(this.Const.ItemSlot.Body));
					dudeItems.equip(this.new("scripts/items/armor/adorned_warriors_armor"));
				}

				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_180.png[/img]{那人跪下，低头不语。%SPEECH_ON%年轻的安瑟姆真的引导我来到这里！我要和你们一起走上这条道路，守护誓言的人们！%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "欢迎加入。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_180.png[/img]{那个人叹息了一声。%SPEECH_ON%啊，我现在明白了。这个世界上Hugo太多了，让我不惊讶又一个Hugo出现在这样一个沉闷的头骨周围，但我不知道为什么你要像这样携带它。%SPEECH_OFF% | %SPEECH_ON%Hugo。%SPEECH_OFF%那人说道。%SPEECH_ON%又是一个该死的Hugo，对吧？这里有多少个Hugo啊？我碰到的每个人都是Hugo。%SPEECH_OFF% 他转身走开，嘟囔着不满普通人和他们毫无创意的命名方案。 | 那人叹了口气。%SPEECH_ON%Hugo啊？好吧。那就下次再见了。%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "祝你好运。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
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

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		if (this.World.getTime().Days <= 30)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local numOathtakers = 0;
		local haveSkull = false;

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.paladin")
			{
				numOathtakers++;
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

		local comebackBonus = numOathtakers < 2 ? 8 : 0;
		this.m.Score = 2 + comebackBonus;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

