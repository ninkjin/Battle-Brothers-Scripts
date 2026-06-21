this.the_horseman_event <- this.inherit("scripts/events/event", {
	m = {
		Flagellant = null,
		Butcher = null,
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.the_horseman";
		this.m.Title = "在路上…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%当在路上的时候，你看到了一个男人被吊在树干上，上上下下摇晃着。 一堆人坐在他周围分享着一个羊皮袋子里的饮品，看起来像是他们完成了一天的辛苦工作。 当你问发生了什么时，他们中的一个抬起头来看了看然后笑了。%SPEECH_ON%用鞭子抽这家伙直到他皮开肉绽。%SPEECH_OFF%你问为什么。另外一个人回答了。%SPEECH_ON%他和这位伙计的老婆通奸了。%SPEECH_OFF%一个男人瞬间喷出了他喝的东西，然后被呛住了。 他擦了擦嘴。%SPEECH_ON%沃日，真好笑。 不，这个小人在操我的死马的时候被抓住了。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们去和那个被吊着的男人聊聊吧。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们继续走吧。",
					function getResult( _event )
					{
						if (_event.m.Butcher != null)
						{
							return "Butcher";
						}
						else
						{
							return 0;
						}
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "%terrainImage%你走近了那个吊着的男人。 鲜血从他的背上流下来，上面有十几道伤口。 你把蒙着他眼睛的那块布拽了下来。 眨巴着眼睛，他问你想要什么，就好像你打断了他的自我体罚一样。 你问了他那些人说的是不是真的。 他啐了口唾沫，清了清嗓子。%SPEECH_ON%我说，是的，但是马已经是死了，所以又有什么关系呢？ 一个男人就不能有点自己的乐子吗？%SPEECH_OFF%马的主人站了起来，威胁似得挥舞着一条湿漉漉的鞭子。%SPEECH_ON%唔，你想让我们再来一次吗？ 我们都这样耗了一整天了！%SPEECH_OFF%叹了口气，那个被吊着的男人问了你一个问题。%SPEECH_ON%你是个佣兵，对吧？ 我来你的团队为你而战，如何呀？ 我四肢健全又身强体壮，关于这匹小马，我是说更糟的那件事，只不过是表面现象，但是撇开这一点，还有，呃，还有那些死掉的动物，我是一个正直的并且有道德感的人。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们会把你放下来的。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 75)
						{
							return "C";
						}
						else
						{
							return "D";
						}
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Flagellant != null)
				{
					this.Options.push({
						Text = "%flagellantfull%，看起来你有些想法。",
						function getResult( _event )
						{
							return "Flagellant";
						}

					});
				}

				this.Options.push({
					Text = "是时候离开了。",
					function getResult( _event )
					{
						if (_event.m.Butcher != null)
						{
							return "Butcher";
						}
						else
						{
							return 0;
						}
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "%terrainImage%你拔出了你的利刃，砍断了吊着那个男人的绳子。 他把他蜷缩的肩膀张开，他受过鞭打的背部倒在了土地上。 他号啕大哭了起来，土地可能都因此而变咸了。 其中的一个鞭打者站了起来。%SPEECH_ON%嘿，你觉得你在干什么？ 我们的事还没完呢！%SPEECH_OFF%%randombrother% 拔出了他的武器，那个鞭打者便退后了。 马的主人啐了口唾沫，摇了摇他的头。%SPEECH_ON%你真的要保护这货吗？ 他就是狗屎。 我猜现在我能说我确确实实看到了我之前说的整个过程，当我抓到这个混蛋在日我的死马的时候！%SPEECH_OFF%男人深吸了一口气，然后指着刚刚获救的家伙。%SPEECH_ON%我希望你第一天就死在外面你这个日马的混蛋。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎加入，你这个马婊子。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				},
				{
					Text = "走吧。我们这里不需要你。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"vagabond_background"
				]);
				_event.m.Dude.setTitle("小马拉琴手(the Filly Fiddler)");
				_event.m.Dude.getBackground().m.RawDescription = "你发现 %name% 因为“涉及”一匹死马而被鞭打。 希望过去，呃，现在已经过去了。";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.setHitpoints(30);
				_event.m.Dude.improveMood(1.0, "用一匹死马来满足他的需要");
				_event.m.Dude.worsenMood(1.0, "被鞭打了");

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
				}

				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "%terrainImage%你拔出了你的利刃，砍断了吊着那个男人的绳子。 他的头直落到地上，脖子伴随着一阵令人胆寒的咔咔声断掉了。 他身体的剩下部分随着双腿笨拙地越过了他自己的胸口上方而摊平在地，这个姿势很明显对这个有怪异性癖的人来说不正常。 马主人突然挪了挪他的脚。%SPEECH_ON%我靠，先生，我们只是想好好的鞭打一下他。 你为啥要把他杀了呢？%SPEECH_OFF%他闭上了嘴，然后轻蔑地摆了摆手。%SPEECH_ON%该死。该死，老兄。好吧，好的。 我们接下来会各走各的路，并且对于这里发生的事一个字也不会说。 这样你们觉得可以吗，伙计们？%SPEECH_OFF%其余的人点头。%SPEECH_ON%快跑吧。我才不要让我的生活因为什么日马者而被毁。 好样的，佣兵，愚蠢的剑杀了一个臭婊子的。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Whoops.",
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
			ID = "Flagellant",
			Text = "%terrainImage%%flagellant% 上前了一步，夺走了马主人的鞭子。 他把它卷了起来起来，用手握在这个皮圈上。 点着头，他说这是一个“不错的工具”，可以用来鞭打，但是这些人用的方法“全都是错的。” 他指了指那人背后的伤口。%SPEECH_ON%看到这些伤口了吗？它们又薄开口又小。 不要让出血量骗了你，这些都是表皮伤。 来，让我给你表演一下什么叫痛打。%SPEECH_OFF%苦修者放下了鞭子的细端，转了一会儿，然后击打。 吊着的男人大叫了起来。 一个伤口出现了，它从一根肋骨的尖端裂开，横贯他的后背连到了另一根肋骨的尖端。 你可以看到皮肤下面满满的肌肉和脂肪。%flagellant% 再一次击打，再一次，再一次。 在鞭打的同时，血溅到苦修者身上，日马者已经昏厥了很久了。 终于，一个人站了起来，夺回了鞭子。%SPEECH_ON%那，那已经够了。你们上路走吧，行吗？我的老天爷啊…%SPEECH_OFF%另外一个人把日马人放了下来，然后仔细观察着那些新的，触目惊心的伤口。%flagellant% 擦了擦他的额头，同时欣赏了一下他的作品。%SPEECH_ON%嗯哼，事情就该这么办。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "是，是是。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Flagellant.getImagePath());
				local meleeSkill = 1;
				local fatigue = 1;
				_event.m.Flagellant.getBaseProperties().MeleeSkill += meleeSkill;
				_event.m.Flagellant.getBaseProperties().Stamina += fatigue;
				_event.m.Flagellant.getSkills().update();
				_event.m.Flagellant.improveMood(1.0, "充分利用他的独特技能");

				if (_event.m.Flagellant.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Flagellant.getMoodState()],
						text = _event.m.Flagellant.getName() + this.Const.MoodStateEvent[_event.m.Flagellant.getMoodState()]
					});
				}

				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.Flagellant.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + meleeSkill + "[/color] 近战技能"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/fatigue.png",
					text = _event.m.Flagellant.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + fatigue + "[/color] 最大疲劳"
				});
			}

		});
		this.m.Screens.push({
			ID = "Butcher",
			Text = "%terrainImage%%butcher% 问马是否还在附近。主人点了点头。%SPEECH_ON%啊，新鲜的尸体，刚刚被刺的方式弄脏了。为什么？%SPEECH_OFF%屠夫问他能不能接手那匹死马。主人耸耸肩。%SPEECH_ON%如果你想要的话，它就是你的了。 虽然你在切被他碰过的那一部分附近时最好小心一点。%SPEECH_OFF%在说其他什么之前，%butcher% 让人把他带到了马的尸体旁，以便于，嗯，肢解它。 战队拿到了一些有问题的肉可以吃。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我不确定我想让这些东西出现在我们的库存里。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Butcher.getImagePath());
				local item = this.new("scripts/items/supplies/strange_meat_item");
				this.World.Assets.getStash().add(item);
				item = this.new("scripts/items/supplies/strange_meat_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y < this.World.getMapSize().Y * 0.2)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidate_flagellant = [];
		local candidate_butcher = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.flagellant")
			{
				candidate_flagellant.push(bro);
			}
			else if (bro.getBackground().getID() == "background.butcher")
			{
				candidate_butcher.push(bro);
			}
		}

		if (candidate_flagellant.len() != 0)
		{
			this.m.Flagellant = candidate_flagellant[this.Math.rand(0, candidate_flagellant.len() - 1)];
		}

		if (candidate_butcher.len() != 0)
		{
			this.m.Butcher = candidate_butcher[this.Math.rand(0, candidate_butcher.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"flagellant",
			this.m.Flagellant != null ? this.m.Flagellant.getNameOnly() : ""
		]);
		_vars.push([
			"flagellantfull",
			this.m.Flagellant != null ? this.m.Flagellant.getName() : ""
		]);
		_vars.push([
			"butcher",
			this.m.Butcher != null ? this.m.Butcher.getNameOnly() : ""
		]);
		_vars.push([
			"butcherfull",
			this.m.Butcher != null ? this.m.Butcher.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Flagellant = null;
		this.m.Butcher = null;
		this.m.Dude = null;
	}

});

