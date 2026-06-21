this.anatomist_ok_with_mutations_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_ok_with_mutations";
		this.m.Title = "在途中…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_05.png[/img]{在与他新形成的畸形生物共度一些时间后，%anatomist%已经接受了他现在的身份。他把这些恐怖的伤疤和不断生长的脓疱看作是他走在正确道路上的证明。某种程度上，他是正确的。这些奇怪的变化使他比之前更优秀的战士，对于你个人而言，这是相当了不起的，因为你之前甚至没有希望这些愚蠢的蠢蛋们能够成为最好的合格战士。他之前的恐惧和担忧现在已经完全消失了，取而代之的是一种更新的目标感和渴望做更多的决心。 | %anatomist% 已经停止了闷闷不乐地担心他的伤疤和可怕的外表。他似乎已经和现在的外表达成了和解，或者可能是因为他已经深深地融入了从他身上散发出来的可怕气味，以至于他已经不再注意到了。虽然他的臭味每次在你接近他时都让你几乎呕吐，但至少他已经从每时每刻都占据他的情绪的沉闷中恢复过来了。也许现在他可以继续他的对科学发现的正义追求，或者做他所说的其他事情。 | 认识自己身份很难，尽管表面上看起来，与自己的外貌和解更加困难。当你的外貌不是你天生的，而是由你生活中的行为塑造而成时，这更加真实。如果是你自己的决定让你陷入了现在的困境，那么你只能为自己的选择而终生忧虑。你已经看到了这种情况很多次，特别是对于失去耳朵、鼻子、嘴唇甚至更严重的雇佣兵来说。一个人要和自己新的处境和解可能需要很长时间，就像 %anatomist% 一样。但他已经和解了。不管他因自己的行动所遭受的可怕伤痕和变异有多可怕，至少在心理上已不再如此。他已经继续前行，准备在科学探索中寻求自己的道路，不惜冒自己可能面临的巨大风险。 | %anatomist% 已经接受了他的新外貌。起初，他的身体对他一直服用的药剂的反应非常的令人不安，以至于他变得十分孤僻。你不能怪他，因为他看起来非常的丑陋。但是过了一段时间，你就会意识到生活还要继续下去，如果无法改变，那也无法改变。至少，做这些选择的真正目的是为了满足科学的探究精神。重新认识到这一点似乎让%anatomist%重新找到了自己的人生目标。他仍然笨拙且令人讨厌，你很难看着他，但至少现在他更加快乐了。 | 曾经饱受疾病和毁容之苦的解剖学家 %anatomist% 现在看起来好多了。也就是说，他已经意识到自己的相貌他几乎无能为力，而这种相貌，简言之，令人勇气和毅力才能直视。但是，该男子已经记起寻求配方、奇怪的混合物和调剂的真正原因是科学探索。现在，这位解剖学家是一个更加幸福的人，只要远离即使是最小的镜子，想必他能够保持现状。 | %anatomist%的习惯是喝下他自己调制的每一种药剂，最终却把自己弄进了麻烦。他最后一次饮用时出了大问题，将他的脸变成了肉质的面团，他的皮肤上出现了各种颗粒、挫伤、脓疱和脓汁。自然地，这些变化对这个人的士气产生了深刻影响。但是，最终他已经克服了这一切，他仍然是一个在任何意义上都是一个行走的怪物，但在内心深处，他已经和这个状态和解了，而内在才是真正重要的。或者，至少内在更重要，因为外表你都不敢勇敢地去看。 | 解剖学家 %anatomist% 称他身体的变化为“突变”，这肯定是个学究式的词，意思就是看起来像垃圾。有一段时间，他的外表影响了他的日常生活。你不能怪他，他是自己给自己带来了这些病痛，这总比世界上的事情更糟，让你毫无疑问地知道如何摆脱困境。幸运的是，这位解剖学家已经克服了他的沮丧和对自己可怕外表的忧虑。他甚至可能比以往更愿意继续饮用他的药水和调剂。毕竟，他已经非常难看了，在看起来完全丑陋的某一刻，甚至女性也会转过头来，就像看到了一只看起来被虐待的狗一样，好奇地去摸摸它。 | 喝下一些可疑药水后，解剖学家%anatomist%的身体开始发生变化，像任何成年人一样，那个年龄的变化很少是好事。 他的脸变得丑陋，身上布满了疮痕和疤痕。 有一段时间，这位解剖学家沉入了沉重的抑郁中，你不确定他的伤害只是表面，还是内在也受到了不可逆转的影响。 幸运的是，对一个人来说，士气可能是最难打破的。 %anatomist%已经接受了他的新形象。反正他也没什么办法，他现在把它看作是一种火烧试金的基本仪式，他就是他这个样子，并且他帮助推进了最初将他带到这些土地的科学事业。 对于你自己来说，只是要确保他不是你早上看到的第一件事情。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很高兴你感觉好些了，解剖学家（%anatomist%）",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.improveMood(1.0, "已经与他的变异达成了协议。");

				if (_event.m.Anatomist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				_event.m.Anatomist.getFlags().add("isOkWithMutations");
				this.Characters.push(_event.m.Anatomist.getImagePath());
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

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomistCandidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist" && bro.getFlags().has("gotUpsetAtMutations") && !bro.getFlags().has("isOkWithMutations"))
			{
				anatomistCandidates.push(bro);
			}
		}

		if (anatomistCandidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomistCandidates[this.Math.rand(0, anatomistCandidates.len() - 1)];
		this.m.Score = 10 * anatomistCandidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
	}

});

