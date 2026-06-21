local gt = this.getroottable();

if (!("Contracts" in gt.Const))
{
	gt.Const.Contracts <- {};
}

gt.Const.Contracts.Overview <- [
	{
		ID = "Overview",
		Title = "Overview",
		Text = "你方谈判的合同如下。你同意这些条款吗？",
		Image = "",
		List = [],
		Options = [
			{
				Text = "我接受这份合同。",
				function getResult()
				{
					this.Contract.setState("Running");
					return 0;
				}

			},
			{
				Text = "我需要一些时间来考虑考虑。",
				function getResult()
				{
					this.World.State.getTownScreen().updateContracts();
					return 0;
				}

			},
			{
				Text = "仔细考虑之后，我拒绝这份合同。",
				function getResult()
				{
					this.World.Contracts.removeContract(this.Contract);
					this.World.State.getTownScreen().updateContracts();
					return 0;
				}

			}
		],
		ShowObjectives = true,
		ShowPayment = true,
		ShowEmployer = true,
		ShowDifficulty = true,
		function start()
		{
			this.Contract.m.IsNegotiated = true;
		}

	}
];
gt.Const.Contracts.NegotiationDefault <- [
	{
		ID = "Negotiation",
		Title = "谈判",
		Text = "",
		Image = "",
		List = [],
		ShowEmployer = true,
		ShowDifficulty = true,
		Options = [],
		function start()
		{
			this.Options = [];
			this.Options.push({
				Text = "我接受你的提议。",
				function getResult()
				{
					this.Contract.m.BulletpointsPayment = [];

					if (this.Contract.m.Payment.Advance != 0)
					{
						this.Contract.m.BulletpointsPayment.push("得到" + this.Contract.m.Payment.getInAdvance() + "克朗预付款。");
					}

					if (this.Contract.m.Payment.Completion != 0)
					{
						this.Contract.m.BulletpointsPayment.push("得到" + this.Contract.m.Payment.getOnCompletion() + "克朗当合同完成时。");
					}

					return "Overview";
				}

			});
			this.Options.push({
				Text = "我们需要更多的报酬。",
				function getResult()
				{
					if (!this.World.Retinue.hasFollower("follower.negotiator"))
					{
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
					}

					this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

					if (this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance)
					{
						return "Negotiation.Fail";
					}

					if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance)
					{
						this.Contract.m.Payment.IsFinal = true;
					}
					else
					{
						this.Contract.m.Payment.IsFinal = false;
						this.Contract.m.Payment.Pool = this.Contract.m.Payment.Pool * (1.0 + this.Math.rand(3, 10) * 0.01);
					}

					return "Negotiation";
				}

			});

			if (this.Contract.m.Payment.Advance < 1.0)
			{
				this.Options.push({
					Text = this.Contract.m.Payment.Advance == 0 ? "我们需要预付款。" : "我们需要更多的预付款。",
					function getResult()
					{
						this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

						if (this.Contract.m.Payment.Advance >= this.World.Assets.m.AdvancePaymentCap || this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance)
						{
							return "Negotiation.Fail";
						}

						if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance)
						{
							this.Contract.m.Payment.IsFinal = true;
						}
						else
						{
							this.Contract.m.Payment.IsFinal = false;
							this.Contract.m.Payment.Advance = this.Math.minf(1.0, this.Contract.m.Payment.Advance + 0.25);
							this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.25);
						}

						return "Negotiation";
					}

				});
			}

			if (this.Contract.m.Payment.Completion < 1.0)
			{
				this.Options.push({
					Text = this.Contract.m.Payment.Completion == 0 ? "我们需要在工作完成后得到报酬。" : "我们需要在工作完成后得到更多报酬。",
					function getResult()
					{
						this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

						if (this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance)
						{
							return "Negotiation.Fail";
						}

						if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance)
						{
							this.Contract.m.Payment.IsFinal = true;
						}
						else
						{
							this.Contract.m.Payment.IsFinal = false;
							this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.25);
							this.Contract.m.Payment.Completion = this.Math.minf(1.0, this.Contract.m.Payment.Completion + 0.25);
						}

						return "Negotiation";
					}

				});
			}

			this.Options.push({
				Text = "算了吧，这不值得。",
				function getResult()
				{
					this.World.Contracts.removeContract(this.Contract);
					this.World.State.getTownScreen().updateContracts();
					return 0;
				}

			});

			if (!this.Contract.m.Payment.IsNegotiating)
			{
				this.Text = "[img]gfx/ui/events/event_04.png[/img]{他点了点头。%SPEECH_ON%很好。我想的就是提前给你们报酬。 | 他挺起了身。%SPEECH_ON%那么，关于报酬。 | 他笑了笑。%SPEECH_ON%朋友，你们很快就能发大财了。 | 他深呼吸了一口气。%SPEECH_ON%非常好，这是我准备给你的报价。 | 他手放在你肩头，微笑中透着肯定。%SPEECH_ON%我想我知道一个适当的报酬来支付你的服务。 | 他用手做出手势，指着手指好像在数些什么，但对你来说没有任何意义。%SPEECH_ON%根据经验来看，这对这项任务来说是很好的报酬。 | 他点了点头。%SPEECH_ON%你看起来挺有能力的，我愿意慷慨解囊。 | 他晃动着一袋硬币。%SPEECH_ON%如果你能帮我处理这件事，这些硬币就是你的了。 | 他摊开了双手。%SPEECH_ON%我现在手头比较紧，所以在你问之前，这就是我现在所有的钱了。 | %SPEECH_ON%请放心，我现在所提供的报酬对于你的工作来说是非常不错的。} ";
				this.Contract.m.Payment.IsNegotiating = true;
			}
			else if (this.Contract.m.Payment.IsFinal)
			{
				this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%我拒绝再为此付出更多的报酬。 | %SPEECH_START%要理性一些。  | %SPEECH_START%不，不，不。 | %SPEECH_START%你觉得你是谁？我告诉你，如何支付报酬是我决定的。  | 他只是严肃地看着你，摇了摇头。%SPEECH_ON% | %SPEECH_START%不可能！%SPEECH_OFF%他愤怒地大吼。%SPEECH_ON% | %SPEECH_START%不，你已经得到的比你应得的更多了。 | %SPEECH_START%不。不要把我逼急了！ | %SPEECH_START%我认为你还没有完全理解这个问题的运作方式。如果你想要钱，我们需得达成协议。我的报价仍然有效。}";
			}
			else
			{
				this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%就这样了? | 他深呼吸了一口气。%SPEECH_ON% | 他叹了口气。%SPEECH_ON% | %SPEECH_START%行吧。  | %SPEECH_START%好吧，好吧。 | %SPEECH_START%如果一定要这样的话。 | %SPEECH_START%行吧，这样可以吗？ | %SPEECH_START%行，行。我理解。 | %SPEECH_START%这还算合理。 | %SPEECH_START%有趣。我觉得这样比较合适。 | %SPEECH_START%这样如何？ | %SPEECH_START%让我报下价吧。 | %SPEECH_ON%可以。这样你就接受了？ | %SPEECH_START%好吧。鉴于你的要求，这是我新的报价  | %SPEECH_START%让我们快点结束吧。这是我的新报价。 | %SPEECH_START%我们朋友一场，对吧？让我想想……}";
			}

			if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance == 0)
			{
				this.Text += "合同完成后 {你会得到 | 你会收到 | 我会给你} %reward_completion% 克朗。%SPEECH_OFF%";
			}
			else if (this.Contract.m.Payment.Completion == 0 && this.Contract.m.Payment.Advance != 0)
			{
				this.Text += "{你会得到 | 你会收到 | 我会给你}共%reward_advance% 克朗的预付款。%SPEECH_OFF%";
			}
			else if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance != 0)
			{
				this.Text += "{你会得到 | 你会收到 | 我会给你} %reward_advance% 克朗的预付款, 并且当你完成后再付 %reward_completion% 克朗。%SPEECH_OFF%";
			}
			else
			{
				this.Text += "你什么也得不到。 你希望这样吗？%SPEECH_OFF%";
			}
		}

	},
	{
		ID = "Negotiation.Fail",
		Title = "谈判",
		Text = "[img]gfx/ui/events/event_74.png[/img]{%SPEECH_START%搞得就像只有你会为硬币卖命一样。 看来我还是去其他地方找人好了。拜拜。%SPEECH_OFF% | %SPEECH_START%我的耐心是有限度的，看来我这是在浪费时间。%SPEECH_OFF% | %SPEECH_START%我受够了! 我相信我会找到其他人来做这项工作！%SPEECH_OFF% | %SPEECH_START%别侮辱我的智商！合同就算了。咱们到此为止。%SPEECH_OFF% | 他气得面色发红。%SPEECH_ON%滚开这里，我还没有和贪婪之辈做交易的习惯！%SPEECH_OFF% | 他叹了口气。%SPEECH_ON%算…算了。刚开始就不该相信你的。你走吧，这样我好找其他人。%SPEECH_OFF% | %SPEECH_START%我当真还以为咱俩关系还不错。但这已经超出我的极限了。我觉得这不行，拉倒吧。%SPEECH_OFF% | %SPEECH_ON%这真是浪费时间。要是没想明白就别再来找我了。%SPEECH_OFF%}",
		Image = "",
		List = [],
		ShowEmployer = true,
		ShowDifficulty = true,
		Options = [
			{
				Text = "我们不会为了微薄的报酬而冒生命危险…",
				function getResult()
				{
					this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationContractNegotiationsFail, "合同谈判搞砸了");
					this.World.Contracts.removeContract(this.Contract);
					return 0;
				}

			}
		]
	}
];
gt.Const.Contracts.NegotiationPerHead <- [
	{
		ID = "Negotiation",
		Title = "谈判",
		Text = "",
		Image = "",
		List = [],
		ShowEmployer = true,
		ShowDifficulty = true,
		Options = [],
		function start()
		{
			this.Options = [];
			this.Options.push({
				Text = "我接受你的提议。",
				function getResult()
				{
					this.Contract.m.BulletpointsPayment = [];

					if (this.Contract.m.Payment.Advance != 0)
					{
						this.Contract.m.BulletpointsPayment.push("得到" + this.Contract.m.Payment.getInAdvance() + "克朗预付款。");
					}

					if (this.Contract.m.Payment.Count != 0)
					{
						this.Contract.m.BulletpointsPayment.push("得到" + this.Contract.m.Payment.getPerCount() + "克朗，为你带回来的每个人头，最多" + this.Contract.m.Payment.MaxCount + "个。");
					}

					if (this.Contract.m.Payment.Completion != 0)
					{
						this.Contract.m.BulletpointsPayment.push("得到" + this.Contract.m.Payment.getOnCompletion() + "克朗当合同完成时。");
					}

					return "Overview";
				}

			});
			this.Options.push({
				Text = "我们需要更多的报酬。",
				function getResult()
				{
					if (!this.World.Retinue.hasFollower("follower.negotiator"))
					{
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
					}

					this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

					if (this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance)
					{
						return "Negotiation.Fail";
					}

					if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance)
					{
						this.Contract.m.Payment.IsFinal = true;
					}
					else
					{
						this.Contract.m.Payment.IsFinal = false;
						this.Contract.m.Payment.Pool = this.Contract.m.Payment.Pool * (1.0 + this.Math.rand(3, 10) * 0.01);
					}

					return "Negotiation";
				}

			});

			if (this.Contract.m.Payment.Count < 1.0)
			{
				this.Options.push({
					Text = this.Contract.m.Payment.Count == 0 ? "我们需要你为每个人头付钱。" : "我们需要你为每个人头付更多的钱。",
					function getResult()
					{
						this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

						if (this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance)
						{
							return "Negotiation.Fail";
						}

						if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance)
						{
							this.Contract.m.Payment.IsFinal = true;
						}
						else
						{
							this.Contract.m.Payment.IsFinal = false;

							if (this.Contract.m.Payment.Completion > 0 && this.Contract.m.Payment.Advance > 0)
							{
								this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.125);
								this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.125);
							}
							else if (this.Contract.m.Payment.Advance > 0)
							{
								this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.25);
							}
							else
							{
								this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.25);
							}

							this.Contract.m.Payment.Count = this.Math.minf(1.0, this.Contract.m.Payment.Count + 0.25);
						}

						return "Negotiation";
					}

				});
			}

			if (this.Contract.m.Payment.Advance < 1.0)
			{
				this.Options.push({
					Text = this.Contract.m.Payment.Advance == 0 ? "我们需要预付款。" : "我们需要更多的预付款。",
					function getResult()
					{
						this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

						if (this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance)
						{
							return "Negotiation.Fail";
						}

						if (this.Contract.m.Payment.Advance >= this.World.Assets.m.AdvancePaymentCap || this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance)
						{
							this.Contract.m.Payment.IsFinal = true;
						}
						else
						{
							this.Contract.m.Payment.IsFinal = false;

							if (this.Contract.m.Payment.Completion > 0 && this.Contract.m.Payment.Count > 0)
							{
								this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.125);
								this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.125);
							}
							else if (this.Contract.m.Payment.Count > 0)
							{
								this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.25);
							}
							else
							{
								this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.25);
							}

							this.Contract.m.Payment.Advance = this.Math.minf(1.0, this.Contract.m.Payment.Advance + 0.25);
						}

						return "Negotiation";
					}

				});
			}

			if (this.Contract.m.Payment.Completion < 1.0)
			{
				this.Options.push({
					Text = this.Contract.m.Payment.Completion == 0 ? "我们需要在工作完成后得到报酬。" : "我们需要在工作完成后得到更多报酬。",
					function getResult()
					{
						this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

						if (this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance)
						{
							return "Negotiation.Fail";
						}

						if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance)
						{
							this.Contract.m.Payment.IsFinal = true;
						}
						else
						{
							this.Contract.m.Payment.IsFinal = false;

							if (this.Contract.m.Payment.Advance > 0 && this.Contract.m.Payment.Count > 0)
							{
								this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.125);
								this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.125);
							}
							else if (this.Contract.m.Payment.Count > 0)
							{
								this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.25);
							}
							else
							{
								this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.25);
							}

							this.Contract.m.Payment.Completion = this.Math.minf(1.0, this.Contract.m.Payment.Completion + 0.25);
						}

						return "Negotiation";
					}

				});
			}

			this.Options.push({
				Text = "算了吧，这不值得。",
				function getResult()
				{
					this.World.Contracts.removeContract(this.Contract);
					this.World.State.getTownScreen().updateContracts();
					return 0;
				}

			});

			if (!this.Contract.m.Payment.IsNegotiating)
			{
				this.Text = "[img]gfx/ui/events/event_04.png[/img]{他点了点头。%SPEECH_ON%好的。很好。我想的就是提前给你们报酬。 | 他笑了笑。%SPEECH_ON%朋友，你们很快就能发大财了。 | 他深呼吸了一口气。%SPEECH_ON%非常好，这是我准备给你的报价。 | 他手放在你肩头，微笑中透着肯定。%SPEECH_ON%我想我知道一个适当的报酬来支付你的服务。 | 他用手做出手势，指着手指好像在数些什么，但对你来说没有任何意义。%SPEECH_ON%根据经验来看，这对这项任务来说是很好的报酬。 | 他点了点头。%SPEECH_ON%你看起来挺有能力的，我愿意慷慨解囊。 | 他晃动着一袋硬币。%SPEECH_ON%如果你能帮我处理这件事，这些硬币就是你的了。 | 他摊开了双手。%SPEECH_ON%我现在手头比较紧，所以在你问之前，这就是我现在所有的钱了。 | %SPEECH_ON%请放心，我现在所提供的报酬对于你的工作来说是非常不错的。} ";
				this.Contract.m.Payment.IsNegotiating = true;
			}
			else if (this.Contract.m.Payment.IsFinal)
			{
				this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%我拒绝再为此付出更多的报酬。 | %SPEECH_START%要理性一些。  | %SPEECH_START%不，不，不。 | %SPEECH_START%你觉得你是谁？我告诉你，如何支付报酬是我决定的。  | 他只是严肃地看着你，摇了摇头。%SPEECH_ON% | %SPEECH_START%不可能！%SPEECH_OFF%他愤怒地大吼。%SPEECH_ON% | %SPEECH_START%不，你已经得到的比你应得的更多了。 | %SPEECH_START%不。不要把我逼急了！ | %SPEECH_START%我认为你还没有完全理解这个问题的运作方式。如果你想要钱，我们需得达成协议。我的报价仍然有效。}";
			}
			else
			{
				this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%就这样了? | 他深呼吸了一口气。%SPEECH_ON% | 他叹了口气。%SPEECH_ON% | %SPEECH_START%行吧。  | %SPEECH_START%好吧，好吧。 | %SPEECH_START%如果一定要这样的话。 | %SPEECH_START%行吧，这样可以吗？ | %SPEECH_START%行，行。我理解。 | %SPEECH_START%这还算合理。 | %SPEECH_START%有趣。我觉得这样比较合适。 | %SPEECH_START%这样如何？ | %SPEECH_START%让我报下价吧。 | %SPEECH_ON%可以。这样你就接受了？ | %SPEECH_START%好吧。鉴于你的要求，这是我新的报价  | %SPEECH_START%让我们快点结束吧。这是我的新报价。 | %SPEECH_START%我们朋友一场，对吧？让我想想……}";
			}

			if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance == 0 && this.Contract.m.Payment.Count == 0)
			{
				this.Text += "合同完成后 {你会得到 | 你会收到 | 我会给你} %reward_completion% 克朗。%SPEECH_OFF%";
			}
			else if (this.Contract.m.Payment.Completion == 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count == 0)
			{
				this.Text += "{你会得到 | 你会收到 | 我会给你}共%reward_advance% 克朗的预付款。%SPEECH_OFF%";
			}
			else if (this.Contract.m.Payment.Completion == 0 && this.Contract.m.Payment.Advance == 0 && this.Contract.m.Payment.Count != 0)
			{
				this.Text += "每带回一个人头 {你会得到 | 你会收到 | 我会给你} %reward_count% 克朗, {我最多收 %maxcount% 个头 | 我最多给你 %maxcount% 个头的钱 }。%SPEECH_OFF%";
			}
			else if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count == 0)
			{
				this.Text += "{你会得到 | 你会收到 | 我会给你} %reward_advance% 克朗的预付款, 并且当你完成后再付 %reward_completion% 克朗。%SPEECH_OFF%";
			}
			else if (this.Contract.m.Payment.Completion == 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count != 0)
			{
				this.Text += "{你会得到 | 你会收到 | 我会给你}共%reward_advance% 克朗的预付款, 并且每带回一个人头 {你会再得到 | 你会再收到 | 我会再给你} %reward_count% 克朗, {我最多收 %maxcount% 个头 | 我最多给你 %maxcount% 个头的钱 }。%SPEECH_OFF%";
			}
			else if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance == 0 && this.Contract.m.Payment.Count != 0)
			{
				this.Text += "每带回一个人头 {你会得到 | 你会收到 | 我会给你} %reward_count% 克朗, {我最多收 %maxcount% 个头 | 我最多给你 %maxcount% 个头的钱 }。合同完成后 {你会再得到 | 你会再收到 | 我会再给你} %reward_completion% 克朗。%SPEECH_OFF%";
			}
			else if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count != 0)
			{
				this.Text += "{你会得到 | 你会收到 | 我会给你} %reward_advance% 克朗的预付款, 并且每带回一个人头 {你会得到 | 你会收到 | 我会给你} %reward_count% 克朗, {我最多收 %maxcount% 个头 | 我最多给你 %maxcount% 个头的钱 }。合同完成后 {你会再得到 | 你会再收到 | 我会再给你} %reward_completion% 克朗。%SPEECH_OFF%";
			}
			else
			{
				this.Text += "你什么也得不到。 你希望这样吗？%SPEECH_OFF%";
			}
		}

	},
	{
		ID = "Negotiation.Fail",
		Title = "谈判",
		Text = "[img]gfx/ui/events/event_74.png[/img]{%SPEECH_START%你们行事就好像只有你们会卖命一样。看来我还是去其他地方找人好了。再见。%SPEECH_OFF% | %SPEECH_START%我的耐心也是有限度的，我认为我在这里浪费时间了。%SPEECH_OFF% | %SPEECH_START%我真的受够了！我相信我会找到其他人来干这个活儿！%SPEECH_OFF% | %SPEECH_START%不要侮辱我的智商！忘掉这个合同，咱们到此为止。%SPEECH_OFF% | 他气得面红耳赤。%SPEECH_ON%滚开这里，我还没有和贪婪之辈做交易的习惯！%SPEECH_OFF% | 他叹了口气。%SPEECH_ON%算了吧……我一开始就不应该信任你们。让我自己找些更靠谱的人吧。%SPEECH_OFF% | %SPEECH_START%我当真还以为咱俩关系还不错。但这已经超出我的极限了。我觉得这不行，拉倒吧。%SPEECH_OFF% | %SPEECH_START%这真是浪费时间。要是没想明白就别再来找我了。%SPEECH_OFF%}",
		Image = "",
		List = [],
		ShowEmployer = true,
		ShowDifficulty = true,
		Options = [
			{
				Text = "我们不会为了微薄的报酬而冒生命危险…",
				function getResult()
				{
					this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationContractNegotiationsFail, "合同谈判搞砸了");
					this.World.Contracts.removeContract(this.Contract);
					return 0;
				}

			}
		]
	}
];
gt.Const.Contracts.NegotiationPerHeadAtDestination <- [
	{
		ID = "Negotiation",
		Title = "谈判",
		Text = "",
		Image = "",
		List = [],
		ShowEmployer = true,
		ShowDifficulty = true,
		Options = [],
		function start()
		{
			this.Options = [];
			this.Options.push({
				Text = "我接受你的提议。",
				function getResult()
				{
					this.Contract.m.BulletpointsPayment = [];

					if (this.Contract.m.Payment.Advance != 0)
					{
						this.Contract.m.BulletpointsPayment.push("得到" + this.Contract.m.Payment.getInAdvance() + "克朗预付款。");
					}

					if (this.Contract.m.Payment.Count != 0)
					{
						this.Contract.m.BulletpointsPayment.push("得到" + this.Contract.m.Payment.getPerCount() + "克朗，为你抵达时的每个人头，最多" + this.Contract.m.Payment.MaxCount + "个。");
					}

					if (this.Contract.m.Payment.Completion != 0)
					{
						this.Contract.m.BulletpointsPayment.push("得到" + this.Contract.m.Payment.getOnCompletion() + "克朗当合同完成时。");
					}

					return "Overview";
				}

			});
			this.Options.push({
				Text = "我们需要更多的报酬。",
				function getResult()
				{
					if (!this.World.Retinue.hasFollower("follower.negotiator"))
					{
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
					}

					this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

					if (this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance)
					{
						return "Negotiation.Fail";
					}

					if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance)
					{
						this.Contract.m.Payment.IsFinal = true;
					}
					else
					{
						this.Contract.m.Payment.IsFinal = false;
						this.Contract.m.Payment.Pool = this.Contract.m.Payment.Pool * (1.0 + this.Math.rand(3, 10) * 0.01);
					}

					return "Negotiation";
				}

			});

			if (this.Contract.m.Payment.Count < 1.0)
			{
				this.Options.push({
					Text = this.Contract.m.Payment.Count == 0 ? "我们需要按照我们带来的人头数付款。" : "我们需要为我们带来的每个人头数付更多的款。",
					function getResult()
					{
						this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

						if (this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance)
						{
							return "Negotiation.Fail";
						}

						if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance)
						{
							this.Contract.m.Payment.IsFinal = true;
						}
						else
						{
							this.Contract.m.Payment.IsFinal = false;

							if (this.Contract.m.Payment.Completion > 0 && this.Contract.m.Payment.Advance > 0)
							{
								this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.125);
								this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.125);
							}
							else if (this.Contract.m.Payment.Advance > 0)
							{
								this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.25);
							}
							else
							{
								this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.25);
							}

							this.Contract.m.Payment.Count = this.Math.minf(1.0, this.Contract.m.Payment.Count + 0.25);
						}

						return "Negotiation";
					}

				});
			}

			if (this.Contract.m.Payment.Advance < 1.0)
			{
				this.Options.push({
					Text = this.Contract.m.Payment.Advance == 0 ? "我们需要预付款。" : "我们需要更多的预付款。",
					function getResult()
					{
						this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

						if (this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance)
						{
							return "Negotiation.Fail";
						}

						if (this.Contract.m.Payment.Advance >= this.World.Assets.m.AdvancePaymentCap || this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance)
						{
							this.Contract.m.Payment.IsFinal = true;
						}
						else
						{
							this.Contract.m.Payment.IsFinal = false;

							if (this.Contract.m.Payment.Completion > 0 && this.Contract.m.Payment.Count > 0)
							{
								this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.125);
								this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.125);
							}
							else if (this.Contract.m.Payment.Count > 0)
							{
								this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.25);
							}
							else
							{
								this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.25);
							}

							this.Contract.m.Payment.Advance = this.Math.minf(1.0, this.Contract.m.Payment.Advance + 0.25);
						}

						return "Negotiation";
					}

				});
			}

			if (this.Contract.m.Payment.Completion < 1.0)
			{
				this.Options.push({
					Text = this.Contract.m.Payment.Completion == 0 ? "我们需要在工作完成后得到报酬。" : "我们需要在工作完成后得到更多报酬。",
					function getResult()
					{
						this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

						if (this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance)
						{
							return "Negotiation.Fail";
						}

						if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance)
						{
							this.Contract.m.Payment.IsFinal = true;
						}
						else
						{
							this.Contract.m.Payment.IsFinal = false;

							if (this.Contract.m.Payment.Advance > 0 && this.Contract.m.Payment.Count > 0)
							{
								this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.125);
								this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.125);
							}
							else if (this.Contract.m.Payment.Count > 0)
							{
								this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.25);
							}
							else
							{
								this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.25);
							}

							this.Contract.m.Payment.Completion = this.Math.minf(1.0, this.Contract.m.Payment.Completion + 0.25);
						}

						return "Negotiation";
					}

				});
			}

			this.Options.push({
				Text = "算了吧，这不值得。",
				function getResult()
				{
					this.World.Contracts.removeContract(this.Contract);
					this.World.State.getTownScreen().updateContracts();
					return 0;
				}

			});

			if (!this.Contract.m.Payment.IsNegotiating)
			{
				this.Text = "[img]gfx/ui/events/event_04.png[/img]{他点了点头。%SPEECH_ON%好的。很好。我想的就是提前给你们报酬。 | 他笑了笑。%SPEECH_ON%朋友，你们很快就能发大财了。 | 他深呼吸了一口气。%SPEECH_ON%非常好，这是我准备给你的报价。 | 他手放在你肩头，微笑中透着肯定。%SPEECH_ON%我想我知道一个适当的报酬来支付你的服务。 | 他用手做出手势，指着手指好像在数些什么，但对你来说没有任何意义。%SPEECH_ON%根据经验来看，这对这项任务来说是很好的报酬。 | 他点了点头。%SPEECH_ON%你看起来挺有能力的，我愿意慷慨解囊。 | 他晃动着一袋硬币。%SPEECH_ON%如果你能帮我处理这件事，这些硬币就是你的了。 | 他摊开了双手。%SPEECH_ON%我现在手头比较紧，所以在你问之前，这就是我现在所有的钱了。 | %SPEECH_ON%请放心，我现在所提供的报酬对于你的工作来说是非常不错的。} ";
				this.Contract.m.Payment.IsNegotiating = true;
			}
			else if (this.Contract.m.Payment.IsFinal)
			{
				this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%我拒绝再为此付出更多的报酬。 | %SPEECH_START%要理性一些。  | %SPEECH_START%不，不，不。 | %SPEECH_START%你觉得你是谁？我告诉你，如何支付报酬是我决定的。  | 他只是严肃地看着你，摇了摇头。%SPEECH_ON% | %SPEECH_START%不可能！%SPEECH_OFF%他愤怒地大吼。%SPEECH_ON% | %SPEECH_START%不，你已经得到的比你应得的更多了。 | %SPEECH_START%不。不要把我逼急了！ | %SPEECH_START%我认为你还没有完全理解这个问题的运作方式。如果你想要钱，我们需得达成协议。我的报价仍然有效。}";
			}
			else
			{
				this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%就这样了? | 他深呼吸了一口气。%SPEECH_ON% | 他叹了口气。%SPEECH_ON% | %SPEECH_START%行吧。  | %SPEECH_START%好吧，好吧。 | %SPEECH_START%如果一定要这样的话。 | %SPEECH_START%行吧，这样可以吗？ | %SPEECH_START%行，行。我理解。 | %SPEECH_START%这还算合理。 | %SPEECH_START%有趣。我觉得这样比较合适。 | %SPEECH_START%这样如何？ | %SPEECH_START%让我报下价吧。 | %SPEECH_ON%可以。这样你就接受了？ | %SPEECH_START%好吧。鉴于你的要求，这是我新的报价  | %SPEECH_START%让我们快点结束吧。这是我的新报价。 | %SPEECH_START%我们朋友一场，对吧？让我想想……}";
			}

			if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance == 0 && this.Contract.m.Payment.Count == 0)
			{
				this.Text += "合同完成后 {你会得到 | 你会收到 | 我会给你} %reward_completion% 克朗。%SPEECH_OFF%";
			}
			else if (this.Contract.m.Payment.Completion == 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count == 0)
			{
				this.Text += "{你会得到 | 你会收到 | 我会给你}共%reward_advance% 克朗的预付款。%SPEECH_OFF%";
			}
			else if (this.Contract.m.Payment.Completion == 0 && this.Contract.m.Payment.Advance == 0 && this.Contract.m.Payment.Count != 0)
			{
				this.Text += "每带来一个人头 {你会得到 | 你会收到 | 我会给你} %reward_count% 克朗, {我最多收 %maxcount% 个头 | 我最多给你 %maxcount% 个头的钱 }。%SPEECH_OFF%";
			}
			else if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count == 0)
			{
				this.Text += "{你会得到 | 你会收到 | 我会给你} %reward_advance% 克朗的预付款, 并且当你完成后再付 %reward_completion% 克朗。%SPEECH_OFF%";
			}
			else if (this.Contract.m.Payment.Completion == 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count != 0)
			{
				this.Text += "{你会得到 | 你会收到 | 我会给你}共 %reward_advance% 克朗的预付款, 每带回一个人头 {你会再得到 | 你会再收到 | 我会再给你} %reward_count% 克朗, {我最多收 %maxcount% 个头 | 我最多给你 %maxcount% 个头的钱 }。%SPEECH_OFF%";
			}
			else if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance == 0 && this.Contract.m.Payment.Count != 0)
			{
				this.Text += "每带来一个人头 {你会得到 | 你会收到 | 我会给你} %reward_count% 克朗, {我最多收 %maxcount% 个头 | 我最多给你 %maxcount% 个头的钱 }。合同完成后 {你会再得到 | 你会再收到 | 我会再给你} %reward_completion% 克朗。%SPEECH_OFF%";
			}
			else if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count != 0)
			{
				this.Text += "{你会得到 | 你会收到 | 我会给你}共 %reward_advance% 克朗的预付款, 每带来一个人头 {你会再得到 | 你会再收到 | 我会再给你} %reward_count% 克朗, {我最多收 %maxcount% 个头 | 我最多给你 %maxcount% 个头的钱 }, 合同完成后 {你会再得到 | 你会再收到 | 我会再给你} %reward_completion% 克朗。%SPEECH_OFF%";
			}
			else
			{
				this.Text += "你什么也得不到。 你希望这样吗？%SPEECH_OFF%";
			}
		}

	},
	{
		ID = "Negotiation.Fail",
		Title = "谈判",
		Text = "[img]gfx/ui/events/event_74.png[/img]{%SPEECH_START%你们行事就好像只有你们会卖命一样。看来我还是去其他地方找人好了。再见。%SPEECH_OFF% | %SPEECH_START%我的耐心也是有限度的，我认为我在这里浪费时间了。%SPEECH_OFF% | %SPEECH_START%我真的受够了！我相信我会找到其他人来干这个活儿！%SPEECH_OFF% | %SPEECH_START%不要侮辱我的智商！忘掉这个合同，咱们到此为止。%SPEECH_OFF% | 他气得面红耳赤。%SPEECH_ON%滚开这里，我还没有和贪婪之辈做交易的习惯！%SPEECH_OFF% | 他叹了口气。%SPEECH_ON%算了吧……我一开始就不应该信任你们。让我自己找些更靠谱的人吧。%SPEECH_OFF% | %SPEECH_START%我当真还以为咱俩关系还不错。但这已经超出我的极限了。我觉得这不行，拉倒吧。%SPEECH_OFF% | %SPEECH_START%这真是浪费时间。要是没想明白就别再来找我了。%SPEECH_OFF%}",
		Image = "",
		List = [],
		ShowEmployer = true,
		ShowDifficulty = true,
		Options = [
			{
				Text = "我们不会为了微薄的报酬而冒生命危险…",
				function getResult()
				{
					this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationContractNegotiationsFail, "合同谈判搞砸了");
					this.World.Contracts.removeContract(this.Contract);
					return 0;
				}

			}
		]
	}
];

