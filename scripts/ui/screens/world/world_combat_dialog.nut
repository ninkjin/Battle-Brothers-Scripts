this.world_combat_dialog <- {
	m = {
		JSHandle = null,
		Visible = null,
		Animating = null,
		OnConnectedListener = null,
		OnDisconnectedListener = null,
		OnEngageButtonPressedListener = null,
		OnCancelButtonPressedListener = null
	},
	function isVisible()
	{
		return this.m.Visible != null && this.m.Visible == true;
	}

	function isAnimating()
	{
		if (this.m.Animating != null)
		{
			return this.m.Animating == true;
		}
		else
		{
			return false;
		}
	}

	function setOnConnectedListener( _listener )
	{
		this.m.OnConnectedListener = _listener;
	}

	function setOnDisconnectedListener( _listener )
	{
		this.m.OnDisconnectedListener = _listener;
	}

	function setOnEngageButtonPressedListener( _listener )
	{
		this.m.OnEngageButtonPressedListener = _listener;
	}

	function setOnCancelButtonPressedListener( _listener )
	{
		this.m.OnCancelButtonPressedListener = _listener;
	}

	function clearEventListener()
	{
		this.m.OnConnectedListener = null;
		this.m.OnDisconnectedListener = null;
		this.m.OnEngageButtonPressedListener = null;
		this.m.OnCancelButtonPressedListener = null;
	}

	function create()
	{
		this.m.Visible = false;
		this.m.Animating = false;
		this.m.JSHandle = this.UI.connect("WorldCombatDialog", this);
	}

	function destroy()
	{
		this.clearEventListener();
		this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
	}

	function show( _entities, _allyBanners, _enemyBanners, _allowDisengage, _allowFormationPicking, _text, _image, _disengageText = "取消" )
	{
		for( local i = 0; i < _allyBanners.len(); i = ++i )
		{
			for( local j = _allyBanners.len() - 1; i >= 0; j = --j )
			{
				if (j <= i)
				{
					break;
				}

				if (_allyBanners[i] == _allyBanners[j])
				{
					_allyBanners.remove(j);
				}
			}
		}

		for( local i = 0; i < _enemyBanners.len(); i = ++i )
		{
			for( local j = _enemyBanners.len() - 1; i >= 0; j = --j )
			{
				if (j <= i)
				{
					break;
				}

				if (_enemyBanners[i] == _enemyBanners[j])
				{
					_enemyBanners.remove(j);
				}
			}
		}

		local data = {
			Entities = _entities,
			AllyBanners = _allyBanners,
			EnemyBanners = _enemyBanners,
			AllowDisengage = _allowDisengage,
			AllowFormationPicking = _allowFormationPicking,
			Text = _text,
			DisengageText = _disengageText,
			Image = _image
		};

		if (!this.isVisible() && !this.isAnimating())
		{
			this.m.JSHandle.asyncCall("show", data);
			this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _t )
			{
				this.Tooltip.hide();
			}, null);
		}
	}

	function hide()
	{
		if (this.isVisible() && !this.isAnimating())
		{
			this.m.JSHandle.asyncCall("hide", null);
		}
	}

	function onScreenConnected()
	{
		if (this.m.OnConnectedListener != null)
		{
			this.m.OnConnectedListener();
		}
	}

	function onScreenDisconnected()
	{
		if (this.m.OnDisconnectedListener != null)
		{
			this.m.OnDisconnectedListener();
		}
	}

	function onEngageButtonPressed()
	{
		if (this.m.OnEngageButtonPressedListener != null)
		{
			this.m.OnEngageButtonPressedListener();
		}
	}

	function onCancelButtonPressed()
	{
		if (this.m.OnCancelButtonPressedListener != null)
		{
			this.m.OnCancelButtonPressedListener();
		}
	}

	function onScreenShown()
	{
		this.Tooltip.hide();
		this.m.Visible = true;
		this.m.Animating = false;
	}

	function onScreenHidden()
	{
		this.m.Visible = false;
		this.m.Animating = false;
	}

	function onScreenAnimating()
	{
		this.m.Animating = true;
	}

};

