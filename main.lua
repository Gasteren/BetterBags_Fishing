---@type string, AddonNS
local _, addon = ...
---@class BetterBags: AceAddon
local BetterBags = LibStub('AceAddon-3.0'):GetAddon("BetterBags")
---@class Categories: AceModule
local categories = BetterBags:GetModule('Categories')
---@class Localization: AceModule
local L = BetterBags:GetModule('Localization')

-- Retail reports a 6-digit interface version (110000+).
-- WoW: Forever runs the modern client engine but reports a 5-digit, classic-style
-- interface version (16001 at time of writing), even though WOW_PROJECT_ID says
-- "mainline" same as retail. So the interface number is the reliable signal here.
local interfaceVersion = select(4, GetBuildInfo())
local isForever = interfaceVersion < 100000

local itemSet = isForever and addon.db.Forever or addon.db.Retail

for category, items in pairs(itemSet) do
	for _, item in pairs(items) do
		if C_Item.DoesItemExistByID(item) then
			local ok, err = pcall(categories.AddItemToCategory, categories, item, L:G(category))
			if not ok then
				print("|cffff0000BetterBags_Fishing:|r failed to add item " .. tostring(item) .. " to category '" .. tostring(category) .. "': " .. tostring(err))
			end
		end
	end
end
