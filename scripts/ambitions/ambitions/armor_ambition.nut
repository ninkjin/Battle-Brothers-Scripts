this.armor_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.armor";
		this.m.Duration = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "我们会装备一支至少三人的重甲部队，作为防御危险对手的堡垒。";
		this.m.UIText = "拥有3件230+耐久的盔甲和头盔";
		this.m.TooltipText = "拥有3件盔甲和3个头盔，每件装备都有230或以上的耐久。 不管你是买它们还是从战场上掠夺它们，它们都会相当好地保护你的人。";
		this.m.SuccessText = "[img]gfx/ui/events/event_35.png[/img]精神振奋，获得更多的重型盔甲和头盔是我们 %companyname%。%SPEECH_ON%感觉到了吗？这就是手艺。%SPEECH_OFF%%randombrother% 说着，用一个硬木鞍子敲打着他兄弟的新盔甲头。%SPEECH_ON%想想我们以前因为破烂的盔甲和可怜的装备而错过的那些高薪合同吧。%SPEECH_OFF%从现在起，后防线可以在战斗中轻松呼吸，因为他们知道他们的重装甲兄弟将在那里承受攻击的冲击。 一旦他们倒下，他们笨重的身躯至少会耽误敌人，给他们的轻甲同伴一个迅速撤退的机会。";
		this.m.SuccessButtonText = "这将在今后的战斗中对我们大有好处。";
	}

	function getArmor()
	{
		local ret = {
			Armor = 0,
			Helmet = 0
		};
		local items = this.World.Assets.getStash().getItems();

		foreach( item in items )
		{
			if (item != null)
			{
				if (item.isItemType(this.Const.Items.ItemType.Armor) && item.getArmorMax() >= 230)
				{
					++ret.Armor;
				}
				else if (item.isItemType(this.Const.Items.ItemType.Helmet) && item.getArmorMax() >= 230)
				{
					++ret.Helmet;
				}
			}
		}

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Head);

			if (item != null)
			{
				if (item.getArmorMax() >= 230)
				{
					++ret.Helmet;
				}
			}

			item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body);

			if (item != null)
			{
				if (item.getArmorMax() >= 230)
				{
					++ret.Armor;
				}
			}
		}

		return ret;
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days <= 40)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		local armor = this.getArmor();

		if (armor.Armor >= 3 || armor.Helmet >= 3)
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		local armor = this.getArmor();

		if (armor.Armor >= 3 && armor.Helmet >= 3)
		{
			return true;
		}

		return false;
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
	}

});

