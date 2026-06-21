this.undead_boy_who_cried_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null,
		Refusals = 0
	},
	function create()
	{
		this.m.ID = "event.undead_boy_who_cried";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 140.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_97.png[/img]{当你们拜访 %townname% 时，一个小男孩叫你，他哭着说亡灵要来吃他的家人。 你问他有多少只，他说只有一只，但那是致命的畜生。%SPEECH_ON%我想它是我以前的保姆。 她从不疼爱我。请，帮个忙！%SPEECH_OFF%如果只是一只亡灵，应该不会太麻烦，你可以自己解决。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "带我们去你的房子，孩子。",
					function getResult( _event )
					{
						return "Accept1A";
					}

				},
				{
					Text = "你得靠你自己，孩子。",
					function getResult( _event )
					{
						++_event.m.Refusals;
						return "Refuse" + _event.m.Refusals;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Accept1A",
			Text = "[img]gfx/ui/events/event_97.png[/img]{你冲进男孩的家，又冲出门去。 你发现他的家人正在布置餐桌。 他们看着你，好像你是一个疯子，有个人问你他们是否可以帮忙。 男孩笑得很厉害，他紧紧捂着肚子在地上打滚。 母亲揪着他的耳朵。 她道歉，并把他孩子推给他的父亲一顿暴揍。%SPEECH_ON%对不起，佣兵，我们不是有意找麻烦，但这孩子，他有时候真是任性。%SPEECH_OFF%不能跟孩子一般见识，虽然他确实是个你刚遇到的屎孩子。 你掉头返回了集市。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很有趣。",
					function getResult( _event )
					{
						return "Accept1B";
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(1);
			}

		});
		this.m.Screens.push({
			ID = "Accept1B",
			Text = "[img]gfx/ui/events/event_01.png[/img]{当你仔细考察一个商人的货物时，一个小声音在对你大声喊叫。 转过身来，你又看到那个该死的孩子。 他又一次指向家。%SPEECH_ON%佣兵！那里有一只！我是认真的！你得帮帮我！%SPEECH_OFF%你问他为什么不去打扰一个城镇守卫，他说没有人信任他。%SPEECH_ON%我已经说过太多次谎话去骗他们！ 请帮帮忙！我的家人要被屠杀了%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，好吧，我们去。",
					function getResult( _event )
					{
						return "Accept2A";
					}

				},
				{
					Text = "你得靠你自己，孩子。",
					function getResult( _event )
					{
						++_event.m.Refusals;
						return "Refuse" + _event.m.Refusals;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Accept2A",
			Text = "[img]gfx/ui/events/event_97.png[/img]{一直叹气，你告诉这个男孩带路。 无比震惊的是，你又被愚弄了。 那个男孩忍不住哈哈大笑，尽管他父亲狠狠抽了他一顿。 那个母亲，再一次地，道歉并送上一小包礼物，为给你添麻烦和“看望”他们。 你掉头返回了集市。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这样息事宁人吧。",
					function getResult( _event )
					{
						return "Accept2B";
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(1);
				local item = this.new("scripts/items/supplies/roots_and_berries_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Accept2B",
			Text = "[img]gfx/ui/events/event_01.png[/img]{当你回到集市的时候，你已经预料到那个野蛮的小骗子会来了。 当他拉你的手时，你假装震惊。 过了一会儿，你发现自己正好打在他的下巴上。 当然，这对那些不明真相的人来说是不好的，所以你要保持镇定。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "哎呀，我好奇这到底是怎么回事。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "Accept3A" : "Accept3B";
					}

				},
				{
					Text = "在你挨揍之前赶紧滚，孩子！",
					function getResult( _event )
					{
						++_event.m.Refusals;
						return "Refuse" + _event.m.Refusals;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Accept3A",
			Text = "[img]gfx/ui/events/event_97.png[/img]{小心翼翼地，你回到男孩的家。 当你打开门看到一家人正在玩纸牌的时候，你转身抓住孩子的喉咙把他往墙上猛撞。 你把门踢上，这样没人能看见。 他父亲起身告诉你说，这是他儿子，你在粗暴对待他。 你告诉父亲把打他儿子的鞭子给你。 小心翼翼地，他照做了。 这一次，你自己惩罚这个孩子，当你完成的时候，他浑身是伤，哭得一塌糊涂。\n\n你把鞭子扔向那个蜷缩的孩子，告诉他的父母为你的时间付钱，告诉他们“佣兵从来都不是免费的。”}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "必须要予以惩戒。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(10);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + 10 + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Accept3B",
			Text = "[img]gfx/ui/events/event_97.png[/img]{小心翼翼地，你回到男孩的家。 打开门，你转向那孩子，告诉他如果他再撒谎，你就…你还没来得及说完威胁的话，一声尖叫就把你的注意力吸引到这家人身上。 一个巨大的，食尸鬼的身影正恐吓着母亲，父亲正用扫帚试图把它击退。 你拔出剑来，向前一步，砍倒僵尸。 它的头部自由翻滚，飞溅到一个锅里，而它的身体则变了形并在地板上喷出黑色的污物。\n\n 你转向那个男孩，告诉他你差点儿没来，因为一个说谎者的实话对所有人来说永远都是谎言。 他点了点头，感谢你这次相信他。 他父母也感谢你，但要表示一点心意：一个装着克朗和物品的袋子。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "最好把那个锅扔掉。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(1);
				this.World.Assets.addMoney(25);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + 25 + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Refuse1",
			Text = "[img]gfx/ui/events/event_97.png[/img]{你不信任那个小杂种，告诉他不要再玩游戏了。 他在靴子下吐着唾沫，用脚搅着一些石头。%SPEECH_ON%见鬼，先生，我就是想找点乐子。%SPEECH_OFF%他转身离开时，你狠狠地踹了他一脚。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "可恶的小杂种。",
					function getResult( _event )
					{
						return "Accept" + _event.m.Refusals + "B";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Refuse2",
			Text = "[img]gfx/ui/events/event_97.png[/img]{你告诉那个男孩，如果他不离开你的视线，你就向守卫告状，把他扔进地牢。 他气的吐唾沫。%SPEECH_ON%我靠，先生，我就是开个玩笑，就这样。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "别再回来。",
					function getResult( _event )
					{
						return "Accept" + _event.m.Refusals + "B";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Refuse3",
			Text = "[img]gfx/ui/events/event_97.png[/img]{你蹲下，你用眼睛对视着这个孩子。 你问他是不是在撒谎。慢慢地，他点头。 一个守卫听到了，走过来抓住孩子的胳膊。%SPEECH_ON%又在说谎了，是吗？ 我不是跟你说过别烦旅客的事儿么，嗯？ 我想你父亲的手劲儿可能不够大，结果你还这么干。 现在我们来看看你在地牢里的表现！%SPEECH_OFF%男孩被带走了，当一对生锈的脚镣被甩在他身上时，他的眼睛被打肿了。 这是你一生中最欢乐的时刻之一。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "去地牢快活吧。",
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
			ID = "Refuse3B",
			Text = "[img]gfx/ui/events/event_29.png[/img]{你告诉那个男孩憋回去。 他又一次乞求，有那么一会儿，他撒谎的眼睛后面好像有什么真实的东西。 但你不买账。 男孩跑开了，现在正在向守卫寻求帮助。 他们也拒绝了他。 几个商人笑了。%SPEECH_ON%没人相信你的谎言，小杂种。%SPEECH_OFF%但是一声尖叫打破了戏谑。 一名男子一瘸一拐地穿过街道，抓着自己的脖子，脖子上的鲜血从指缝间喷涌而出。 他瘫倒在地。 一个灰黄皮肤的女人在后面追赶，倒在男人的身上，咬着他的腿。 卫兵冲到现场，杀死死者和垂死的人，而那个刚刚成为孤儿的人还在哀嚎。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Oh.",
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

		if (this.World.FactionManager.getGreaterEvilType() != this.Const.World.GreaterEvilType.Undead || this.World.FactionManager.getGreaterEvilPhase() == this.Const.World.GreaterEvilPhase.NotSet)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
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

