this.cultists_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.cultists_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_71.png[/img]%SPEECH_ON%我将妻子和孩子放到了谷仓中，你去看的话现在应该只有灰了。他并不追寻她们的痛苦，所以我将她们打晕了。也请不要沉溺在失去她们的痛苦之中，她们现在和他在一起了，随着她们过世，我也从所有义务中解放出来，去完成必须完成之事。过去之我已消亡，我将担任一个新的角色，得到一张新的面孔，在两者作用之下我将不再是原来的我。我将隐藏。也将表演，但最终只有一个目的。而你知道这个目的是什么。我不得言说它，但是当你意识到没有人真正相信他们会死亡时，你就会发现它。一个人纯洁的自我毁灭必须笼罩在欢庆与愉悦之中。不是所有人都能看到他，也不是所有人都应该看到他，但是所有人终将会看到他。\n\n祝平安，你们所成之陌生之人，达库尔等候着我们所有人。%SPEECH_OFF%",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "达库尔在等候着。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "邪教徒";
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

