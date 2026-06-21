this.oathbreaker_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.oathbreaker";
		this.m.Title = "在路上…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_180.png[/img]{你发现一个身处消沉状态的人：一方面，他身披华丽的盔甲，看上去像是一个坐在马背上，准备参加盛大锦标赛的骑士。另一方面，他躺在地上，腿交叉晃动，陷入了醉酒的迷糊状态，他的手臂伸出去，仿佛搂着朋友的肩膀，但实际上只能感受到泥土的慰藉。%SPEECH_ON%我请求你，旅行者，购买我的盔甲和武器，留下适合它们的价值，这样我就可以用另一种方式来寻求救赎，因为战斗对我已经没有意义了，我更愿意花钱来向年轻的安塞姆示好，而不是用剑来解决问题，但愿旧神会惩罚我说出这些话，但我还是要说！%SPEECH_OFF% 他似乎在以9000克朗的价格出售他的武器和盔甲。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们将以9,000克朗的价格购买这套盔甲。",
					function getResult( _event )
					{
						return "BuyArmor";
					}

				},
				{
					Text = "不感兴趣。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (this.World.Assets.getOrigin().getID() == "scenario.paladins")
				{
					this.Options.push({
						Text = "年轻的安瑟姆(Anselm)有其他计划给你。加入我们！",
						function getResult( _event )
						{
							return "Oathtaker";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "BuyArmor",
			Text = "[img]gfx/ui/events/event_180.png[/img]{你蹲下来，手里拿着克朗的钱袋。%SPEECH_ON%脱下来。%SPEECH_OFF%男人点点头，开始脱掉盔甲，蠕动身体，不时地嗅嗅。他将所有东西都拿了出来，还有盔甲。你把它们拿走放进了库存中，然后按约定给出了钱。他用手指紧紧握住钱袋，像蜘蛛一样卷起猎物，醉醺醺的眼睛左右扫视。他起身退开。你有一种感觉，他用那笔钱得不到他所期待的救赎。%randombrother%向你的肩膀上拍了拍。%SPEECH_ON%别想他了，队长。在这个世界上有些人你就是不想成为遗忘他们的最后一个人，明白吗?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "旅途平安。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item;
				local stash = this.World.Assets.getStash();
				local weapons = [
					"weapons/arming_sword",
					"weapons/military_pick",
					"weapons/hand_axe",
					"weapons/pike",
					"weapons/warbrand"
				];
				item = this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
				item.setCondition(item.getConditionMax() / 3 - 1);
				stash.add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/armor/adorned_heavy_mail_hauberk");
				item.setCondition(item.getConditionMax() / 3 - 1);
				stash.add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/helmets/adorned_full_helm");
				item.setCondition(item.getConditionMax() / 3 - 1);
				stash.add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				this.World.Assets.addMoney(-9000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]9,000[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Oathtaker",
			Text = "[img]gfx/ui/events/event_183.png[/img]{不是施舍，而是伸出援助之手。%SPEECH_ON%先生，年轻的安瑟姆深知守誓绝非易事。犯错是人之常情，而活着就要犯错，犯错就是活着。你认为蹲在泥巴里是一种错误吗？你认为你的失败能用金钱来弥补吗？%SPEECH_OFF%这个人抬起头来。他问你是否也认识年轻的安瑟姆。他仍然没有握住你的手，所以你握住他的手，拉他站起来。%SPEECH_ON%守誓者，你认为是谁派我来的呢？%SPEECH_OFF%这个人愣了一秒钟，惊异地望着你。然后他露出了灿烂的微笑，热情地给了你一个坚定的拥抱，把你和战团一起拥抱在一起。无论守誓者在世界的哪个角落，他都不会孤单，这是安瑟姆年轻时的第一条信息。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎加入!",
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
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"paladin_background"
				]);
				_event.m.Dude.setTitle("誓言破坏者");
				_event.m.Dude.getBackground().m.RawDescription = "像许多人一样，%name% 在肮脏的环境中被找到。他嘴里含着麦酒，耳朵里充满污垢，身上至少有一些尿和屎的痕迹。但他的内心是一个信誓旦旦的守誓者，而且在年轻的安瑟姆的恩典下，肯定是一个非同寻常的情况将他带回信仰中。当然，他仍然会将啤酒和信仰联系在一起，但偶尔必须允许一个人有他的恶习，尤其是如果这个人对杀死队长充满兴趣。";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.m.PerkPoints = 0;
				_event.m.Dude.m.LevelUps = 0;
				_event.m.Dude.m.Level = 1;
				_event.m.Dude.m.XP = this.Const.LevelXP[_event.m.Dude.m.Level - 1];
				local trait = this.new("scripts/skills/traits/drunkard_trait");
				_event.m.Dude.getSkills().add(trait);
				local dudeItems = _event.m.Dude.getItems();

				if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
				{
					dudeItems.getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}

				if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
				{
					dudeItems.getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
				}

				if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Head) != null)
				{
					dudeItems.getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
				}

				if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Body) != null)
				{
					dudeItems.getItemAtSlot(this.Const.ItemSlot.Body).removeSelf();
				}

				local weapons = [
					"weapons/arming_sword",
					"weapons/military_pick",
					"weapons/hand_axe",
					"weapons/pike",
					"weapons/warbrand"
				];
				local item = this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
				item.setCondition(item.getConditionMax() / 3 - 1);
				dudeItems.equip(item);
				item = this.new("scripts/items/helmets/adorned_full_helm");
				item.setCondition(item.getConditionMax() / 3 - 1);
				dudeItems.equip(item);
				item = this.new("scripts/items/armor/adorned_heavy_mail_hauberk");
				item.setCondition(item.getConditionMax() / 3 - 1);
				dudeItems.equip(item);
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

		if (this.World.Assets.getMoney() < 10500)
		{
			return;
		}

		if (this.World.Assets.getStash().getNumberOfEmptySlots() < 3)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.paladins" && this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		this.m.Score = 5;
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

