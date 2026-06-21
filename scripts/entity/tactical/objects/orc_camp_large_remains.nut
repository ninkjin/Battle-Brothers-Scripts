this.orc_camp_large_remains <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "可怕的展示";
	}

	function getDescription()
	{
		return "正在展示中的剥下的皮和掏出的肠子。";
	}

	function onInit()
	{
		local flip = this.Math.rand(0, 1) == 1;
		local bottom = this.addSprite("bottom");
		bottom.setBrush("orcs_11_bottom");
		bottom.setHorizontalFlipping(flip);
		local top = this.addSprite("top");
		top.setBrush("orcs_11_top");
		top.setHorizontalFlipping(flip);
		this.setSpriteOcclusion("top", 1, 2, -3);
		this.setBlockSight(false);
	}

});

