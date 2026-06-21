this.autumn_tree1 <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "树";
	}

	function getDescription()
	{
		return "一棵高大纤细的桦树，叶子正开始变成棕色和红色。";
	}

	function onInit()
	{
		local hasLeaves = this.Math.rand(1, 100) <= 90;
		local scale = 0.85 + this.Math.rand(0, 15) / 100.0;
		local flip = this.Math.rand(0, 1) == 1;
		local v = this.Math.rand(1, 1);
		local rotation = this.Math.rand(-3, 3);
		local bottom = this.addSprite("bottom");
		bottom.setBrush("tree_autumn_0" + v + "_bottom");
		bottom.setHorizontalFlipping(flip);
		bottom.Rotation = rotation;
		bottom.Scale = scale;
		local middle = this.addSprite("middle");
		middle.setBrush("tree_autumn_0" + v + "_middle");
		middle.setHorizontalFlipping(flip);
		middle.Rotation = rotation;
		middle.Scale = scale;

		if (hasLeaves)
		{
			local top = this.addSprite("top");
			top.setBrush("tree_autumn_0" + v + "_top");
			top.setHorizontalFlipping(flip);
			top.Rotation = rotation;
			top.Scale = scale;
			top.varyColor(0.25, 0.25, 0.25);
			this.setSpriteOcclusion("top", 1, 2, -3);
		}

		local web = this.addSprite("web");
		web.setBrush("web_03");
		web.setHorizontalFlipping(this.Math.rand(0, 100) < 50);
		web.Scale = bottom.Scale * 0.9;
		web.Visible = false;
		this.setSpriteOcclusion("middle", 1, 2, -3);
		this.setBlockSight(true);
	}

});

