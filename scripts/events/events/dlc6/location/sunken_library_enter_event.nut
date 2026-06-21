this.sunken_library_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.sunken_library_enter";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_173.png[/img]{光与亮如此耀眼以至于你开始认为镀金者他本人授予了你一场正式访问，不幸的或者说幸运的是，实际上是你遇到了一个略微露出沙丘的巨大镀金穹顶。 很快，你试了试你能不能扒下来一些金子，但是一无所获。%randombrother% 把你叫到一块裂开的石板边。 或许这里过去曾经是一座钟塔？ 光线消散的很快，你看不到多少里面的东西。 在进入通道的上方有一片浮雕描绘着人们拉着一车一车的卷轴。\n\n 浮雕上有一组文字被反复的刻在上面。 看起来丝毫不像任何你听或看过的语言。 你花了一些时间才找到了一个更接近你的时代的人仓促刻下的翻译：“图书馆，夜晚的迷宫，思维的迷宫，如同离开梦境一般离开，如同步入梦境一般行走，离开便栖身于未知的恐惧，进入则成为已知的一员，并通过知晓梦境，知晓梦魇”。%SPEECH_ON%颇为不详啊，队长，但如果你想要下去我们有可以用的绳索与火炬。%SPEECH_OFF%%randombrother% 向你提供了这些话，还有他希望你会拒绝这个提案的表情。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "索降到黑暗中去！",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们不要打扰这里面沉睡的东西。",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setVisited(false);
						}

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
			Text = "[img]gfx/ui/events/event_89.png[/img]{向下的路程非常的危险，黑暗如此厚重你甚至看不到你自己的靴子。 但是最终你踩到了大理石地板并快速的点亮了一些火炬。 你发现自己在一个充满了一排又一排螺旋状书柜的巨大大厅内。 每一个书柜都有成堆的卷轴，许多被封存在玻璃罐中。 书柜彼此堆叠在一起看起来好像高耸到你降下来的天花板一般。 每一层都放着楼梯，但是更高的地方时不时停着一个带着金属溜道的悬浮夹层。 看起来好像过去可以通过这些把卷轴传上传下，尽管现在一切都锈了，夹层也有部分塌了。\n\n %randombrother% 寻求你的注意。 他指向一个被压平在一层玻璃后的巨大卷轴。 纸上到处都是绘画，在更仔细的观察后看起来他们好像是一切的蓝图：人体，许多动物的身体，城堡，塔，风车磨坊，船只，武器有盔甲，靴子与手套，行星的排列，还有很多你从没见过的东西的绘画，毫不合理的东西。%SPEECH_ON%队长，这个地方不是我们该来的。 这语言，这长廊，我们应该离开这里。%SPEECH_OFF%一个佣兵表达了空气中弥漫的情绪。 你显然擅自进入了一个很少人来过的地方。 如果有人曾经来过，他们现在在哪？ 这样一个地方显然不可能就这么藏起来，对吗？}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那是什么声音？",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_89.png[/img]{%SPEECH_START%图书馆中有闯入者。%SPEECH_OFF%声音在大理石地板上摩擦着挺起身来靠近你的耳朵，“图书馆”一词滑入你背后的黑暗。 突然，数副玻璃柜开始发光，其中的护符存放着某种超自然的能量，并且随着光的扩散映照出了一副黑色骷髅的身躯，它的身躯被捕获在半空中。 胸骨中有一本书，扭曲的肋骨包裹着它如同一只蜘蛛抓住它的食物一般。 这个生物用空洞的眼眶注视着你。%SPEECH_ON%你们之类曾经对我行窃过，现在你还敢再次亵渎这些长廊？%SPEECH_OFF%护符发出的光越发闪亮，同时骷髅的身躯开始长出血肉，血管与皮肤绽放出来包裹住骨头。 但只有躯干是稳定的。 你看向那些护符，他们现在充满了能量，你可以看到鬼魅般的面孔如同雨水般抹过封存他们的玻璃。 你听到一声响亮的击掌，转过身来你看到了博学士，重归完整，它的眼中冒出白色的火焰，它干瘦的四肢上烟雾缭绕的肌肉缠绕着火焰，在它的下半身黑色的灰烬随着它滑翔向前而喷出。 随着灯泡越来越亮，他正变得越来越强，越来越快！}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "为你们的生命而战！ 像从没打过仗一样去打！",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setVisited(false);
						}

						local p = this.Const.Tactical.CombatInfo.getClone();
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						p.CombatID = "SunkenLibrary";
						p.TerrainTemplate = "tactical.sinkhole";
						p.LocationTemplate.Template[0] = "tactical.sunken_library";
						p.Music = this.Const.Music.UndeadTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Center;
						p.IsWithoutAmbience = true;
						p.Entities = [];

						for( local i = 0; i < 4; i = ++i )
						{
							p.Entities.push(clone this.Const.World.Spawn.Troops.SkeletonHeavyBodyguard);
						}

						local f = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID();

						for( local i = 0; i < p.Entities.len(); i = ++i )
						{
							p.Entities[i].Faction <- f;
						}

						p.BeforeDeploymentCallback = function ()
						{
							local phylacteries = 10;
							local phylactery_tiles = [];

							do
							{
								local x = this.Math.rand(10, 28);
								local y = this.Math.rand(4, 28);
								local tile = this.Tactical.getTileSquare(x, y);

								if (!tile.IsEmpty)
								{
								}
								else
								{
									local skip = false;

									foreach( t in phylactery_tiles )
									{
										if (t.getDistanceTo(tile) <= 5)
										{
											skip = true;
											break;
										}
									}

									if (skip)
									{
									}
									else
									{
										local e = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/phylactery", tile.Coords);
										e.setFaction(f);
										phylacteries = --phylacteries;
										phylactery_tiles.push(tile);
									}
								}
							}
							while (phylacteries > 0);

							local toRise = 5;

							do
							{
								local r = this.Math.rand(0, phylactery_tiles.len() - 1);
								local p = phylactery_tiles[r];

								if (p.SquareCoords.X > 14)
								{
									p.Level = 3;
									toRise = --toRise;
								}

								phylactery_tiles.remove(r);
							}
							while (toRise > 0 && phylactery_tiles.len() > 0);

							local lich = 1;

							do
							{
								local x = this.Math.rand(9, 10);
								local y = this.Math.rand(15, 17);
								local tile = this.Tactical.getTileSquare(x, y);

								if (!tile.IsEmpty)
								{
								}
								else
								{
									local e = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/skeleton_lich", tile.Coords);
									e.setFaction(f);
									e.assignRandomEquipment();
									lich = --lich;
								}
							}
							while (lich > 0);

							local treasureHunters = 3;

							do
							{
								local x = this.Math.rand(9, 11);
								local y = this.Math.rand(11, 21);
								local tile = this.Tactical.getTileSquare(x, y);

								if (!tile.IsEmpty)
								{
								}
								else
								{
									local e = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/zombie_treasure_hunter", tile.Coords);
									e.setFaction(f);
									e.assignRandomEquipment();
									local item = e.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
									item.setCondition(this.Math.rand(item.getConditionMax() / 2, item.getConditionMax()));
									treasureHunters = --treasureHunters;
								}
							}
							while (treasureHunters > 0);

							local heavy = 4;

							do
							{
								local x = this.Math.rand(9, 14);
								local y = this.Math.rand(8, 20);
								local tile = this.Tactical.getTileSquare(x, y);

								if (!tile.IsEmpty)
								{
								}
								else
								{
									local e = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/skeleton_heavy", tile.Coords);
									e.setFaction(f);
									e.assignRandomEquipment();
									local item = e.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
									item.setCondition(this.Math.rand(item.getConditionMax() / 2, item.getConditionMax()));
									heavy = --heavy;
								}
							}
							while (heavy > 0);

							local heavy_polearm = 4;

							do
							{
								local x = this.Math.rand(12, 14);
								local y = this.Math.rand(12, 26);
								local tile = this.Tactical.getTileSquare(x, y);

								if (!tile.IsEmpty)
								{
								}
								else
								{
									local e = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/skeleton_heavy_polearm", tile.Coords);
									e.setFaction(f);
									e.assignRandomEquipment();
									local item = e.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
									item.setCondition(this.Math.rand(item.getConditionMax() / 2, item.getConditionMax()));
									heavy_polearm = --heavy_polearm;
								}
							}
							while (heavy_polearm > 0);
						};
						p.AfterDeploymentCallback = function ()
						{
							this.Tactical.getWeather().setAmbientLightingPreset(5);
							this.Tactical.getWeather().setAmbientLightingSaturation(0.9);
						};
						_event.registerToShowAfterCombat("Victory", "Defeat");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Victory",
			Text = "[img]gfx/ui/events/event_89.png[/img]{博学者倒下化作了一堆灰，命匣慢慢黯淡。你拿着火炬走过去。 它的黑色头骨置于那本之前在胸口的书上面。%SPEECH_ON%队长，我不认为我们应该碰这里的任何东西。%SPEECH_OFF%你无视了你的手下并捡起了书。 它的封面是被缝在一起的某种皮革，随着你更仔细的观察你可以看到耳与鼻的血肉包裹着封面。 突然，被击倒的亡灵的尸骨擦过大理石地板。 一闪而过你的腿间并飞入一堆灰尘。 阴沉的白火从头骨的眼眶中亮起。 对你而言这足够明显了：你快速下令，让手下们用绳索爬回去，你断后。 随着你接近地表的亮光，你向下回望去－那个头骨正贴在你脸上！ 它独自飘着，眼中发出白火，将你的视线用你无法理解的火焰覆盖，随着你看着这火，只觉着你手下的声音越来越远。 头骨飘在那，而你几乎感到一股放开绳索的冲动。 头骨直接向你的思维说道：%SPEECH_ON%这只不过是它的礼物中的一个，入侵者，而你也不是第一个获得它的人。 有那么多人曾经得到过它，但所有人都殊途同归，归于那个等待着我们全部的人！ %SPEECH_OFF%头骨的火焰熄灭了后便掉入了黑暗中，只听得一声短暂的咔嗒声。 你手下的呼声重新涌入，比以往更加洪亮，你抬头看到了 %randombrother%的手。 紧抓着手，他们把你拉了出来。 随着你出来，入口陷入了沙子，只剩你手上一本怪异的血肉之书，其中的文字你甚至无法想象从何开始解读。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我刚刚拿的究竟是什么？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "战斗之后…";

				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().die();
				}

				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/special/black_book_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				this.World.Flags.set("IsLorekeeperDefeated", true);
				this.updateAchievement("Lorekeeper", 1, 1);
			}

		});
		this.m.Screens.push({
			ID = "Defeat",
			Text = "[img]gfx/ui/events/event_173.png[/img]伙计们匆忙的再次开始往上爬。%SPEECH_ON%或许下一次？%SPEECH_OFF%一个佣兵说着。%randombrother% 点头。%SPEECH_ON%是的，下次吧。或许很久以后，等我他妈的退休了，到时候你们可以再下到里面去跟那帮死巫师寻欢作乐。 这个时间对你们都合适吗？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "或许总有一天…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "战斗之后…";

				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().setVisited(false);
				}
			}

		});
	}

	function onUpdateScore()
	{
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

