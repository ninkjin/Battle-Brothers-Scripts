this.helped_caravan_event <- this.inherit("scripts/events/event", {
	m = {
		LastCombatID = 0
	},
	function create()
	{
		this.m.ID = "event.helped_caravan";
		this.m.Title = "战斗之后…";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_60.png[/img]{商队的头领来到你跟前，感谢你救了他。 当然，他提供的远远超过语言文字：赠送了一些物品，其中一些是能派上用场的。 | %SPEECH_ON%谢谢你，旅行者，谢谢你！%SPEECH_OFF%商队的商人头领紧握双手，上下摇动着，好像要感谢你和古老的神一样。 他还用货品感谢你，给 %companyname% 提供各种各样直接从载重货车上拿下来的奖励。 | 在这个世界上，陌生人能彼此友善的相遇是稀有的，但即使是一个狡猾的商人也明白，如果他从彻底消失中悲拯救出来，那么他最好回报他的救主。 商队通过奖励你一些货物来减轻他的负载。 | 如果你没有来，这支商队肯定会遭殃。 这是对你及时的“服务”即兴的奖励。 | %SPEECH_ON%噢，以一种更高的力量，这种力量对你来说可能存在，也可能不存在，但不管它是什么，它现在支配着我！%SPEECH_OFF%商人显然处于震惊状态。 像任何一个不安的小贩一样，他会立刻去做他知道该怎么做的事情。%SPEECH_ON%瞧，我们有货可提供，这些怎么样？ 接受我们感激的谢礼，免费的。%SPEECH_OFF% | 尽管战斗已经结束，被拯救的商人们的歇斯底里还是和刚刚过去的大屠杀一样响亮。%SPEECH_ON%佣兵，佣兵！我们的救主！%SPEECH_OFF%突然间，你发现商人们都在感谢你的救援。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很高兴能帮上忙。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local n = 1;

				if (this.World.Statistics.getFlags().getAsInt("LastCombatKills") > this.Math.rand(11, 14))
				{
					n = ++n;
				}

				for( local i = 0; i < n; i = ++i )
				{
					local item = this.new("scripts/items/" + this.World.Statistics.getFlags().get("LastCombatSavedCaravanProduce"));
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "你获得了" + item.getName()
					});
				}
			}

		});
	}

	function isValid()
	{
		if (this.World.Statistics.getFlags().get("LastCombatSavedCaravan") && this.World.Statistics.getFlags().get("LastCombatWasOngoingBattle") && this.World.Statistics.getFlags().get("LastCombatID") > this.m.LastCombatID && this.World.Statistics.getFlags().getAsInt("LastCombatKills") >= this.Math.rand(4, 6))
		{
			this.m.LastCombatID = this.World.Statistics.getFlags().getAsInt("LastCombatID");
			return true;
		}

		return false;
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

	function onSerialize( _out )
	{
		this.event.onSerialize(_out);
		_out.writeU32(this.m.LastCombatID);
	}

	function onDeserialize( _in )
	{
		this.event.onDeserialize(_in);

		if (_in.getMetaData().getVersion() >= 54)
		{
			this.m.LastCombatID = _in.readU32();
		}
	}

});

