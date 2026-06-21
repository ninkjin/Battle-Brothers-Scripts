this.anatomist_joins_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_joins";
		this.m.Title = "在途中…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_184.png[/img]{一位身穿灰色布衣的男人向你走来。他没有武器和盔甲，只带着卷轴和纸张，以及肮脏的绷带和裹着奇怪皮毛的钱袋。他向你打招呼。%SPEECH_ON%啊，%companyname%啊。我一直在寻找像你们这样具备......特质的人。你们看，我是一名解剖学家，而且-%SPEECH_OFF%你打断了他。你没有时间对付这个对于奇怪生物的痴迷者。他是要加入战团吗？简单地告诉他是或否。 | 你遇到了一个人正趴在一只死狗上。他用一根长棍子探测着犬嘴，点点头。%SPEECH_ON%正如你看到的，我是一位有名的解剖学家。%SPEECH_OFF%他像个奇怪的傀儡一样扭动着头，声称%companyname%正在慢慢地因其勤奋工作而变得出名 - 他希望加入。 | 你在石头上发现了一件外套，裤子和一双靴子。旁边有一些弹药袋和古怪的图纸。环顾四周，你看到一个人在池塘里嬉戏。他一看到你就惊慌地指着一只手。%SPEECH_ON%不要碰那个！嘿，你，别碰任何东西！%SPEECH_OFF%他从水中站起来，他的腿笨拙地溅着水。当他从池塘里站起来时，你看到他毛发异常浓密，水把他毛茸茸的裆部变成了一条灰色的毛巾。你拔出剑，那个男人停了下来。%SPEECH_ON%带着你的剑，旅人。我现在明白你是一个好奇心的人，我也是！亲爱的剑驱动旅人，我迫切需要平等的伙伴。你说我加入你们，怎么样？%SPEECH_OFF%你努力让眼睛盯着他的颈部，但一阵风吹过，你听到水从他的裆部飞溅像一只湿狗一样。随之而来的瞥低是相当不幸的。 | 你遇到一个坐在石头上的男人。他对面是一块分层解剖动物的石块。小狗、小猫、可能是青蛙、某种啮齿动物，还有......一只鸭子。他跳了起来。%SPEECH_ON%旅人，瞧，这是我研究的结果。但我仍然缺乏很多......。我可以看出你是一个有好奇心的人，虽然毫无疑问是个蛮子。我想向你提供我的服务，但我必须警告，我这些进步只属于我一个人。%SPEECH_OFF%他保护性地将手臂伸向解剖动物，好像你会对它们产生任何兴趣一样。}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "是的，我们会带你。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们不需要你的帮助。",
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
					"anatomist_background"
				]);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_184.png[/img]{这个人轻轻地鞠了一躬。%SPEECH_ON%啊，和有智慧的同行在一起真是太好了，尽管我要提醒他们，有些人比其他人更加平等，如果他们希望阅读我的作品，他们可以提交请求。%SPEECH_OFF%嗯，当然。}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "上车吧。",
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
			Text = "[img]gfx/ui/events/event_184.png[/img]{那人点点头。%SPEECH_ON%很公平。当我遇到我的智慧上司时，我变得嫉妒并拒绝他提供的任何帮助。那么，先生，愿您旅途愉快，追上我和我的发现！%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "是的，去你的，太过分了。",
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

		if (this.World.Assets.getOrigin().getID() != "scenario.anatomists")
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local numAnatomists = 0;

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				numAnatomists++;
			}
		}

		local comebackBonus = numAnatomists < 3 ? 8 : 0;
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

