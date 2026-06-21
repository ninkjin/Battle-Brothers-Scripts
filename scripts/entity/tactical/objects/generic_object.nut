this.generic_object <- this.inherit("scripts/entity/tactical/entity", {
	m = {
		Name = "",
		Description = "",
		OnlyVisibleWhenCameraIsFlipped = false
	},
	function getName()
	{
		return this.m.Name;
	}

	function getDescription()
	{
		return this.m.Description;
	}

	function setName( _n )
	{
		this.m.Name = _n;
	}

	function setDescription( _d )
	{
		this.m.Description = _d;
	}

	function setVisibleOnCameraFlip( _f )
	{
		this.m.OnlyVisibleWhenCameraIsFlipped = _f;
	}

	function onInit()
	{
		this.setRenderCallbackEnabled(true);
	}

	function onRender()
	{
		local b = this.getSprite("body");

		if (this.m.OnlyVisibleWhenCameraIsFlipped)
		{
			b.Visible = this.Tactical.getCamera().IsFlipped;
		}
		else
		{
			b.Visible = !this.Tactical.getCamera().IsFlipped;
		}

		if (b.Visible && this.m.OnlyVisibleWhenCameraIsFlipped)
		{
			this.logInfo("镜子出现了！");
		}
	}

});

