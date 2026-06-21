this.destroyed_greenskin_catapult <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "被毁的绿皮攻城车";
	}

	function getDescription()
	{
		return "这个绿皮攻城车已经被弄的无法使用。";
	}

	function onInit()
	{
		local flip = false;
		local bottom = this.addSprite("bottom");
		bottom.setBrush("greenskin_catapult_destroyed_bottom");
		local top = this.addSprite("top");
		top.setBrush("greenskin_catapult_destroyed_top");
		this.setSpriteOcclusion("top", 1, 2, -3);
		this.setBlockSight(false);
	}

	function isDying()
	{
		return true;
	}

});

