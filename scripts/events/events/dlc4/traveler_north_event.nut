this.traveler_north_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.traveler_north";
		this.m.Title = "在路上…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{你在冰窟旁边遇见一个人。 他身旁有一根钓竿，尽管环境恶劣，他对你还是很热情。%SPEECH_ON%想聊聊吗，旅行者？ 你看起来不像本地人。%SPEECH_OFF% | 一个披着熊皮的人正在凿冰。 他凿的冰块掉恶狠狠地掉在水面上，就像他看你的眼神一样。%SPEECH_ON%来吧，别紧张聊一会。我没恶意。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "今晚加入我们的篝火晚会吧。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "不，你离远点。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_26.png[/img]{你问他北方是否经历过毁灭性战争。他耸耸肩。%SPEECH_ON%嗯，我们之间有分歧。 又是这样又是那样。 但一个世纪以前，由勇士组织起来的一支战队打败了一群亡灵。 噢呀，你的眼神告诉了我你的无知。 如果他们被打败了，很有可能那些亡灵就会涌向南方杀光你们。 不用客气。我敢打赌僵尸不是去教你读南方花哨故事的。%SPEECH_OFF% | 这人对着钓竿哼了一声点头。%SPEECH_ON%别人说这下面有一条大鱼。 没攻击性，但是大的超乎想象。 我不敢说我亲眼见过，但是有一次，一个巨大的影子从我脚下穿过，就在那边，它游来游去，感觉时间停止了。 然后它就消失了。%SPEECH_OFF%你问他是怎么知道它没攻击性呢。他耸耸肩。%SPEECH_ON%因为它什么也没做，只是从这到那然后继续游。%SPEECH_OFF% | 这个人试了试钓竿，接着他蹲下来。 他在冰上点头示意。%SPEECH_ON%白熊会穿过那些地方。 你要小心点。 一点火星子就能把熊挡开，不然你就把鱼扔掉，撒腿开溜。 我认识一个被白熊吃掉的人。 听说熊从他的腿开始吃，对他的抓喊尖叫毫不在乎。 我宁愿割破自己的喉咙，也不愿让那些畜生抓住我。%SPEECH_OFF% | 这个人很友好，坐在钓竿旁很放松地跟大家伙说话聊天。%SPEECH_ON%我离南方很近，知道你们觉得我们是野蛮人。 这很好，但很重要的一点是，我们的资源很少。 非常少。少的可怜。 不管怎样都要凑合活下去。%SPEECH_OFF%你说北方人频繁来南方只是为了抢劫。那人耸耸肩。%SPEECH_ON%你们把战争送到北方，让我们感受来自南方的正义。 看起来不错。没人可以为所欲为而不受惩罚。 万物守恒。%SPEECH_OFF% | 当你坐在这家伙旁边时，他抓住一条鱼并把它拉上来。 他用带着皮手套的手抓住它，然后猛击鱼的头，直到鱼停止扑腾。 他边说边把鱼的内脏掏掉然后撒上盐。%SPEECH_ON%一些北方人想出一个办法来驯服这些巨人，我想你们称呼他们为释放者。  别问我怎么做的。 每当我听到一个巨人去什么地方，它所做的就只是杀掉或吃掉路上的任何牲畜。%SPEECH_OFF% | 这个人哼了一声，看了看他的钓竿，没有鱼上钩他又叹了口气。%SPEECH_ON%我几年前去过南方。 我也在那待了几年。 这就是我了解你口味的原因。 我在那的时候尝了你们称之为蔬菜的东西。 真够恶心的，你们想知道我们是怎么长得这么壮的？ 我告诉你，我们不能种那该死的蔬菜。 我们只有把活着的东西杀死吃掉，才能让我们的心脏强壮地成长。%SPEECH_OFF% | 友好的北方渔民给你讲述了部落的三三两两。%SPEECH_ON%我想说的是，我们只由强者统治，但强者的健康和体质决定了一切。 当他老了，他就失去了一切。 当他老了，他就输了。 于是，新的强者掌权，部落的成功与历史随之改写。 我的确有点羡慕南方人有更大的使命感，也羡慕你们有能力隐藏自己的权力，使自己与他人保持一定距离，这样其他人除了挥剑还需要做的更多才能夺走他的权力。 说句实话，就在这，离我的同胞越远越好。 一般情况下我绝不会说这些，你明白吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们需要再来一杯。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (currentTile.SquareCoords.Y < this.World.getMapSize().Y * 0.8)
		{
			return;
		}

		this.m.Score = 15;
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

});

