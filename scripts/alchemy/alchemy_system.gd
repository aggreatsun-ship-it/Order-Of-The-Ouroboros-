# Alchemy System - Essence crafting and transmutation
extends Node

class_name AlchemySystem

enum EssenceType {
	FIRE,
	WATER,
	EARTH,
	AIR,
	VOID,
	LIGHT,
	COSMIC
}

# Essence database
var essence_data: Dictionary = {
	"fire": {"damage": 15, "effect": "burn", "rarity": 1},
	"water": {"defense": 10, "effect": "slow", "rarity": 1},
	"earth": {"defense": 12, "effect": "stun", "rarity": 1},
	"air": {"speed": 8, "effect": "confusion", "rarity": 1},
	"void": {"damage": 20, "effect": "dark", "rarity": 2},
	"light": {"healing": 20, "effect": "purify", "rarity": 2},
	"cosmic": {"damage": 25, "effect": "universal", "rarity": 3}
}

# Spell recipes (essence combinations)
var spell_recipes: Dictionary = {
	"inferno": ["fire", "fire"],
	"steam": ["fire", "water"],
	"tsunami": ["water", "water"],
	"mud": ["water", "earth"],
	"earthquake": ["earth", "earth"],
	"dust_storm": ["earth", "air"],
	"cyclone": ["air", "air"],
	"equilibrium": ["void", "light"],
	"void_rift": ["void", "void"],
	"light_cascade": ["light", "light"],
	"cosmic_strike": ["cosmic", "fire"],
	"celestial_ward": ["cosmic", "light"]
}

# Spell properties
var spell_data: Dictionary = {
	"inferno": {"damage": 50, "aoe": true, "cost": 30},
	"steam": {"damage": 25, "slow": true, "cost": 20},
	"tsunami": {"damage": 45, "knockback": true, "cost": 35},
	"mud": {"trap": true, "slow": true, "cost": 15},
	"earthquake": {"damage": 40, "stun": true, "cost": 25},
	"dust_storm": {"confusion": true, "evasion": true, "cost": 20},
	"cyclone": {"pull": true, "damage": 30, "cost": 25},
	"equilibrium": {"heal": 40, "mana_restore": 20, "cost": 40},
	"void_rift": {"damage": 60, "summon": true, "cost": 50},
	"light_cascade": {"heal": 60, "purify": true, "cost": 50},
	"cosmic_strike": {"damage": 70, "universal": true, "cost": 45},
	"celestial_ward": {"shield": 50, "reflect": true, "cost": 40}
}

func craft_spell(essences: Array) -> Dictionary:
	# Sort essences for recipe matching
	essences.sort()
	var recipe_key = "_".join(essences)
	
	# Find matching recipe
	for spell_name in spell_recipes:
		var recipe = spell_recipes[spell_name]
		recipe.sort()
		var recipe_str = "_".join(recipe)
		
		if recipe_str == recipe_key:
			return craft_spell_from_recipe(spell_name, essences)
	
	return {"success": false, "message": "No matching recipe found"}

func craft_spell_from_recipe(spell_name: String, essences: Array) -> Dictionary:
	if spell_name not in spell_data:
		return {"success": false, "message": "Spell not found"}
	
	var spell = spell_data[spell_name].duplicate()
	spell["name"] = spell_name
	spell["essences"] = essences
	
	# Calculate synergy bonus if essences match
	var synergy_bonus = 1.0
	var essence_types = {}
	
	for essence in essences:
		if essence not in essence_types:
			essence_types[essence] = 0
		essence_types[essence] += 1
	
	# Check for matching pairs (synergy)
	for essence_type in essence_types:
		if essence_types[essence_type] > 1:
			synergy_bonus += 0.2 * essence_types[essence_type]
	
	# Apply synergy to damage
	if "damage" in spell:
		spell["damage"] *= synergy_bonus
	
	return {"success": true, "spell": spell, "synergy": synergy_bonus}

func calculate_essence_rarity(essence_name: String) -> int:
	if essence_name in essence_data:
		return essence_data[essence_name]["rarity"]
	return 0

func get_essence_effect(essence_name: String) -> String:
	if essence_name in essence_data:
		return essence_data[essence_name]["effect"]
	return ""

func list_all_spells() -> Array:
	return spell_recipes.keys()

func get_spell_info(spell_name: String) -> Dictionary:
	if spell_name in spell_data:
		var info = spell_data[spell_name].duplicate()
		info["name"] = spell_name
		if spell_name in spell_recipes:
			info["recipe"] = spell_recipes[spell_name]
		return info
	return {}
