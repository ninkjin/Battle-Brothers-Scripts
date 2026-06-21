this.steppe_brush <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "灌木丛";
	}

	function getDescription()
	{
		return "茂密的灌木丛，阻挡了移动和视野。";
	}

	function onInit()
	{
		local body = this.addSprite("body");
		body.setBrush("steppe_brush_0" + this.Math.rand(1, 3));
		body.setHorizontalFlipping(this.Math.rand(0, 100) < 50);
		body.varyColor(0.07, 0.07, 0.07);
		body.Scale = 0.9 + this.Math.rand(0, 10) / 100.0;
		body.Rotation = this.Math.rand(-5, 5);
		this.setSpriteOcclusion("body", 1, -2, -2);
		this.setBlockSight(true);
	}

});

