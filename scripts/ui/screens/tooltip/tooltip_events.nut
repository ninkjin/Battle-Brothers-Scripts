this.tooltip_events <- {
	m = {},
	function create()
	{
	}

	function destroy()
	{
	}

	function onQueryTileTooltipData()
	{
		if (this.Tactical.isActive())
		{
			return this.TooltipEvents.tactical_queryTileTooltipData();
		}
		else
		{
			return this.TooltipEvents.strategic_queryTileTooltipData();
		}
	}

	function onQueryEntityTooltipData( _entityId, _isTileEntity )
	{
		if (this.Tactical.isActive())
		{
			return this.TooltipEvents.tactical_queryEntityTooltipData(_entityId, _isTileEntity);
		}
		else
		{
			return this.TooltipEvents.strategic_queryEntityTooltipData(_entityId, _isTileEntity);
		}
	}

	function onQueryRosterEntityTooltipData( _entityId )
	{
		local entity = this.Tactical.getEntityByID(_entityId);

		if (entity != null)
		{
			return entity.getRosterTooltip();
		}

		return null;
	}

	function onQuerySkillTooltipData( _entityId, _skillId )
	{
		return this.TooltipEvents.general_querySkillTooltipData(_entityId, _skillId);
	}

	function onQueryStatusEffectTooltipData( _entityId, _statusEffectId )
	{
		return this.TooltipEvents.general_queryStatusEffectTooltipData(_entityId, _statusEffectId);
	}

	function onQuerySettlementStatusEffectTooltipData( _statusEffectId )
	{
		return this.TooltipEvents.general_querySettlementStatusEffectTooltipData(_statusEffectId);
	}

	function onQueryUIItemTooltipData( _entityId, _itemId, _itemOwner )
	{
		if (this.Tactical.isActive())
		{
			return this.TooltipEvents.tactical_queryUIItemTooltipData(_entityId, _itemId, _itemOwner);
		}
		else
		{
			return this.TooltipEvents.strategic_queryUIItemTooltipData(_entityId, _itemId, _itemOwner);
		}
	}

	function onQueryUIPerkTooltipData( _entityId, _perkId )
	{
		return this.TooltipEvents.general_queryUIPerkTooltipData(_entityId, _perkId);
	}

	function onQueryUIElementTooltipData( _entityId, _elementId, _elementOwner )
	{
		return this.TooltipEvents.general_queryUIElementTooltipData(_entityId, _elementId, _elementOwner);
	}

	function onQueryFollowerTooltipData( _followerID )
	{
		if (typeof _followerID == "integer")
		{
			local renown = "\'" + this.Const.Strings.BusinessReputation[this.Const.FollowerSlotRequirements[_followerID]] + "\' (" + this.Const.BusinessReputation[this.Const.FollowerSlotRequirements[_followerID]] + ")";
			local ret = [
				{
					id = 1,
					type = "title",
					text = "锁定座位"
				},
				{
					id = 4,
					type = "description",
					text = "你的战团名声不够，无法雇佣更多的非战斗跟随者。至少需要获得" + renown + "声望以解锁此席位。通过完成野心和合同以及赢得战斗而获得声望。"
				}
			];
			return ret;
		}
		else if (_followerID == "free")
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = "自由座位"
				},
				{
					id = 4,
					type = "description",
					text = "这里有空间添加另一个非战斗追随者到你的战队。"
				},
				{
					id = 1,
					type = "hint",
					icon = "ui/icons/mouse_left_button.png",
					text = "打开雇佣界面"
				}
			];
			return ret;
		}
		else
		{
			local p = this.World.Retinue.getFollower(_followerID);
			return p.getTooltip();
		}
	}

	function tactical_queryTileTooltipData()
	{
		local lastTileHovered = this.Tactical.State.getLastTileHovered();

		if (lastTileHovered == null)
		{
			return null;
		}

		if (!lastTileHovered.IsDiscovered)
		{
			return null;
		}

		if (lastTileHovered.IsDiscovered && !lastTileHovered.IsEmpty && (!lastTileHovered.IsOccupiedByActor || lastTileHovered.IsVisibleForPlayer))
		{
			local entity = lastTileHovered.getEntity();
			return this.tactical_helper_getEntityTooltip(entity, this.Tactical.TurnSequenceBar.getActiveEntity(), true);
		}
		else
		{
			local tooltipContent = [
				{
					id = 1,
					type = "title",
					text = this.Const.Strings.Tactical.TerrainName[lastTileHovered.Subtype],
					icon = "ui/tooltips/height_" + lastTileHovered.Level + ".png"
				}
			];
			tooltipContent.push({
				id = 2,
				type = "description",
				text = this.Const.Strings.Tactical.TerrainDescription[lastTileHovered.Subtype]
			});

			if (lastTileHovered.IsCorpseSpawned)
			{
				tooltipContent.push({
					id = 3,
					type = "description",
					text = lastTileHovered.Properties.get("Corpse").CorpseName + "在这里被杀。"
				});
			}

			if (this.Tactical.TurnSequenceBar.getActiveEntity() != null)
			{
				local actor = this.Tactical.TurnSequenceBar.getActiveEntity();

				if (actor.isPlacedOnMap() && actor.isPlayerControlled())
				{
					if (this.Math.abs(lastTileHovered.Level - actor.getTile().Level) == 1)
					{
						tooltipContent.push({
							id = 90,
							type = "text",
							text = "消耗[b][color=" + this.Const.UI.Color.PositiveValue + "]" + actor.getActionPointCosts()[lastTileHovered.Type] + "+" + actor.getLevelActionPointCost() + "[/color][/b] AP 和 [b][color=" + this.Const.UI.Color.PositiveValue + "]" + actor.getFatigueCosts()[lastTileHovered.Type] + "+" + actor.getLevelFatigueCost() + "[/color][/b]疲劳移动(因为处于不同的高度)"
						});
					}
					else
					{
						tooltipContent.push({
							id = 90,
							type = "text",
							text = "消耗[b][color=" + this.Const.UI.Color.PositiveValue + "]" + actor.getActionPointCosts()[lastTileHovered.Type] + "[/color][/b] AP 和 [b][color=" + this.Const.UI.Color.PositiveValue + "]" + actor.getFatigueCosts()[lastTileHovered.Type] + "[/color][/b]疲劳移动"
						});
					}
				}
			}

			foreach( i, line in this.Const.Tactical.TerrainEffectTooltip[lastTileHovered.Type] )
			{
				tooltipContent.push(line);
			}

			if (lastTileHovered.IsHidingEntity)
			{
				tooltipContent.push({
					id = 98,
					type = "text",
					icon = "ui/icons/vision.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]远处的人无法看到这里是否有人躲藏在内。[/color]"
				});
			}

			local allies;

			if (this.Tactical.State.isScenarioMode())
			{
				allies = this.Const.FactionAlliance[this.Const.Faction.Player];
			}
			else
			{
				allies = this.World.FactionManager.getAlliedFactions(this.Const.Faction.Player);
			}

			if (lastTileHovered.IsVisibleForPlayer && lastTileHovered.hasZoneOfControlOtherThan(allies))
			{
				tooltipContent.push({
					id = 99,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]处于敌方的控制区域[/color]"
				});
			}

			if (lastTileHovered.IsVisibleForPlayer && (lastTileHovered.SquareCoords.X == 0 || lastTileHovered.SquareCoords.Y == 0 || lastTileHovered.SquareCoords.X == 31 || lastTileHovered.SquareCoords.Y == 31))
			{
				tooltipContent.push({
					id = 99,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]此方格上的任何角色都可以安全、立即地撤退。[/color]"
				});
			}

			if (lastTileHovered.IsVisibleForPlayer && lastTileHovered.Properties.Effect != null)
			{
				tooltipContent.push({
					id = 100,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + lastTileHovered.Properties.Effect.Tooltip + "[/color]"
				});
			}

			if (lastTileHovered.Items != null)
			{
				local result = [];

				foreach( item in lastTileHovered.Items )
				{
					result.push(item.getIcon());
				}

				if (result.len() > 0)
				{
					tooltipContent.push({
						id = 100,
						type = "icons",
						useItemPath = true,
						icons = result
					});
				}
			}

			return tooltipContent;
		}
	}

	function tactical_queryEntityTooltipData( _entityId, _isTileEntity )
	{
		local entity = this.Tactical.getEntityByID(_entityId);

		if (entity != null)
		{
			return this.tactical_helper_getEntityTooltip(entity, this.Tactical.TurnSequenceBar.getActiveEntity(), _isTileEntity);
		}

		return null;
	}

	function tactical_queryUIItemTooltipData( _entityId, _itemId, _itemOwner )
	{
		local entity = this.Tactical.getEntityByID(_entityId);
		local activeEntity = this.Tactical.TurnSequenceBar.getActiveEntity();

		switch(_itemOwner)
		{
		case "entity":
			if (entity != null)
			{
				local item = entity.getItems().getItemByInstanceID(_itemId);

				if (item != null)
				{
					return this.tactical_helper_addHintsToTooltip(activeEntity, entity, item, _itemOwner);
				}
			}

			return null;

		case "ground":
		case "character-screen-inventory-list-module.ground":
			if (entity != null)
			{
				local item = this.tactical_helper_findGroundItem(entity, _itemId);

				if (item != null)
				{
					return this.tactical_helper_addHintsToTooltip(activeEntity, entity, item, _itemOwner);
				}
			}

			return null;

		case "stash":
		case "character-screen-inventory-list-module.stash":
			local result = this.Stash.getItemByInstanceID(_itemId);

			if (result != null)
			{
				return this.tactical_helper_addHintsToTooltip(activeEntity, entity, result.item, _itemOwner);
			}

			return null;

		case "tactical-combat-result-screen.stash":
			local result = this.Stash.getItemByInstanceID(_itemId);

			if (result != null)
			{
				return this.tactical_helper_addHintsToTooltip(activeEntity, entity, result.item, _itemOwner, true);
			}

			return null;

		case "tactical-combat-result-screen.found-loot":
			local result = this.Tactical.CombatResultLoot.getItemByInstanceID(_itemId);

			if (result != null)
			{
				return this.tactical_helper_addHintsToTooltip(activeEntity, entity, result.item, _itemOwner, true);
			}

			return null;
		}

		return null;
	}

	function tactical_helper_findGroundItem( _entity, _itemId )
	{
		local items = _entity.getTile() != null ? _entity.getTile().Items : null;

		if (items != null && items.len() > 0)
		{
			foreach( item in items )
			{
				if (item.getInstanceID() == _itemId)
				{
					return item;
				}
			}
		}

		return null;
	}

	function tactical_helper_getEntityTooltip( _targetedEntity, _activeEntity, _isTileEntity )
	{
		if (this.Tactical.State != null && this.Tactical.State.getCurrentActionState() == this.Const.Tactical.ActionState.SkillSelected)
		{
			if (_activeEntity != null && this.isKindOf(_targetedEntity, "actor") && _activeEntity.isPlayerControlled() && _targetedEntity != null && !_targetedEntity.isPlayerControlled())
			{
				local skill = _activeEntity.getSkills().getSkillByID(this.Tactical.State.getSelectedSkillID());

				if (skill != null)
				{
					return this.tactical_helper_addContentTypeToTooltip(_targetedEntity, _targetedEntity.getTooltip(skill), _isTileEntity);
				}
			}

			return null;
		}

		if (this.isKindOf(_targetedEntity, "entity"))
		{
			return this.tactical_helper_addContentTypeToTooltip(_targetedEntity, _targetedEntity.getTooltip(), _isTileEntity);
		}

		return null;
	}

	function tactical_helper_addContentTypeToTooltip( _entity, _tooltip, _isTileEntity )
	{
		if (_isTileEntity == false && !_entity.isHiddenToPlayer())
		{
			_tooltip.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_left_button.png",
				text = this.Const.Strings.Tooltip.Tactical.Hint_FocusCharacter
			});
		}

		if (_isTileEntity == true)
		{
			_tooltip.push({
				contentType = "tile-entity",
				entityId = _entity.getID()
			});
		}
		else
		{
			_tooltip.push({
				contentType = "entity",
				entityId = _entity.getID()
			});
		}

		return _tooltip;
	}

	function tactical_helper_addHintsToTooltip( _activeEntity, _entity, _item, _itemOwner, _ignoreStashLocked = false )
	{
		local stashLocked = true;

		if (this.Stash != null)
		{
			stashLocked = this.Stash.isLocked();
		}

		local tooltip = _item.getTooltip();

		if (stashLocked == true && _ignoreStashLocked == false)
		{
			if (_item.isChangeableInBattle() == false)
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/icons/icon_locked.png",
					text = this.Const.Strings.Tooltip.Tactical.Hint_CannotChangeItemInCombat
				});
				return tooltip;
			}

			if (_activeEntity == null || _entity != null && _activeEntity != null && _entity.getID() != _activeEntity.getID())
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/icons/icon_locked.png",
					text = this.Const.Strings.Tooltip.Tactical.Hint_OnlyActiveCharacterCanChangeItemsInCombat
				});
				return tooltip;
			}

			if (_activeEntity != null && _activeEntity.getItems().isActionAffordable([
				_item
			]) == false)
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "没有足够的行动点来更换物品（[b][color=" + this.Const.UI.Color.NegativeValue + "]" + _activeEntity.getItems().getActionCost([
						_item
					]) + "[/color][/b] 至少)"
				});
				return tooltip;
			}
		}

		switch(_itemOwner)
		{
		case "entity":
			if (_item.getCurrentSlotType() == this.Const.ItemSlot.Bag && _item.getSlotType() != this.Const.ItemSlot.None)
			{
				if (stashLocked == true)
				{
					if (_item.getSlotType() != this.Const.ItemSlot.Bag && (_entity.getItems().getItemAtSlot(_item.getSlotType()) == null || _entity.getItems().getItemAtSlot(_item.getSlotType()) == "-1" || _entity.getItems().getItemAtSlot(_item.getSlotType()).isAllowedInBag()))
					{
						tooltip.push({
							id = 1,
							type = "hint",
							icon = "ui/icons/mouse_right_button.png",
							text = "装备物品 ([b][color=" + this.Const.UI.Color.PositiveValue + "]" + _activeEntity.getItems().getActionCost([
								_item,
								_entity.getItems().getItemAtSlot(_item.getSlotType()),
								_entity.getItems().getItemAtSlot(_item.getBlockedSlotType())
							]) + "[/color][/b] 点行动力)"
						});
					}

					tooltip.push({
						id = 2,
						type = "hint",
						icon = "ui/icons/mouse_right_button_ctrl.png",
						text = "将物品放在地上 ([b][color=" + this.Const.UI.Color.PositiveValue + "]" + _activeEntity.getItems().getActionCost([
							_item
						]) + "[/color][/b] 点行动力)"
					});
				}
				else
				{
					if (_item.getSlotType() != this.Const.ItemSlot.Bag && (_entity.getItems().getItemAtSlot(_item.getSlotType()) == null || _entity.getItems().getItemAtSlot(_item.getSlotType()) == "-1" || _entity.getItems().getItemAtSlot(_item.getSlotType()).isAllowedInBag()))
					{
						tooltip.push({
							id = 1,
							type = "hint",
							icon = "ui/icons/mouse_right_button.png",
							text = "装备物品"
						});
					}

					tooltip.push({
						id = 2,
						type = "hint",
						icon = "ui/icons/mouse_right_button_ctrl.png",
						text = "将物品放入仓库"
					});
				}
			}
			else if (stashLocked == true)
			{
				if (_item.isChangeableInBattle() && _item.isAllowedInBag() && _entity.getItems().hasEmptySlot(this.Const.ItemSlot.Bag))
				{
					tooltip.push({
						id = 1,
						type = "hint",
						icon = "ui/icons/mouse_right_button.png",
						text = "将物品放入背包中 ([b][color=" + this.Const.UI.Color.PositiveValue + "]" + _activeEntity.getItems().getActionCost([
							_item
						]) + "[/color][/b] 点行动力)"
					});
				}

				tooltip.push({
					id = 2,
					type = "hint",
					icon = "ui/icons/mouse_right_button_ctrl.png",
					text = "将物品放在地上 ([b][color=" + this.Const.UI.Color.PositiveValue + "]" + _activeEntity.getItems().getActionCost([
						_item
					]) + "[/color][/b] 点行动力)"
				});
			}
			else
			{
				if (_item.isChangeableInBattle() && _item.isAllowedInBag())
				{
					tooltip.push({
						id = 1,
						type = "hint",
						icon = "ui/icons/mouse_right_button.png",
						text = "将物品放入背包中"
					});
				}

				tooltip.push({
					id = 2,
					type = "hint",
					icon = "ui/icons/mouse_right_button_ctrl.png",
					text = "将物品放入仓库"
				});
			}

			break;

		case "ground":
		case "character-screen-inventory-list-module.ground":
			if (_item.isChangeableInBattle())
			{
				if (_item.getSlotType() != this.Const.ItemSlot.None)
				{
					tooltip.push({
						id = 1,
						type = "hint",
						icon = "ui/icons/mouse_right_button.png",
						text = "装备物品 ([b][color=" + this.Const.UI.Color.PositiveValue + "]" + _activeEntity.getItems().getActionCost([
							_item,
							_entity.getItems().getItemAtSlot(_item.getSlotType()),
							_entity.getItems().getItemAtSlot(_item.getBlockedSlotType())
						]) + "[/color][/b] 点行动力)"
					});
				}

				if (_item.isAllowedInBag())
				{
					tooltip.push({
						id = 2,
						type = "hint",
						icon = "ui/icons/mouse_right_button_ctrl.png",
						text = "将物品放入背包中 ([b][color=" + this.Const.UI.Color.PositiveValue + "]" + _activeEntity.getItems().getActionCost([
							_item
						]) + "[/color][/b] 点行动力)"
					});
				}
			}

			break;

		case "stash":
		case "character-screen-inventory-list-module.stash":
			if (_item.isUsable())
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/icons/mouse_right_button.png",
					text = "使用物品"
				});
			}
			else if (_item.getSlotType() != this.Const.ItemSlot.None && _item.getSlotType() != this.Const.ItemSlot.Bag)
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/icons/mouse_right_button.png",
					text = "装备物品"
				});
			}

			if (_item.isChangeableInBattle() == true && _item.isAllowedInBag())
			{
				tooltip.push({
					id = 2,
					type = "hint",
					icon = "ui/icons/mouse_right_button_ctrl.png",
					text = "将物品放入背包中"
				});
			}

			if (_item.getCondition() < _item.getConditionMax())
			{
				tooltip.push({
					id = 3,
					type = "hint",
					icon = "ui/icons/mouse_right_button_alt.png",
					text = _item.isToBeRepaired() ? "设置物品为不修理状态" : "设置物品为修理状态"
				});
			}

			break;

		case "tactical-combat-result-screen.stash":
			tooltip.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_right_button.png",
				text = "将物品放在地上"
			});
			break;

		case "tactical-combat-result-screen.found-loot":
			if (this.Stash.hasEmptySlot())
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/icons/mouse_right_button.png",
					text = "将物品放入仓库"
				});
			}
			else
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "仓库满了"
				});
			}

			break;

		case "world-town-screen-shop-dialog-module.stash":
			tooltip.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_right_button.png",
				text = "出售物品 [img]gfx/ui/tooltips/money.png[/img]" + _item.getSellPrice()
			});

			if (this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().getCurrentBuilding() != null && this.World.State.getCurrentTown().getCurrentBuilding().isRepairOffered() && _item.getConditionMax() > 1 && _item.getCondition() < _item.getConditionMax())
			{
				local price = (_item.getConditionMax() - _item.getCondition()) * this.Const.World.Assets.CostToRepairPerPoint;
				local value = _item.m.Value * (1.0 - _item.getCondition() / _item.getConditionMax()) * 0.2 * this.World.State.getCurrentTown().getPriceMult() * this.Const.Difficulty.SellPriceMult[this.World.Assets.getEconomicDifficulty()];
				price = this.Math.max(price, value);

				if (this.World.Assets.getMoney() >= price)
				{
					tooltip.push({
						id = 3,
						type = "hint",
						icon = "ui/icons/mouse_right_button_alt.png",
						text = "支付[img]gfx/ui/tooltips/money.png[/img]" + price + "进行修理"
					});
				}
				else
				{
					tooltip.push({
						id = 3,
						type = "hint",
						icon = "ui/tooltips/warning.png",
						text = "没有足够的克朗来支付修理费用！"
					});
				}
			}

			break;

		case "world-town-screen-shop-dialog-module.shop":
			if (this.Stash.hasEmptySlot())
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/icons/mouse_right_button.png",
					text = "购买物品 [img]gfx/ui/tooltips/money.png[/img]" + _item.getBuyPrice()
				});
			}
			else
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "仓库满了"
				});
			}

			break;
		}

		return tooltip;
	}

	function strategic_queryTileTooltipData()
	{
		local lastTileHovered = this.World.State.getLastTileHovered();

		if (lastTileHovered != null)
		{
			if (this.World.Assets.m.IsShowingExtendedFootprints)
			{
				local footprints = this.World.getAllFootprintsAtPos(this.World.getCamera().screenToWorld(this.Cursor.getX(), this.Cursor.getY()), this.Const.World.FootprintsType.COUNT);
				local ret = [
					{
						id = 1,
						type = "title",
						text = "您的前哨报告。"
					}
				];

				for( local i = 1; i < footprints.len(); i = ++i )
				{
					if (footprints[i])
					{
						ret.push({
							id = 1,
							type = "hint",
							text = this.Const.Strings.FootprintsType[i] + "最近从这里经过"
						});
					}
				}

				if (ret.len() > 1)
				{
					return ret;
				}
			}
		}

		return null;
	}

	function strategic_queryEntityTooltipData( _entityId, _isTileEntity )
	{
		if (_isTileEntity)
		{
			local lastEntityHovered = this.World.State.getLastEntityHovered();
			local entity = this.World.getEntityByID(_entityId);

			if (lastEntityHovered != null && entity != null && lastEntityHovered.getID() == entity.getID())
			{
				return this.strategic_helper_addContentTypeToTooltip(entity, entity.getTooltip());
			}
		}
		else
		{
			local entity = this.Tactical.getEntityByID(_entityId);

			if (entity != null)
			{
				return this.strategic_helper_addContentTypeToTooltip(entity, entity.getRosterTooltip());
			}
		}

		return null;
	}

	function strategic_queryUIItemTooltipData( _entityId, _itemId, _itemOwner )
	{
		local entity = _entityId != null ? this.Tactical.getEntityByID(_entityId) : null;

		switch(_itemOwner)
		{
		case "entity":
			if (entity != null)
			{
				local item = entity.getItems().getItemByInstanceID(_itemId);

				if (item != null)
				{
					return this.tactical_helper_addHintsToTooltip(null, entity, item, _itemOwner);
				}
			}

			return null;

		case "ground":
		case "character-screen-inventory-list-module.ground":
			if (entity != null)
			{
				local item = this.tactical_helper_findGroundItem(entity, _itemId);

				if (item != null)
				{
					return this.tactical_helper_addHintsToTooltip(null, entity, item, _itemOwner);
				}
			}

			return null;

		case "stash":
		case "character-screen-inventory-list-module.stash":
			local result = this.Stash.getItemByInstanceID(_itemId);

			if (result != null)
			{
				return this.tactical_helper_addHintsToTooltip(null, entity, result.item, _itemOwner);
			}

			return null;

		case "craft":
			return this.World.Crafting.getBlueprint(_itemId).getTooltip();

		case "blueprint":
			return this.World.Crafting.getBlueprint(_entityId).getTooltipForComponent(_itemId);

		case "world-town-screen-shop-dialog-module.stash":
			local result = this.Stash.getItemByInstanceID(_itemId);

			if (result != null)
			{
				return this.tactical_helper_addHintsToTooltip(null, entity, result.item, _itemOwner, true);
			}

			return null;

		case "world-town-screen-shop-dialog-module.shop":
			local stash = this.World.State.getTownScreen().getShopDialogModule().getShop().getStash();

			if (stash != null)
			{
				local result = stash.getItemByInstanceID(_itemId);

				if (result != null)
				{
					return this.tactical_helper_addHintsToTooltip(null, entity, result.item, _itemOwner, true);
				}
			}

			return null;
		}

		return null;
	}

	function strategic_helper_addContentTypeToTooltip( _entity, _tooltip )
	{
		_tooltip.push({
			contentType = "tile-entity",
			entityId = _entity.getID()
		});
		return _tooltip;
	}

	function general_querySkillTooltipData( _entityId, _skillId )
	{
		local entity = this.Tactical.getEntityByID(_entityId);

		if (entity != null)
		{
			local skill = entity.getSkills().getSkillByID(_skillId);

			if (skill != null)
			{
				return skill.getTooltip();
			}
		}

		return null;
	}

	function general_queryStatusEffectTooltipData( _entityId, _statusEffectId )
	{
		local entity = this.Tactical.getEntityByID(_entityId);

		if (entity != null)
		{
			local statusEffect = entity.getSkills().getSkillByID(_statusEffectId);

			if (statusEffect != null)
			{
				local ret = statusEffect.getTooltip();

				if (statusEffect.isType(this.Const.SkillType.Background) && ("State" in this.World) && this.World.State != null)
				{
					this.World.Assets.getOrigin().onGetBackgroundTooltip(statusEffect, ret);
				}

				return ret;
			}
		}

		return null;
	}

	function general_querySettlementStatusEffectTooltipData( _statusEffectId )
	{
		local currentTown = this.World.State.getCurrentTown();

		if (currentTown != null)
		{
			local statusEffect = currentTown.getSituationByID(_statusEffectId);

			if (statusEffect != null)
			{
				return statusEffect.getTooltip();
			}
		}

		return null;
	}

	function general_queryUIPerkTooltipData( _entityId, _perkId )
	{
		local perk = this.Const.Perks.findById(_perkId);

		if (perk != null)
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = perk.Name
				},
				{
					id = 2,
					type = "description",
					text = perk.Tooltip
				}
			];
			local player = this.Tactical.getEntityByID(_entityId);

			if (!player.hasPerk(_perkId))
			{
				if (player.getPerkPointsSpent() >= perk.Unlocks)
				{
					if (player.getPerkPoints() == 0)
					{
						ret.push({
							id = 3,
							type = "hint",
							icon = "ui/icons/icon_locked.png",
							text = "可以获得，但这个角色没有额外的特技点"
						});
					}
				}
				else if (perk.Unlocks - player.getPerkPointsSpent() > 1)
				{
					ret.push({
						id = 3,
						type = "hint",
						icon = "ui/icons/icon_locked.png",
						text = "锁定直到 " + (perk.Unlocks - player.getPerkPointsSpent()) + "更多的技能点已经使用。"
					});
				}
				else
				{
					ret.push({
						id = 3,
						type = "hint",
						icon = "ui/icons/icon_locked.png",
						text = "锁定直到 " + (perk.Unlocks - player.getPerkPointsSpent()) + "更多的特技点被使用了"
					});
				}
			}

			return ret;
		}

		return null;
	}

	function general_queryUIElementTooltipData( _entityId, _elementId, _elementOwner )
	{
		local entity;

		if (_entityId != null)
		{
			entity = this.Tactical.getEntityByID(_entityId);
		}

		switch(_elementId)
		{
		case "CharacterName":
			local ret = [
				{
					id = 1,
					type = "title",
					text = entity.getName()
				}
			];
			return ret;

		case "CharacterNameAndTitles":
			local ret = [
				{
					id = 1,
					type = "title",
					text = entity.getName()
				}
			];

			if ("getProperties" in entity)
			{
				foreach( p in entity.getProperties() )
				{
					local s = this.World.getEntityByID(p);
					ret.push({
						id = 2,
						type = "text",
						text = "领主" + s.getName()
					});
				}
			}

			if ("getTitles" in entity)
			{
				foreach( s in entity.getTitles() )
				{
					ret.push({
						id = 3,
						type = "text",
						text = s
					});
				}
			}

			return ret;

		case "assets.Money":
			local money = this.World.Assets.getMoney();
			local dailyMoney = this.World.Assets.getDailyMoneyCost();
			local time = this.Math.floor(money / this.Math.max(1, dailyMoney));

			if (dailyMoney == 0)
			{
				return [
					{
						id = 1,
						type = "title",
						text = "克朗"
					},
					{
						id = 2,
						type = "description",
						text = "你的雇佣兵战队拥有的硬币数量。 用于每天中午给每个人发工资，还可以雇新人和购买装备。\n\n你现在不给任何人付工资。"
					}
				];
			}
			else if (time >= 1.0 && money > 0)
			{
				return [
					{
						id = 1,
						type = "title",
						text = "克朗"
					},
					{
						id = 2,
						type = "description",
						text = "你的雇佣兵战队拥有的硬币数量。 用于每天中午给每个人发工资，还可以雇新人和购买装备。\n\n你支付 [color=" + this.Const.UI.Color.PositiveValue + "]" + dailyMoney + "[/color] 克朗每天。你的 [color=" + this.Const.UI.Color.PositiveValue + "]" + money + "[/color] 克朗能让你支撑 [color=" + this.Const.UI.Color.PositiveValue + "]" + time + "[/color] 天。"
					}
				];
			}
			else
			{
				return [
					{
						id = 1,
						type = "title",
						text = "克朗"
					},
					{
						id = 2,
						type = "description",
						text = "你的雇佣兵战队拥有的硬币数量。 用于每天支付每个人的工资，还可以雇新人和购买装备。\n\n你支付 [color=" + this.Const.UI.Color.PositiveValue + "]" + dailyMoney + "[/color] 克朗每天。\n\n[color=" + this.Const.UI.Color.NegativeValue + "]你没有更多的克朗来支付给你的人！ 快赚些克朗，或者让一些人在他们一个一个地抛弃你之前让他离开。[/color]"
					}
				];
			}

		case "assets.InitialMoney":
			return [
				{
					id = 1,
					type = "title",
					text = "雇佣费"
				},
				{
					id = 2,
					type = "description",
					text = "雇佣一个人注册并签字来服从你的命令，雇佣费将立即支付。"
				}
			];

		case "assets.Fee":
			return [
				{
					id = 1,
					type = "title",
					text = "支付花费"
				},
				{
					id = 2,
					type = "description",
					text = "提供服务时必须预先支付该费用。"
				}
			];

		case "assets.TryoutMoney":
			return [
				{
					id = 1,
					type = "title",
					text = "测验费"
				},
				{
					id = 2,
					type = "description",
					text = "这项费用将立即支付给这个新兵用于适当的检查，以揭示他的特性，如果有的话。"
				}
			];

		case "assets.DailyMoney":
			return [
				{
					id = 1,
					type = "title",
					text = "日工资"
				},
				{
					id = 2,
					type = "description",
					text = "每日工资将作为在你的指挥下服务的报酬，每天支付。 工资自动增加，每级累积10%，直到11级，之后增加3%。"
				}
			];

		case "assets.Food":
			local food = this.World.Assets.getFood();
			local dailyFood = this.Math.ceil(this.World.Assets.getDailyFoodCost() * this.Const.World.TerrainFoodConsumption[this.World.State.getPlayer().getTile().Type]);
			local time = this.Math.floor(food / dailyFood);

			if (food > 0 && time > 1)
			{
				return [
					{
						id = 1,
						type = "title",
						text = "食物"
					},
					{
						id = 2,
						type = "description",
						text = "你携带的食物总量。 一般人每天需要2份食物，在困难的地形上需要更多。 你的人会先食用最接近过期的食物。 食物短缺会降低士气，最终导致你的人民在你饿死之前抛弃你。\n\n你消耗 [color=" + this.Const.UI.Color.PositiveValue + "]" + dailyFood + "[/color] 补给每天. 你的 [color=" + this.Const.UI.Color.PositiveValue + "]" + food + "[/color]口粮能够供应您[color=" + this.Const.UI.Color.PositiveValue + "]" + time + "[/color] 天最多。记住，某些食物最终会变质！"
					}
				];
			}
			else if (food > 0 && time == 1)
			{
				return [
					{
						id = 1,
						type = "title",
						text = "食物"
					},
					{
						id = 2,
						type = "description",
						text = "你携带的食物总量。 一般人每天需要2份食物，在困难的地形上需要更多。 你的人会先食用最接近过期的食物。 食物短缺会降低士气，最终导致你的人民在你饿死之前抛弃你。\n\n你消耗 [color=" + this.Const.UI.Color.PositiveValue + "]" + dailyFood + "[/color] 补给每天。\n\n[color=" + this.Const.UI.Color.NegativeValue + "]你快要没有足够的食物养活你的人了！ 尽快购买新的食物，否则你的人会在饿死之前一个接一个地抛弃你！[/color]"
					}
				];
			}
			else
			{
				return [
					{
						id = 1,
						type = "title",
						text = "食物"
					},
					{
						id = 2,
						type = "description",
						text = "你携带的食物总量。 一般人每天需要2份食物，在困难的地形上需要更多。 你的人会先食用最接近过期的食物。 食物短缺会降低士气，最终导致你的人民在你饿死之前抛弃你。\n\n你消耗 [color=" + this.Const.UI.Color.PositiveValue + "]" + dailyFood + "[/color] 补给每天。\n\n[color=" + this.Const.UI.Color.NegativeValue + "]你没有足够的食物来养活你的人！ 尽快购买新的食物，否则你的人会在饿死之前一个接一个地抛弃你！[/color]"
					}
				];
			}

		case "assets.DailyFood":
			return [
				{
					id = 1,
					type = "title",
					text = "每日食物"
				},
				{
					id = 2,
					type = "description",
					text = "一个人每天需要的食物供给量。 食物短缺会降低士气，最终导致你的人在你饿死之前离开你。"
				}
			];

		case "assets.Ammo":
			return [
				{
					id = 1,
					type = "title",
					text = "弹药"
				},
				{
					id = 2,
					type = "description",
					text = "整理好的各种箭矢、弩矢、投掷武器，用来在战斗后自动重新装填弹药袋。补充一支箭矢或弩矢消耗一点弹药，补充一发火铳弹消耗两点弹药，补充一个投掷武器或重装填火矛消耗三点弹药。弹药耗尽会使你的箭袋空空荡荡，你的人将无法射击。你可以总共携带不超过" + (this.Const.Difficulty.MaxResources[this.World.Assets.getEconomicDifficulty()].Ammo + this.World.Assets.m.AmmoMaxAdditional) + "单位。"
				}
			];

		case "assets.Supplies":
			local repair = this.World.Assets.getRepairRequired();
			local desc = "各种工具和补给，以保持你的武器，盔甲，头盔和盾牌在良好的状态。 修理15点耐久需要一点。 补给不足可能导致武器在战斗中断裂，使你的盔甲受损和无用。";

			if (repair.ArmorParts > 0)
			{
				desc = desc + ("\n\n修理你所有装备需要[color=" + this.Const.UI.Color.PositiveValue + "]" + repair.Hours + "[/color] 小时和需要 ");

				if (repair.ArmorParts <= this.World.Assets.getArmorParts())
				{
					desc = desc + ("[color=" + this.Const.UI.Color.PositiveValue + "]");
				}
				else
				{
					desc = desc + ("[color=" + this.Const.UI.Color.NegativeValue + "]");
				}

				desc = desc + (repair.ArmorParts + "[/color] 工具和补给。");
			}

			desc = desc + ("你可以携带最多" + (this.Const.Difficulty.MaxResources[this.World.Assets.getEconomicDifficulty()].ArmorParts + this.World.Assets.m.ArmorPartsMaxAdditional) + "单位。");
			return [
				{
					id = 1,
					type = "title",
					text = "工具和补给"
				},
				{
					id = 2,
					type = "description",
					text = desc
				}
			];

		case "assets.Medicine":
			local heal = this.World.Assets.getHealingRequired();
			local desc = "医疗用品由绷带、草药、药膏等组成，用于治疗战斗中士兵遭受的更严重的伤害。 每天需要一点医疗用品来改善和最终治愈每一个损伤。 失去的生命值会自行恢复。\n\n医疗用品用完会使你的人无法从重伤中恢复过来。";

			if (heal.MedicineMin > 0)
			{
				desc = desc + ("治愈所有士兵将需要一段时间 [color=" + this.Const.UI.Color.PositiveValue + "]" + heal.DaysMin + "[/color] 和 [color=" + this.Const.UI.Color.PositiveValue + "]" + heal.DaysMax + "[/color] 天并需要大约");

				if (heal.MedicineMin <= this.World.Assets.getMedicine())
				{
					desc = desc + ("[color=" + this.Const.UI.Color.PositiveValue + "]");
				}
				else
				{
					desc = desc + ("[color=" + this.Const.UI.Color.NegativeValue + "]");
				}

				desc = desc + (heal.MedicineMin + "[/color] 和 ");

				if (heal.MedicineMax <= this.World.Assets.getMedicine())
				{
					desc = desc + ("[color=" + this.Const.UI.Color.PositiveValue + "]");
				}
				else
				{
					desc = desc + ("[color=" + this.Const.UI.Color.NegativeValue + "]");
				}

				desc = desc + (heal.MedicineMax + "[/color] 医疗用品");
			}

			desc = desc + ("你可以携带最多" + (this.Const.Difficulty.MaxResources[this.World.Assets.getEconomicDifficulty()].Medicine + this.World.Assets.m.MedicineMaxAdditional) + "单位。");
			return [
				{
					id = 1,
					type = "title",
					text = "医疗用品"
				},
				{
					id = 2,
					type = "description",
					text = desc
				}
			];

		case "assets.Brothers":
			return [
				{
					id = 1,
					type = "title",
					text = "名册 (I, C)"
				},
				{
					id = 2,
					type = "description",
					text = "显示你的雇佣兵战队的战斗名单。"
				}
			];

		case "assets.BusinessReputation":
			return [
				{
					id = 1,
					type = "title",
					text = "声望：" + this.World.Assets.getBusinessReputationAsText() + " (" + this.World.Assets.getBusinessReputation() + ")"
				},
				{
					id = 2,
					type = "description",
					text = "你的声望是你作为一个专业的雇佣兵战队的名气，反映了人们对你的评价是多么的可靠和有能力。 你的声望越高，报酬越高，人们委托你的合同就越困难。 成功完成野心和合同，打赢仗，声望会增加，失败会减少。"
				}
			];

		case "assets.MoralReputation":
			return [
				{
					id = 1,
					type = "title",
					text = "声望：" + this.World.Assets.getMoralReputationAsText()
				},
				{
					id = 2,
					type = "description",
					text = "你的声誉反映了世界上的人们如何根据过去的行为判断你的雇佣兵战队的行为。 你对敌人仁慈吗？ 你烧了农庄，屠杀了农民吗？ 根据你的声誉，人们可能会给你提供不同种类的合同，合同和事件的执行方式也可能不同。"
				}
			];

		case "assets.Ambition":
			if (this.World.Ambitions.hasActiveAmbition())
			{
				local ret = this.World.Ambitions.getActiveAmbition().getButtonTooltip();

				if (this.World.Ambitions.getActiveAmbition().isCancelable())
				{
					ret.push({
						id = 10,
						type = "hint",
						icon = "ui/icons/mouse_right_button.png",
						text = "取消野心"
					});
				}

				return ret;
			}
			else
			{
				return [
					{
						id = 1,
						type = "title",
						text = "野心"
					},
					{
						id = 2,
						type = "description",
						text = "你还没有宣布你的战队有任何追求的野心。 随着游戏的进行，你将被要求这样做。"
					}
				];
			}

		case "stash.FreeSlots":
			return [
				{
					id = 1,
					type = "title",
					text = "容量"
				},
				{
					id = 2,
					type = "description",
					text = "显示库存当前和最大负载，即你的全部库存。"
				}
			];

		case "stash.ActiveRoster":
			return [
				{
					id = 1,
					type = "title",
					text = "编队"
				},
				{
					id = 2,
					type = "description",
					text = "显示当前和最大的编队人数，以便在下一场战斗中战斗。\n\n把你的人拖到你想让他们到的地方；最上面一排是面对敌人的前面，第二排是你的后面一排，最下面一排是你保留的不参加战斗的角色。"
				}
			];

		case "ground.Slots":
			return [
				{
					id = 1,
					type = "title",
					text = "地面"
				},
				{
					id = 2,
					type = "description",
					text = "显示当前放置在地面上的物品。"
				}
			];

		case "character-stats.ActionPoints":
			return [
				{
					id = 1,
					type = "title",
					text = "行动点"
				},
				{
					id = 2,
					type = "description",
					text = "行动点（AP）用于每个动作，如移动或使用技能。 所有点数用完后，当前角色的回合将自动结束。 AP每进行一整回合都会完全恢复。"
				}
			];

		case "character-stats.Hitpoints":
			return [
				{
					id = 1,
					type = "title",
					text = "生命值"
				},
				{
					id = 2,
					type = "description",
					text = "生命值代表一个角色在死亡前所能承受的伤害。 一旦达到零，角色就被认为是死亡。 最大生命值越高，角色受到攻击时受到削弱损伤的可能性越小。"
				}
			];

		case "character-stats.Morale":
			return [
				{
					id = 1,
					type = "title",
					text = "士气"
				},
				{
					id = 2,
					type = "description",
					text = "士气会是五种状态之一，代表着战斗人员的心理状态和战斗力。 在最低状态下，逃跑，角色将超出你的控制，尽管他们最终可能会再次聚集。 随着战斗的展开，士气会发生变化，具有高决心的角色不太可能落入士气低落的状态。 你的许多对手也受到士气的影响。\n\n士气检查在这些情况下触发：\n- 杀敌\n- 看到敌人被杀\n- 看到盟友被杀\n- 看到盟友逃跑\n- 生命值受到15点或更多的伤害\n- 面对一个以上的对手\n- 使用某些技能，比如“集结”"
				}
			];

		case "character-stats.Fatigue":
			return [
				{
					id = 1,
					type = "title",
					text = "疲劳"
				},
				{
					id = 2,
					type = "description",
					text = "每一个动作，如移动或使用技能，以及在战斗中被击中或在近战中躲闪，都会导致疲劳。 每回合固定减少15疲劳或角色在低于最大疲劳15的情况下开始每个回合。 如果一个角色积累了太多的疲劳，他们可能需要休息一段时间（即什么都不做），然后才能再次使用更专业的技能。"
				}
			];

		case "character-stats.MaximumFatigue":
			return [
				{
					id = 1,
					type = "title",
					text = "最大疲劳"
				},
				{
					id = 2,
					type = "description",
					text = "最大疲劳是一个角色在无法采取任何行动和必须恢复之前可能积累的疲劳量。 它是通过穿戴重型装备，特别是盔甲来减少的。"
				}
			];

		case "character-stats.ArmorHead":
			return [
				{
					id = 1,
					type = "title",
					text = "头部护甲"
				},
				{
					id = 2,
					type = "description",
					text = "令人惊讶的是，头部盔甲可以保护头部，头部比身体更难被击中，但更容易受到伤害。 头部护甲越多，受到打击时对生命值的伤害就越小。"
				}
			];

		case "character-stats.ArmorBody":
			return [
				{
					id = 1,
					type = "title",
					text = "身体护甲"
				},
				{
					id = 2,
					type = "description",
					text = " 身体护甲越多，受到打击时对生命值的伤害就越小。"
				}
			];

		case "character-stats.MeleeSkill":
			return [
				{
					id = 1,
					type = "title",
					text = "近战技能"
				},
				{
					id = 2,
					type = "description",
					text = "决定使用近战攻击击中目标的基本概率，比如使用剑和矛。可以随着角色获得经验而增加。"
				}
			];

		case "character-stats.RangeSkill":
			return [
				{
					id = 1,
					type = "title",
					text = "远程技能"
				},
				{
					id = 2,
					type = "description",
					text = "决定使用远程攻击击中目标的基本概率，比如使用弓和弩。可以随着角色获得经验而增加。"
				}
			];

		case "character-stats.MeleeDefense":
			return [
				{
					id = 1,
					type = "title",
					text = "近战防御"
				},
				{
					id = 2,
					type = "description",
					text = "提高近战防御可以降低被近战攻击击中的概率，比如矛的刺击。它可以随着角色获得经验和装备好盾牌而增加。"
				}
			];

		case "character-stats.RangeDefense":
			return [
				{
					id = 1,
					type = "title",
					text = "远程防御"
				},
				{
					id = 2,
					type = "description",
					text = "更高的远程防御降低了被远程攻击击中的概率，例如从远处射箭。 它可以随着角色获得经验和装备好盾牌而增加。"
				}
			];

		case "character-stats.SightDistance":
			return [
				{
					id = 1,
					type = "title",
					text = "视野"
				},
				{
					id = 2,
					type = "description",
					text = "视野，或视距，决定角色能看到多远，以发现战争的迷雾，发现威胁和远程攻击。 重型头盔和夜间时会降低视野。"
				}
			];

		case "character-stats.RegularDamage":
			return [
				{
					id = 1,
					type = "title",
					text = "伤害"
				},
				{
					id = 2,
					type = "description",
					text = "目前装备的武器造成的基础伤害。 如果没有盔甲保护目标，将完全作用于生命值。 如果目标受到盔甲保护，则根据武器作用于盔甲的效果，对盔甲施加伤害。 实际造成的伤害会因使用的技能和击中的目标来改变。"
				}
			];

		case "character-stats.CrushingDamage":
			return [
				{
					id = 1,
					type = "title",
					text = "对抗装甲的效果"
				},
				{
					id = 2,
					type = "description",
					text = "击中受盔甲保护的目标时所受到的伤害的基本百分比。 一旦盔甲被摧毁，武器伤害将100%的作用于生命值。 实际造成的伤害会因使用的技能和击中的目标来改变。"
				}
			];

		case "character-stats.ChanceToHitHead":
			return [
				{
					id = 1,
					type = "title",
					text = "击中头部的机率"
				},
				{
					id = 2,
					type = "description",
					text = "击中目标头部可以增加伤害的基础几率。 最后的几率可以通过使用的技能来改变。"
				}
			];

		case "character-stats.Initiative":
			return [
				{
					id = 1,
					type = "title",
					text = "主动值"
				},
				{
					id = 2,
					type = "description",
					text = "该值越高，回合顺序中的位置越靠前。 主动值会因当前的疲劳以及对最大疲劳的惩罚（如重型盔甲）而降低。 一般来说，穿轻甲的人会在穿重甲的人前面行动，一个新来的人会在疲惫的人前面行动。"
				}
			];

		case "character-stats.Bravery":
			return [
				{
					id = 1,
					type = "title",
					text = "决心"
				},
				{
					id = 2,
					type = "description",
					text = "决心代表着角色的意志力和勇气。 越高，角色在消极事件中士气越低的可能性越小，角色从积极事件中获得信心的可能性越大。 决心也可以用于防御某些精神攻击，造成恐慌，恐惧或精神控制。 另见：士气。"
				}
			];

		case "character-stats.Talent":
			return [
				{
					id = 1,
					type = "title",
					text = "天赋"
				},
				{
					id = 2,
					type = "description",
					text = "TODO"
				}
			];

		case "character-stats.Undefined":
			return [
				{
					id = 1,
					type = "title",
					text = "UNDEFINED"
				},
				{
					id = 2,
					type = "description",
					text = "TODO"
				}
			];

		case "character-backgrounds.generic":
			if (entity != null)
			{
				local tooltip = entity.getBackground().getGenericTooltip();
				return tooltip;
			}

			return null;

		case "character-levels.generic":
			return [
				{
					id = 1,
					type = "title",
					text = "更高层级"
				},
				{
					id = 2,
					type = "description",
					text = "这个角色已经有了战斗经验，从更高的等级开始。"
				}
			];

		case "menu-screen.load-campaign.LoadButton":
			return [
				{
					id = 1,
					type = "title",
					text = "载入战役"
				},
				{
					id = 2,
					type = "description",
					text = "加载所选的战役。"
				}
			];

		case "menu-screen.load-campaign.CancelButton":
			return [
				{
					id = 1,
					type = "title",
					text = "取消"
				},
				{
					id = 2,
					type = "description",
					text = "返回主菜单。"
				}
			];

		case "menu-screen.load-campaign.DeleteButton":
			return [
				{
					id = 1,
					type = "title",
					text = "删除战役"
				},
				{
					id = 2,
					type = "description",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]警告：[/color] 删除所选战役而不发出任何警告。"
				}
			];

		case "menu-screen.save-campaign.LoadButton":
			return [
				{
					id = 1,
					type = "title",
					text = "保存战役"
				},
				{
					id = 2,
					type = "description",
					text = "在所选位置中保存战役。"
				}
			];

		case "menu-screen.save-campaign.CancelButton":
			return [
				{
					id = 1,
					type = "title",
					text = "取消"
				},
				{
					id = 2,
					type = "description",
					text = "返回主菜单。"
				}
			];

		case "menu-screen.save-campaign.DeleteButton":
			return [
				{
					id = 1,
					type = "title",
					text = "删除战役"
				},
				{
					id = 2,
					type = "description",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]警告：[/color] 删除所选战役而不发出任何警告。"
				}
			];

		case "menu-screen.new-campaign.CompanyName":
			return [
				{
					id = 1,
					type = "title",
					text = "战队名称"
				},
				{
					id = 2,
					type = "description",
					text = "你的佣兵战团的名字将在各地广为人知。。"
				}
			];

		case "menu-screen.new-campaign.Seed":
			return [
				{
					id = 1,
					type = "title",
					text = "地图种子"
				},
				{
					id = 2,
					type = "description",
					text = "地图种子是一个独特的字符串，它决定了你的战役中的世界是什么样子的。 你可以通过按Escape键在游戏菜单中看到正在进行的战役的种子，然后与朋友分享，让他们在同一个世界玩游戏。"
				}
			];

		case "menu-screen.new-campaign.EasyDifficulty":
			return [
				{
					id = 1,
					type = "title",
					text = "初学者难度"
				},
				{
					id = 2,
					type = "description",
					text = "你将面对较少和挑战性更低的对手，你的人获得经验的速度稍快，从战斗中撤退更容易。\n\n你的人会得到一个很小的命中几率奖励，而敌人会得到一个很小的惩罚，让你轻松进入游戏。\n\n推荐给新加入游戏的玩家。"
				}
			];

		case "menu-screen.new-campaign.NormalDifficulty":
			return [
				{
					id = 1,
					type = "title",
					text = "老兵难度"
				},
				{
					id = 2,
					type = "description",
					text = "提供一个平衡的游戏体验，这是非常具有挑战性的。\n\n推荐给这类游戏的老兵。"
				}
			];

		case "menu-screen.new-campaign.HardDifficulty":
			return [
				{
					id = 1,
					type = "title",
					text = "专家难度"
				},
				{
					id = 2,
					type = "description",
					text = "你的对手将更具挑战性和更多。\n\n推荐给那些想要更致命挑战的游戏专家。"
				}
			];

		case "menu-screen.new-campaign.EasyDifficultyEconomic":
			return [
				{
					id = 1,
					type = "title",
					text = "初学者难度"
				},
				{
					id = 2,
					type = "description",
					text = "合同将支付更多的费用，你将能够同时携带更多的资源。\n\n推荐给新加入游戏的玩家。"
				}
			];

		case "menu-screen.new-campaign.NormalDifficultyEconomic":
			return [
				{
					id = 1,
					type = "title",
					text = "老兵难度"
				},
				{
					id = 2,
					type = "description",
					text = "提供一个平衡的游戏体验，这是非常具有挑战性的。\n\n推荐给这类游戏的老兵。"
				}
			];

		case "menu-screen.new-campaign.HardDifficultyEconomic":
			return [
				{
					id = 1,
					type = "title",
					text = "专家难度"
				},
				{
					id = 2,
					type = "description",
					text = "合同费用会减少，逃兵会带上他们的装备。\n\n推荐给那些希望在管理战队资金和补给方面遇到更多挑战的游戏专家。"
				}
			];

		case "menu-screen.new-campaign.EasyDifficultyBudget":
			return [
				{
					id = 1,
					type = "title",
					text = "高启动资金"
				},
				{
					id = 2,
					type = "description",
					text = "你将从更多的克朗和资源开始。\n\n推荐给新玩家。"
				}
			];

		case "menu-screen.new-campaign.NormalDifficultyBudget":
			return [
				{
					id = 1,
					type = "title",
					text = "中启动资金"
				},
				{
					id = 2,
					type = "description",
					text = "为平衡的体验推荐。"
				}
			];

		case "menu-screen.new-campaign.HardDifficultyBudget":
			return [
				{
					id = 1,
					type = "title",
					text = "低启动资金"
				},
				{
					id = 2,
					type = "description",
					text = "你将从更少的克朗和资源开始。\n\n推荐给专业玩家。"
				}
			];

		case "menu-screen.new-campaign.StartingScenario":
			return [
				{
					id = 1,
					type = "title",
					text = "开始剧情"
				},
				{
					id = 2,
					type = "description",
					text = "选择你的战队如何在世界上起步。 根据你的选择，你将从不同的人员、装备、资源和特殊规则开始。"
				}
			];

		case "menu-screen.new-campaign.Ironman":
			return [
				{
					id = 1,
					type = "title",
					text = "铁人模式"
				},
				{
					id = 2,
					type = "description",
					text = "铁人模式禁用手动保存。 战队只有一个保存，游戏在游戏期间和退出时自动保存。 失去战队意味着失去存档。 一旦你学会了游戏，就推荐给你最好的体验。\n\n请注意，在较差的计算机上，自动保存可能会导致游戏暂停几秒钟。"
				}
			];

		case "menu-screen.new-campaign.Exploration":
			return [
				{
					id = 1,
					type = "title",
					text = "未探索地图"
				},
				{
					id = 2,
					type = "description",
					text = "这是一种可选的游戏方式，在游戏开始时地图完全未被探索，你看不到。 你必须自己去发现一切，这会使你的战役更加困难，但也可能会更令人兴奋。\n\n只推荐给有经验的玩家，他们知道自己在做什么。"
				}
			];

		case "menu-screen.new-campaign.EvilRandom":
			return [
				{
					id = 1,
					type = "title",
					text = "随机游戏后期危机"
				},
				{
					id = 2,
					type = "description",
					text = "所有危机将在以下选项中随机选择。"
				}
			];

		case "menu-screen.new-campaign.EvilNone":
			return [
				{
					id = 1,
					type = "title",
					text = "没有危机"
				},
				{
					id = 2,
					type = "description",
					text = "不会有后期游戏危机，你可以永远继续玩沙盒体验。 请注意，选择此选项后，将无法访问游戏内容和后期游戏挑战的重要部分。 不推荐获得最佳体验。"
				}
			];

		case "menu-screen.new-campaign.EvilPermanentDestruction":
			return [
				{
					id = 1,
					type = "title",
					text = "永久摧毁"
				},
				{
					id = 2,
					type = "description",
					text = "在游戏后期的危机中，城市、城镇和城堡都可能被永久摧毁，让世界陷入火海是你失去战役的众多途径之一。"
				}
			];

		case "menu-screen.new-campaign.EvilWar":
			return [
				{
					id = 1,
					type = "title",
					text = "战争"
				},
				{
					id = 2,
					type = "description",
					text = "游戏后期的第一场危机将是贵族家族之间的一场残酷的权力战争。 如果你活得够久，以下的将随机选择。"
				}
			];

		case "menu-screen.new-campaign.EvilGreenskins":
			return [
				{
					id = 1,
					type = "title",
					text = "绿皮入侵"
				},
				{
					id = 2,
					type = "description",
					text = "游戏后期的第一场危机将是大群绿皮的入侵，他们威胁要席卷人类世界。 如果你活得够久，以下的将随机选择。"
				}
			];

		case "menu-screen.new-campaign.EvilUndead":
			return [
				{
					id = 1,
					type = "title",
					text = "亡灵天灾"
				},
				{
					id = 2,
					type = "description",
					text = "游戏后期的第一次危机将是古代死难者再次出现，夺回曾经属于他们的东西。 如果你活得够久，以下的将随机选择。"
				}
			];

		case "menu-screen.new-campaign.EvilCrusade":
			return [
				{
					id = 1,
					type = "title",
					text = "圣战"
				},
				{
					id = 2,
					type = "description",
					text = "游戏后期的第一场危机将是南北文化之间的圣战。 如果你活得够久，以下的将随机选择。"
				}
			];

		case "menu-screen.options.DepthOfField":
			return [
				{
					id = 1,
					type = "title",
					text = "景深"
				},
				{
					id = 2,
					type = "description",
					text = "启用景深效果将巧妙的使战斗中相机下方的高度水平稍微偏离焦点（即模糊），从而产生更多的微型效果，使区分高度更加容易，但可能会牺牲一些细节。"
				}
			];

		case "menu-screen.options.UIScale":
			return [
				{
					id = 1,
					type = "title",
					text = "用户界面规模"
				},
				{
					id = 2,
					type = "description",
					text = "更改用户界面的比例，即菜单和文本。"
				}
			];

		case "menu-screen.options.SceneScale":
			return [
				{
					id = 1,
					type = "title",
					text = "场景比例"
				},
				{
					id = 2,
					type = "description",
					text = "更改场景的比例，即所有非用户界面的内容，如战场上显示的角色。"
				}
			];

		case "menu-screen.options.EdgeOfScreen":
			return [
				{
					id = 1,
					type = "title",
					text = "屏幕边缘"
				},
				{
					id = 2,
					type = "description",
					text = "将鼠标光标移到屏幕边缘，滚动屏幕。"
				}
			];

		case "menu-screen.options.DragWithMouse":
			return [
				{
					id = 1,
					type = "title",
					text = "鼠标拖动"
				},
				{
					id = 2,
					type = "description",
					text = "通过按鼠标左键并拖动（默认）滚动屏幕。"
				}
			];

		case "menu-screen.options.HardwareMouse":
			return [
				{
					id = 1,
					type = "title",
					text = "使用硬件光标"
				},
				{
					id = 2,
					type = "description",
					text = "在游戏中移动鼠标时，使用硬件光标可以最大限度地减少输入延迟。 如果鼠标光标出现问题，请禁用此选项。"
				}
			];

		case "menu-screen.options.HardwareSound":
			return [
				{
					id = 1,
					type = "title",
					text = "使用硬件声音"
				},
				{
					id = 2,
					type = "description",
					text = "使用硬件加速声音播放以获得更好的性能。 如果遇到任何与声音相关的问题，请禁用此选项。"
				}
			];

		case "menu-screen.options.CameraFollow":
			return [
				{
					id = 1,
					type = "title",
					text = "始终关注AI移动"
				},
				{
					id = 2,
					type = "description",
					text = "始终让摄像头对准任何你能看到的AI移动。"
				}
			];

		case "menu-screen.options.CameraAdjust":
			return [
				{
					id = 1,
					type = "title",
					text = "自动调整高度级别"
				},
				{
					id = 2,
					type = "description",
					text = "自动调整摄像机的高度，以查看战斗中当前活动的角色。 禁用此选项将防止摄像机在不严格需要时更改高度级别，但当角色恰好被地形阻挡时，还需要手动调整高度级别。"
				}
			];

		case "menu-screen.options.StatsOverlays":
			return [
				{
					id = 1,
					type = "title",
					text = "始终显示生命条"
				},
				{
					id = 2,
					type = "description",
					text = "在战斗中，始终显示在角色上方浮动的生命和护甲条，而不是只有在角色被击中时才显示。"
				}
			];

		case "menu-screen.options.OrientationOverlays":
			return [
				{
					id = 1,
					type = "title",
					text = "显示方向图标"
				},
				{
					id = 2,
					type = "description",
					text = "在屏幕边缘显示图标，指示当前屏幕外的任何角色在地图上的方向。"
				}
			];

		case "menu-screen.options.MovementPlayer":
			return [
				{
					id = 1,
					type = "title",
					text = "更快的玩家移动"
				},
				{
					id = 2,
					type = "description",
					text = "在战斗中显著加快由你控制的任何角色的移动速度。 不会影响动作相关技能。"
				}
			];

		case "menu-screen.options.MovementAI":
			return [
				{
					id = 1,
					type = "title",
					text = "更快的AI移动"
				},
				{
					id = 2,
					type = "description",
					text = "在战斗中显著加速由AI控制的任何角色的移动。  不会影响动作相关技能。"
				}
			];

		case "menu-screen.options.AutoLoot":
			return [
				{
					id = 1,
					type = "title",
					text = "自动掠夺"
				},
				{
					id = 2,
					type = "description",
					text = "一旦你关闭战利品屏幕，只要你有足够的空间携带它，在战斗结束后，你就会自动地掠夺所有发现的东西。"
				}
			];

		case "menu-screen.options.RestoreEquipment":
			return [
				{
					id = 1,
					type = "title",
					text = "战斗后重置装备"
				},
				{
					id = 2,
					type = "description",
					text = "如果可能的话，自动将装备放回战斗前的摆放位置中。例如，如果一个角色开始使用弩作战，但在战斗中变为长矛，则在战斗结束时，他们将自动再次手握弩。"
				}
			];

		case "menu-screen.options.AutoPauseAfterCity":
			return [
				{
					id = 1,
					type = "title",
					text = "离开城市后自动暂停"
				},
				{
					id = 2,
					type = "description",
					text = "离开一个城市后自动暂停游戏，这样你就不会浪费任何时间，但代价是每次都必须手动取消暂停。"
				}
			];

		case "menu-screen.options.AlwaysHideTrees":
			return [
				{
					id = 1,
					type = "title",
					text = "总是隐藏树木"
				},
				{
					id = 2,
					type = "description",
					text = "始终将树和其他大型地图对象的顶部渲染为半透明，而不是仅当它们实际阻塞某些对象时。"
				}
			];

		case "menu-screen.options.AutoEndTurns":
			return [
				{
					id = 1,
					type = "title",
					text = "自动结束回合"
				},
				{
					id = 2,
					type = "description",
					text = "由你控制的角色没有任何行动点可执行任何动作时，将自动结束他的回合。"
				}
			];

		case "tactical-screen.topbar.event-log-module.ExpandButton":
			return [
				{
					id = 1,
					type = "title",
					text = "展开/收回事件日志"
				},
				{
					id = 2,
					type = "description",
					text = "展开或收回战斗事件日志。"
				}
			];

		case "tactical-screen.topbar.round-information-module.BrothersCounter":
			return [
				{
					id = 1,
					type = "title",
					text = "盟友"
				},
				{
					id = 2,
					type = "description",
					text = "战场上由你控制的战友和AI控制的盟友的数量。"
				}
			];

		case "tactical-screen.topbar.round-information-module.EnemiesCounter":
			return [
				{
					id = 1,
					type = "title",
					text = "对手"
				},
				{
					id = 2,
					type = "description",
					text = "当前战场上的对手数量。"
				}
			];

		case "tactical-screen.topbar.round-information-module.RoundCounter":
			return [
				{
					id = 1,
					type = "title",
					text = "回合"
				},
				{
					id = 2,
					type = "description",
					text = "战斗开始后所进行的轮数。"
				}
			];

		case "tactical-screen.topbar.options-bar-module.CenterButton":
			return [
				{
					id = 1,
					type = "title",
					text = "相机居中 (Shift)"
				},
				{
					id = 2,
					type = "description",
					text = "将相机置于当前角色的中心。"
				}
			];

		case "tactical-screen.topbar.options-bar-module.ToggleHighlightBlockedTilesButton":
			return [
				{
					id = 1,
					type = "title",
					text = "显示/隐藏阻挡格子的高光 （B）"
				},
				{
					id = 2,
					type = "description",
					text = "在显示和隐藏红色覆盖层之间切换，红色覆盖层表示角色无法移动到的被环境物体（比如树）阻挡的格子。"
				}
			];

		case "tactical-screen.topbar.options-bar-module.SwitchMapLevelUpButton":
			return [
				{
					id = 1,
					type = "title",
					text = "提高相机高度 (+)"
				},
				{
					id = 2,
					type = "description",
					text = "提高相机的高度，以查看地图上更高的部分。"
				}
			];

		case "tactical-screen.topbar.options-bar-module.SwitchMapLevelDownButton":
			return [
				{
					id = 1,
					type = "title",
					text = "降低相机高度 (-)"
				},
				{
					id = 2,
					type = "description",
					text = "降低相机的高度并隐藏地图上更高的部分。"
				}
			];

		case "tactical-screen.topbar.options-bar-module.ToggleStatsOverlaysButton":
			return [
				{
					id = 1,
					type = "title",
					text = "显示/隐藏生命条 (Alt)"
				},
				{
					id = 2,
					type = "description",
					text = "在显示和隐藏护甲和生命条，以及状态效果图标之间切换，将每个可见的角色都显示出来。"
				}
			];

		case "tactical-screen.topbar.options-bar-module.ToggleTreesButton":
			return [
				{
					id = 1,
					type = "title",
					text = "显示/隐藏树 (T)"
				},
				{
					id = 2,
					type = "description",
					text = "在显示和隐藏地图上的树和其他大型对象之间切换。"
				}
			];

		case "tactical-screen.topbar.options-bar-module.FleeButton":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "从战斗中撤退"
				},
				{
					id = 2,
					type = "description",
					text = "从战斗中撤退，为你的生命而逃。与其在这里毫无意义地死去，不如改日再战。"
				}
			];

			if (!this.Tactical.State.isScenarioMode() && this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsFleeingProhibited)
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "你不能从这场特定的战斗中撤退。"
				});
			}

			return ret;

		case "tactical-screen.topbar.options-bar-module.QuitButton":
			return [
				{
					id = 1,
					type = "title",
					text = "打开菜单 (Esc)"
				},
				{
					id = 2,
					type = "description",
					text = "打开菜单调整游戏选项。"
				}
			];

		case "tactical-screen.turn-sequence-bar-module.EndTurnButton":
			return [
				{
					id = 1,
					type = "title",
					text = "结束回合 (回车键，F)"
				},
				{
					id = 2,
					type = "description",
					text = "结束当前角色的回合，并让下一个角色按顺序行动。"
				}
			];

		case "tactical-screen.turn-sequence-bar-module.WaitTurnButton":
			return [
				{
					id = 1,
					type = "title",
					text = "等待回合 (空格键，End)"
				},
				{
					id = 2,
					type = "description",
					text = "暂停当前角色的回合并将其移动到队列的末尾。 等待这个回合，也会让你在下一轮晚一些再行动。"
				}
			];

		case "tactical-screen.turn-sequence-bar-module.EndTurnAllButton":
			return [
				{
					id = 1,
					type = "title",
					text = "结束回合 (R)"
				},
				{
					id = 2,
					type = "description",
					text = "结束当前轮，让所有人跳过他们的回合，直到下一轮开始。"
				}
			];

		case "tactical-screen.turn-sequence-bar-module.OpenInventoryButton":
			return [
				{
					id = 1,
					type = "title",
					text = "打开仓库 (R)"
				},
				{
					id = 2,
					type = "description",
					text = "打开角色屏幕和查看战场兄弟的仓库。"
				}
			];

		case "tactical-combat-result-screen.LeaveButton":
			return [
				{
					id = 1,
					type = "title",
					text = "离开"
				},
				{
					id = 2,
					type = "description",
					text = "离开战斗，返回世界地图。"
				}
			];

		case "tactical-combat-result-screen.statistics-panel.LeveledUp":
			local result = [
				{
					id = 1,
					type = "title",
					text = "升级"
				},
				{
					id = 2,
					type = "description",
					text = "这个角色刚刚升级！ 在你的名册中找到他，可以在世界地图上访问，以提高他的属性并选择一个特技。"
				}
			];
			return result;

		case "tactical-combat-result-screen.statistics-panel.DaysWounded":
			local result = [
				{
					id = 1,
					type = "title",
					text = "轻伤"
				},
				{
					id = 2,
					type = "description",
					text = "轻微的瘀伤、皮肉伤、失血以及类似的情况，导致这个角色在不损害其能力的情况下失去生命值。"
				}
			];

			if (entity != null)
			{
				if (entity.getDaysWounded() <= 1)
				{
					result.push({
						id = 1,
						type = "text",
						icon = "ui/icons/days_wounded.png",
						text = "明天就会痊愈"
					});
				}
				else
				{
					result.push({
						id = 1,
						type = "text",
						icon = "ui/icons/days_wounded.png",
						text = "将会痊愈在[color=" + this.Const.UI.Color.NegativeValue + "]" + entity.getDaysWounded() + "[/color] 天"
					});
				}
			}

			return result;

		case "tactical-combat-result-screen.statistics-panel.KillsValue":
			return [
				{
					id = 1,
					type = "title",
					text = "击杀"
				},
				{
					id = 2,
					type = "description",
					text = "这个角色在战斗中的杀戮次数。"
				}
			];

		case "tactical-combat-result-screen.statistics-panel.XPReceivedValue":
			return [
				{
					id = 1,
					type = "title",
					text = "获得的经验"
				},
				{
					id = 2,
					type = "description",
					text = "在战斗中从战斗和杀死对手中获得的经验点数。 获得足够的经验点将使这个人升级，增加属性和获得新的特技。"
				}
			];

		case "tactical-combat-result-screen.statistics-panel.DamageDealtValue":
			local result = [
				{
					id = 1,
					type = "title",
					text = "造成的伤害"
				},
				{
					id = 2,
					type = "description",
					text = "这个角色在战斗中对生命值和盔甲造成的伤害。"
				}
			];

			if (entity != null)
			{
				local combatStats = entity.getCombatStats();
				result.push({
					id = 1,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "造成 [color=" + this.Const.UI.Color.PositiveValue + "]" + combatStats.DamageDealtHitpoints + "[/color] 生命值伤害"
				});
				result.push({
					id = 2,
					type = "text",
					icon = "ui/icons/shield_damage.png",
					text = "造成 [color=" + this.Const.UI.Color.PositiveValue + "]" + combatStats.DamageDealtArmor + "[/color] 盔甲伤害"
				});
			}

			return result;

		case "tactical-combat-result-screen.statistics-panel.DamageReceivedValue":
			local result = [
				{
					id = 1,
					type = "title",
					text = "受到的伤害"
				},
				{
					id = 2,
					type = "description",
					text = "这个角色受到的伤害，分为对生命值的伤害和对盔甲的伤害。 该值是在任何可能的伤害减少之后。"
				}
			];

			if (entity != null)
			{
				local combatStats = entity.getCombatStats();
				result.push({
					id = 1,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "收到了 [color=" + this.Const.UI.Color.NegativeValue + "]" + combatStats.DamageReceivedHitpoints + "[/color] 生命值伤害"
				});
				result.push({
					id = 2,
					type = "text",
					icon = "ui/icons/shield_damage.png",
					text = "收到了 [color=" + this.Const.UI.Color.NegativeValue + "]" + combatStats.DamageReceivedArmor + "[/color] 盔甲伤害"
				});
			}

			return result;

		case "tactical-combat-result-screen.loot-panel.LootAllItemsButton":
			return [
				{
					id = 1,
					type = "title",
					text = "掠夺所有物品"
				},
				{
					id = 2,
					type = "description",
					text = "掠夺所有找到的物品，直到仓库满为止。"
				}
			];

		case "character-screen.left-panel-header-module.ChangeNameAndTitle":
			return [
				{
					id = 1,
					type = "title",
					text = "更改名称和头衔"
				},
				{
					id = 2,
					type = "description",
					text = "单击此处更改角色的名称和头衔。"
				}
			];

		case "character-screen.left-panel-header-module.Experience":
			return [
				{
					id = 1,
					type = "title",
					text = "经验"
				},
				{
					id = 2,
					type = "description",
					text = "角色在战斗中杀死敌人时获得经验。 如果一个角色积累了足够的经验，他将提升自己的等级，并且能够提高自己的属性，并授予可以选择一个独特奖励的特技。\n\n在角色11级之后，角色成为经验丰富的人，不再获得特技点，但仍可以继续提高。"
				}
			];

		case "character-screen.left-panel-header-module.Level":
			return [
				{
					id = 1,
					type = "title",
					text = "等级"
				},
				{
					id = 2,
					type = "description",
					text = "角色的等级衡量战斗中的经验。 角色在获得经验的同时也会提升等级，并且能够增加他们的属性和获得使他们更擅长雇佣职业的特技。\n\n在角色11级之后，角色成为经验丰富的人，不再获得特技点，但仍可以继续提高。"
				}
			];

		case "character-screen.brothers-list.LevelUp":
			local result = [
				{
					id = 1,
					type = "title",
					text = "升级"
				},
				{
					id = 2,
					type = "description",
					text = "这个角色已经升级了。 增加他的属性并选择一个特技！"
				}
			];
			return result;

		case "character-screen.left-panel-header-module.Dismiss":
			return [
				{
					id = 1,
					type = "title",
					text = "解雇"
				},
				{
					id = 2,
					type = "description",
					text = "把这个角色从你的名册中解雇掉，这样可以节省日工资，并为其他人腾出空间。 负债者角色将解除奴隶身份，离开你的战队。"
				}
			];

		case "character-screen.right-panel-header-module.InventoryButton":
			return [
				{
					id = 1,
					type = "title",
					text = "仓库/地面"
				},
				{
					id = 2,
					type = "description",
					text = "切换到查看佣兵团的仓库，或战斗中选定角色下方的地面。"
				}
			];

		case "character-screen.right-panel-header-module.PerksButton":
			return [
				{
					id = 1,
					type = "title",
					text = "特技"
				},
				{
					id = 2,
					type = "description",
					text = "切换到查看选定角色的特技。\n\n括号中的数字（如果有）是可用的特技点数。"
				}
			];

		case "character-screen.right-panel-header-module.CloseButton":
			return [
				{
					id = 1,
					type = "title",
					text = "关闭 (ESC)"
				},
				{
					id = 2,
					type = "description",
					text = "关闭此屏幕。"
				}
			];

		case "character-screen.right-panel-header-module.SortButton":
			return [
				{
					id = 1,
					type = "title",
					text = "物品排序"
				},
				{
					id = 2,
					type = "description",
					text = "按类型对物品排序。"
				}
			];

		case "character-screen.right-panel-header-module.FilterAllButton":
			return [
				{
					id = 1,
					type = "title",
					text = "按类型筛选物品"
				},
				{
					id = 2,
					type = "description",
					text = "显示所有物品。"
				}
			];

		case "character-screen.right-panel-header-module.FilterWeaponsButton":
			return [
				{
					id = 1,
					type = "title",
					text = "按类型筛选物品"
				},
				{
					id = 2,
					type = "description",
					text = "只显示武器、攻击性工具和附件。"
				}
			];

		case "character-screen.right-panel-header-module.FilterArmorButton":
			return [
				{
					id = 1,
					type = "title",
					text = "按类型筛选物品"
				},
				{
					id = 2,
					type = "description",
					text = "只显示盔甲、头盔和盾牌。"
				}
			];

		case "character-screen.right-panel-header-module.FilterMiscButton":
			return [
				{
					id = 1,
					type = "title",
					text = "按类型筛选物品"
				},
				{
					id = 2,
					type = "description",
					text = "只显示补给、食物、贵重物品和其他物品。"
				}
			];

		case "character-screen.right-panel-header-module.FilterUsableButton":
			return [
				{
					id = 1,
					type = "title",
					text = "按类型筛选物品"
				},
				{
					id = 2,
					type = "description",
					text = "只显示在仓库模式下可用的物品，如油漆或盔甲升级。"
				}
			];

		case "character-screen.right-panel-header-module.FilterMoodButton":
			return [
				{
					id = 1,
					type = "title",
					text = "显示/隐藏情绪"
				},
				{
					id = 2,
					type = "description",
					text = "在显示和隐藏你的人的情绪之间切换。"
				}
			];

		case "character-screen.battle-start-footer-module.StartBattleButton":
			return [
				{
					id = 1,
					type = "title",
					text = "开始战斗"
				},
				{
					id = 2,
					type = "description",
					text = "使用选定的装备开始战斗。"
				}
			];

		case "character-screen.levelup-popup-dialog.StatIncreasePoints":
			return [
				{
					id = 1,
					type = "title",
					text = "属性点"
				},
				{
					id = 2,
					type = "description",
					text = "花费这些点以随机增加每个级别8个属性中的任意3个。 每个级别只能增加一次单个属性。\n\n星星意味着一个角色具有特殊的天赋，并具有特定的属性，从而持续地产生更好的随机值。"
				}
			];

		case "character-screen.dismiss-popup-dialog.Compensation":
			return [
				{
					id = 1,
					type = "title",
					text = "补偿"
				},
				{
					id = 2,
					type = "description",
					text = "给被解雇者支付一笔赔偿金、酬金或是养老金，这有助于使他们离开公司时能够保有尊严并能够开启新的生活，同时也避免其他公司员工因解雇而产生的愤怒情绪。\n为负债的人支付赔偿金以弥补他们在公司工作的时间。其他负债者会感激你支付赔偿金，但如果你不支付，谁也不会因此而生气。"
				}
			];

		case "world-screen.topbar.TimePauseButton":
			return [
				{
					id = 1,
					type = "title",
					text = "暂停 (空格键)"
				},
				{
					id = 2,
					type = "description",
					text = "暂停游戏。"
				}
			];

		case "world-screen.topbar.TimeNormalButton":
			return [
				{
					id = 1,
					type = "title",
					text = "正常速度 (1)"
				},
				{
					id = 2,
					type = "description",
					text = "设置通过的时间为正常。"
				}
			];

		case "world-screen.topbar.TimeFastButton":
			return [
				{
					id = 1,
					type = "title",
					text = "快速 (2)"
				},
				{
					id = 2,
					type = "description",
					text = "设置通过的时间快于正常速度。"
				}
			];

		case "world-screen.topbar.options-module.ActiveContractButton":
			return [
				{
					id = 1,
					type = "title",
					text = "当前合同"
				},
				{
					id = 2,
					type = "description",
					text = "显示当前合同的详细信息。"
				}
			];

		case "world-screen.topbar.options-module.RelationsButton":
			return [
				{
					id = 1,
					type = "title",
					text = "显示派系和关系 (R)"
				},
				{
					id = 2,
					type = "description",
					text = "看看你所知道的所有派别以及你与他们的关系。"
				}
			];

		case "world-screen.topbar.options-module.CenterButton":
			return [
				{
					id = 1,
					type = "title",
					text = "相机居中 (回车键, Shift)"
				},
				{
					id = 2,
					type = "description",
					text = "把相机移到中间，放大你的雇佣兵战队。"
				}
			];

		case "world-screen.topbar.options-module.CameraLockButton":
			return [
				{
					id = 1,
					type = "title",
					text = "切换锁定相机 (X)"
				},
				{
					id = 2,
					type = "description",
					text = "锁定或解锁相机，始终集中在你的雇佣兵战队。"
				}
			];

		case "world-screen.topbar.options-module.TrackingButton":
			return [
				{
					id = 1,
					type = "title",
					text = "切换跟踪足迹 (F)"
				},
				{
					id = 2,
					type = "description",
					text = "显示或隐藏游戏世界的其他方留下的足迹，以便你可以更容易地跟踪或避免它们。"
				}
			];

		case "world-screen.topbar.options-module.CampButton":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "扎营 (T)"
				},
				{
					id = 2,
					type = "description",
					text = "搭帐篷或拆帐篷。 扎营的时候，时间会更快，你的人会更快的治愈和修复他们的装备。 然而，你也更容易受到突然袭击。"
				}
			];

			if (!this.World.State.isCampingAllowed())
			{
				ret.push({
					id = 9,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]与其他方旅行时无法露营[/color]"
				});
			}

			return ret;

		case "world-screen.topbar.options-module.PerksButton":
			return [
				{
					id = 1,
					type = "title",
					text = "随从 (P)"
				},
				{
					id = 2,
					type = "description",
					text = "看看你的非战斗追随者随从在战斗之外给予的各种优势，并升级你的货车以获得更多的库存空间。"
				}
			];

		case "world-screen.topbar.options-module.ObituaryButton":
			return [
				{
					id = 1,
					type = "title",
					text = "讣告 (O)"
				},
				{
					id = 2,
					type = "description",
					text = "看看这篇讣告，上面列出了自你上任以来为战队服务的人。"
				}
			];

		case "world-screen.topbar.options-module.QuitButton":
			return [
				{
					id = 1,
					type = "title",
					text = "打开菜单 (Esc)"
				},
				{
					id = 2,
					type = "description",
					text = "打开菜单保存或加载游戏，调整游戏选项或退出战役并返回主菜单。"
				}
			];

		case "world-screen.active-contract-panel-module.ToggleVisibilityButton":
			return [
				{
					id = 1,
					type = "title",
					text = "取消合同"
				},
				{
					id = 2,
					type = "description",
					text = "取消当前合同。"
				}
			];

		case "world-screen.obituary.ColumnName":
			return [
				{
					id = 1,
					type = "title",
					text = "Name"
				},
				{
					id = 2,
					type = "description",
					text = "角色的名称。"
				}
			];

		case "world-screen.obituary.ColumnTime":
			return [
				{
					id = 1,
					type = "title",
					text = "天"
				},
				{
					id = 2,
					type = "description",
					text = "角色在战队任职到其死亡的天数。"
				}
			];

		case "world-screen.obituary.ColumnBattles":
			return [
				{
					id = 1,
					type = "title",
					text = "战斗"
				},
				{
					id = 2,
					type = "description",
					text = "角色在死亡前所经历的战斗次数。"
				}
			];

		case "world-screen.obituary.ColumnKills":
			return [
				{
					id = 1,
					type = "title",
					text = "击杀"
				},
				{
					id = 2,
					type = "description",
					text = "角色在战斗中获得的杀戮数量，直到他们死亡。"
				}
			];

		case "world-screen.obituary.ColumnKilledBy":
			return [
				{
					id = 1,
					type = "title",
					text = "终结"
				},
				{
					id = 2,
					type = "description",
					text = "角色最终如何死亡。"
				}
			];

		case "world-town-screen.main-dialog-module.LeaveButton":
			return [
				{
					id = 1,
					type = "title",
					text = "离开"
				},
				{
					id = 2,
					type = "description",
					text = "离开并返回世界地图。"
				}
			];

		case "world-town-screen.main-dialog-module.Contract":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "可接受的合同"
				},
				{
					id = 2,
					type = "description",
					text = "有人想雇佣雇佣兵。"
				}
			];
			return ret;

		case "world-town-screen.main-dialog-module.ContractNegotiated":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "可接受的合同"
				},
				{
					id = 2,
					type = "description",
					text = "这个合同的条款已经谈妥了。 剩下的就是你签字了。"
				}
			];
			return ret;

		case "world-town-screen.main-dialog-module.ContractDisabled":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "你已经有合同了！"
				},
				{
					id = 2,
					type = "description",
					text = "一次只能开启一个合同。 合同报价将在你履行当前合同时保留，只是别在引起麻烦时消失了。"
				}
			];
			return ret;

		case "world-town-screen.main-dialog-module.ContractLocked":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "合同已锁定"
				},
				{
					id = 2,
					type = "description",
					text = "这里只有拥有这座防御工事的贵族家族的合同，但他们不承认你值得他们关注。 增加你的声望，完成让贵族家族注意到你的战队的野心，以解锁新合同！"
				}
			];
			return ret;

		case "world-town-screen.main-dialog-module.Crowd":
			return [
				{
					id = 1,
					type = "title",
					text = "雇用"
				},
				{
					id = 2,
					type = "description",
					text = "为你的雇佣兵战队雇佣新人。 志愿者的质量和数量取决于这个定居点的规模和类型，以及你在这里的声誉。 每隔几天，就会有新的人来，其他人会继续旅行。"
				}
			];

		case "world-town-screen.main-dialog-module.Tavern":
			return [
				{
					id = 1,
					type = "title",
					text = "酒馆"
				},
				{
					id = 2,
					type = "description",
					text = "一家大酒馆，到处都是顾客，提供饮料、食物和活跃的气氛，可以分享新闻和谣言。"
				}
			];

		case "world-town-screen.main-dialog-module.Temple":
			return [
				{
					id = 1,
					type = "title",
					text = "神殿"
				},
				{
					id = 2,
					type = "description",
					text = "远离外面严酷世界的避难所。 你可以在这里为你的伤者寻求治疗，并为你永恒灵魂的拯救祈祷。"
				}
			];

		case "world-town-screen.main-dialog-module.VeteransHall":
			return [
				{
					id = 1,
					type = "title",
					text = "训练厅"
				},
				{
					id = 2,
					type = "description",
					text = "战斗专业人士的集合点。 让你的士兵在这里接受训练并向有经验的战士学习，这样你就能更快地把他们塑造成坚强的雇佣兵。"
				}
			];

		case "world-town-screen.main-dialog-module.Taxidermist":
			return [
				{
					id = 1,
					type = "title",
					text = "剥制屋"
				},
				{
					id = 2,
					type = "description",
					text = "如果价格合适，一个剥制师可以从你带给他的各种战利品中创造出有用的物品。"
				}
			];

		case "world-town-screen.main-dialog-module.Kennel":
			return [
				{
					id = 1,
					type = "title",
					text = "狗舍"
				},
				{
					id = 2,
					type = "description",
					text = "为战争而饲养强壮而快速的狗的狗舍。"
				}
			];

		case "world-town-screen.main-dialog-module.Barber":
			return [
				{
					id = 1,
					type = "title",
					text = "理发店"
				},
				{
					id = 2,
					type = "description",
					text = "在理发店定制你的人的外表。 剪掉头发，修剪胡须，或者买些不可靠的药剂来减肥。"
				}
			];

		case "world-town-screen.main-dialog-module.Fletcher":
			return [
				{
					id = 1,
					type = "title",
					text = "弓箭铺"
				},
				{
					id = 2,
					type = "description",
					text = "弓弩店提供各种精心制作的远程武器。"
				}
			];

		case "world-town-screen.main-dialog-module.Alchemist":
			return [
				{
					id = 1,
					type = "title",
					text = "炼金术士"
				},
				{
					id = 2,
					type = "description",
					text = "炼金术士提供异国情调和相当危险的装置，需要一笔可观的费用。"
				}
			];

		case "world-town-screen.main-dialog-module.Arena":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "竞技场"
				},
				{
					id = 2,
					type = "description",
					text = "这个竞技场提供了一个机会，以殊死搏斗的形式，在为最可怕的杀人方式欢呼的人群面前，赢得金钱和名声。"
				}
			];

			if (this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().getBuilding("building.arena").isClosed())
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "今天这里没有比赛了。明天再来！"
				});
			}

			if (this.World.Contracts.getActiveContract() != null && this.World.Contracts.getActiveContract().getType() != "contract.arena" && this.World.Contracts.getActiveContract().getType() != "contract.arena_tournament")
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "你不能在签约做其他工作的时候在竞技场上战斗"
				});
			}
			else if (this.World.Contracts.getActiveContract() == null && this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().hasSituation("situation.arena_tournament") && this.World.Assets.getStash().getNumberOfEmptySlots() < 5)
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "你需要至少5个空的仓库空间才能在持续的比赛中战斗"
				});
			}
			else if (this.World.Contracts.getActiveContract() == null && this.World.Assets.getStash().getNumberOfEmptySlots() < 3)
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "你需要至少3个空的仓库空间在才能在竞技场战斗"
				});
			}

			return ret;

		case "world-town-screen.main-dialog-module.Port":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "港口"
				},
				{
					id = 2,
					type = "description",
					text = "为对外贸易船和当地渔民服务的港口。 你很可能在这里订到到达大陆其他地方的海上船票。"
				}
			];

			if (this.World.Contracts.getActiveContract() != null && this.World.Contracts.getActiveContract().getType() == "contract.escort_caravan")
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "合同规定护送商队时不能使用港口"
				});
			}

			return ret;

		case "world-town-screen.main-dialog-module.Marketplace":
			return [
				{
					id = 1,
					type = "title",
					text = "市场"
				},
				{
					id = 2,
					type = "description",
					text = "一个活跃的市场，提供该地区常见的各种商品。 每隔几天就会有新产品上市，当贸易商队到达这个定居点时。"
				}
			];

		case "world-town-screen.main-dialog-module.Weaponsmith":
			return [
				{
					id = 1,
					type = "title",
					text = "武器店"
				},
				{
					id = 2,
					type = "description",
					text = "一个武器匠的工作室展示各种精心制作的武器。 损坏的装备也可以在这里以一定的价格修理。"
				}
			];

		case "world-town-screen.main-dialog-module.Armorsmith":
			return [
				{
					id = 1,
					type = "title",
					text = "盔甲店"
				},
				{
					id = 2,
					type = "description",
					text = "这间盔甲店是寻找制作精良、经久耐用的防护用品的理想场所。 损坏的装备也可以在这里以一定的价格修理。"
				}
			];

		case "world-town-screen.hire-dialog-module.LeaveButton":
			return [
				{
					id = 1,
					type = "title",
					text = "离开"
				},
				{
					id = 2,
					type = "description",
					text = "离开此屏幕并返回上一个屏幕。"
				}
			];

		case "world-town-screen.hire-dialog-module.HireButton":
			return [
				{
					id = 1,
					type = "title",
					text = "雇佣新兵"
				},
				{
					id = 2,
					type = "description",
					text = "雇佣选定的新兵，让他加入你的名册。"
				}
			];

		case "world-town-screen.hire-dialog-module.TryoutButton":
			return [
				{
					id = 1,
					type = "title",
					text = "测验新兵"
				},
				{
					id = 2,
					type = "description",
					text = "给被选中的新兵一个适当的测试，以揭示他隐藏的特性，如果有的话。"
				}
			];

		case "world-town-screen.hire-dialog-module.UnknownTraits":
			return [
				{
					id = 1,
					type = "title",
					text = "未知角色特性"
				},
				{
					id = 2,
					type = "description",
					text = "这个角色可能有未知的特性。 你可以支付费用尝试展示这些。"
				}
			];

		case "world-town-screen.taxidermist-dialog-module.CraftButton":
			return [
				{
					id = 1,
					type = "title",
					text = "制作"
				},
				{
					id = 2,
					type = "description",
					text = "支付指定的费用，并移交必要的组件，以接收精心制作的物品作为回报。"
				}
			];

		case "world-town-screen.travel-dialog-module.LeaveButton":
			return [
				{
					id = 1,
					type = "title",
					text = "离开"
				},
				{
					id = 2,
					type = "description",
					text = "离开此屏幕并返回上一个屏幕。"
				}
			];

		case "world-town-screen.travel-dialog-module.TravelButton":
			return [
				{
					id = 1,
					type = "title",
					text = "旅行"
				},
				{
					id = 2,
					type = "description",
					text = "为你的战队预订商票，并快速前往选定的目的地。"
				}
			];

		case "world-town-screen.shop-dialog-module.LeaveButton":
			return [
				{
					id = 1,
					type = "title",
					text = "离开商店"
				},
				{
					id = 2,
					type = "description",
					text = "离开此屏幕并返回上一个屏幕。"
				}
			];

		case "world-town-screen.training-dialog-module.Train1":
			return [
				{
					id = 1,
					type = "title",
					text = "搏斗练习"
				},
				{
					id = 2,
					type = "description",
					text = "让你的队员与有经验的对手进行练习战斗，并学习不同的战斗方式。所获得的挫伤和经验教训将会导致[color=" + this.Const.UI.Color.PositiveValue + "]+50%[/color] 经验加成（下一场战斗）。"
				}
			];

		case "world-town-screen.training-dialog-module.Train2":
			return [
				{
					id = 1,
					type = "title",
					text = "老兵的课程"
				},
				{
					id = 2,
					type = "description",
					text = "让您的人从一位真正的行业老手那里学习有价值的课程和经验。所传授的知识将导致[color=" + this.Const.UI.Color.PositiveValue + "]+35%[/color] 经验获取（持续三场战斗）。"
				}
			];

		case "world-town-screen.training-dialog-module.Train3":
			return [
				{
					id = 1,
					type = "title",
					text = "严格的训练"
				},
				{
					id = 2,
					type = "description",
					text = "让你的人接受严格的训练计划，将他打造成一个熟练的战士。今天所付出的血汗将会使他日后受益匪浅。[color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] 经验加成，持续五场战斗。"
				}
			];

		case "world-game-finish-screen.dialog-module.QuitButton":
			return [
				{
					id = 1,
					type = "title",
					text = "退出游戏"
				},
				{
					id = 2,
					type = "description",
					text = "退出游戏并返回主菜单。 你在这里的进度将不会被保存。"
				}
			];

		case "world-relations-screen.Relations":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "关系"
				},
				{
					id = 2,
					type = "description",
					text = "你与某个派系的关系决定了他们是否会与你进行和平的战斗或交易，他们是否愿意雇佣你来签订合同，以及他们给你的价格和在他们的定居点为你提供的新兵数量。\n\n当成功地为派系工作时，关系会增加，如果不这样做，背叛或攻击派系，关系会减少。 随着时间的推移，双方关系逐渐趋于中立。"
				}
			];
			local changes = this.World.FactionManager.getFaction(_entityId).getPlayerRelationChanges();

			foreach( change in changes )
			{
				if (change.Positive)
				{
					ret.push({
						id = 11,
						type = "hint",
						icon = "ui/tooltips/positive.png",
						text = "" + change.Text + ""
					});
				}
				else
				{
					ret.push({
						id = 11,
						type = "hint",
						icon = "ui/tooltips/negative.png",
						text = "" + change.Text + ""
					});
				}
			}

			return ret;

		case "world-campfire-screen.Cart":
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.Const.Strings.InventoryHeader[this.World.Retinue.getInventoryUpgrades()]
				},
				{
					id = 2,
					type = "description",
					text = "雇佣兵战队必须携带大量的装备和物资。 通过使用货车和载重货车，你可以扩大你的可用库存空间，并携带更多。"
				}
			];

			if (this.World.Retinue.getInventoryUpgrades() < this.Const.Strings.InventoryUpgradeHeader.len())
			{
				ret.push({
					id = 1,
					type = "hint",
					icon = "ui/icons/mouse_left_button.png",
					text = this.Const.Strings.InventoryUpgradeHeader[this.World.Retinue.getInventoryUpgrades()] + "对于[img]gfx/ui/tooltips/money.png[/img]" + this.Const.Strings.InventoryUpgradeCosts[this.World.Retinue.getInventoryUpgrades()]
				});
			}

			return ret;

		case "dlc_1":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Lindwurm"
				},
				{
					id = 2,
					type = "description",
					text = "免费的林德虫DLC增加了一个具有挑战性的新野兽，一些新的玩家旗帜，以及一些新的著名的盔甲、头盔和盾牌。"
				}
			];

			if (this.Const.DLC.Lindwurm == true)
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.PositiveValue + "]此DLC已安装。[/color]";
			}
			else
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.NegativeValue + "]此DLC缺失。 在Steam和GOG上免费提供！[/color]";
			}

			ret.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_left_button.png",
				text = "在浏览器里打开商店页面"
			});
			return ret;

		case "dlc_2":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "野兽与探险"
				},
				{
					id = 2,
					type = "description",
					text = "野兽与探索DLC增加了各种新的野兽在野外游荡，一个新的工艺系统从战利品创建物品，具有独特奖励发现的传奇地点，许多新的合同和事件，一个新的盔甲附件系统，新的武器，盔甲和可用物品，等等。"
				}
			];

			if (this.Const.DLC.Unhold == true)
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.PositiveValue + "]此DLC已安装。[/color]";
			}
			else
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.NegativeValue + "]此DLC缺失。 可以在Steam和GOG上购买！[/color]";
			}

			ret.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_left_button.png",
				text = "在浏览器里打开商店页面"
			});
			return ret;

		case "dlc_4":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "北方的勇士"
				},
				{
					id = 2,
					type = "description",
					text = "北方的勇士DLC添加了一个新的北方野蛮人派系，他们有自己的战斗风格和装备，你的战队有不同的开始剧情，新的北欧和罗斯优秀的装备，以及新的合同和事件。"
				}
			];

			if (this.Const.DLC.Wildmen == true)
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.PositiveValue + "]此DLC已安装。[/color]";
			}
			else
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.NegativeValue + "]此DLC缺失。 可以在Steam和GOG上购买！[/color]";
			}

			ret.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_left_button.png",
				text = "在浏览器里打开商店页面"
			});
			return ret;

		case "dlc_6":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "炽热的沙漠"
				},
				{
					id = 2,
					type = "description",
					text = "炽热的沙漠DLC为南方增添了一个新的沙漠地区，灵感来自中世纪的阿拉伯和波斯文化，一场新的涉及圣战的游戏后期危机，非战斗追随者随从可以改制你的战队，炼金术装置和原始火器，新的人类和野兽对手，新的合同和事件，等等。"
				}
			];

			if (this.Const.DLC.Desert == true)
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.PositiveValue + "]此DLC已安装。[/color]";
			}
			else
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.NegativeValue + "]此DLC缺失。 可以在Steam和GOG上购买！[/color]";
			}

			ret.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_left_button.png",
				text = "在浏览器里打开商店页面"
			});
			return ret;

		case "dlc_8":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "血肉与信仰"
				},
				{
					id = 2,
					type = "description",
					text = "自由的血肉与信仰DLC为你添加了两个新的、非常独特的起源：解剖学家和宣誓者。 此外，还有两个新的旗帜、新装备、新的雇佣背景和许多新事件。"
				}
			];

			if (this.Const.DLC.Paladins == true)
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.PositiveValue + "]此DLC已安装。[/color]";
			}
			else
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.NegativeValue + "]此DLC缺失。 在Steam和GOG上免费提供！[/color]";
			}

			ret.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_left_button.png",
				text = "在浏览器里打开商店页面"
			});
			return ret;
		}

		return null;
	}

};

