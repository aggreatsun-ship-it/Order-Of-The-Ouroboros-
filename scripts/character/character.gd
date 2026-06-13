# Character class - Base character system
extends Node

class_name Character

enum CharacterType {
	SERPENT_GUARDIAN,
	SHADOW_ALCHEMIST,
	SHARK_TOOTH,
	LOCKE_STAR,
	ANCIENT_SAGE,
	PHIA,
	VEILED_INITIATE
}

# Character properties
var character_type: CharacterType
var level: int = 1
var experience: int = 0
var max_health: float = 100
var current_health: float = 100
var max_mana: float = 50
var current_mana: float = 50
var attack: float = 10
var defense: float = 5
var speed: float = 8

# Skill tree
var skill_tree: Dictionary = {
	"aggression": {},
	"defense": {},
	"alchemy": {}
}

# Equipment
var weapon: String = "basic_sword"
var armor: String = "basic_armor"
var accessories: Array = []

# Abilities
var abilities: Array = []
var active_ability_cooldowns: Dictionary = {}

func _init(character_id: int):
	character_type = character_id
	initialize_character(character_id)

func initialize_character(character_id: int) -> void:
	match character_id:
		CharacterType.SERPENT_GUARDIAN:
			max_health = 120
			max_mana = 30
			attack = 15
			defense = 8
			speed = 7
			abilities = ["venom_strike", "serpent_coil"]
		
		CharacterType.SHADOW_ALCHEMIST:
			max_health = 90
			max_mana = 60
			attack = 10
			defense = 6
			speed = 9
			abilities = ["essence_extraction", "shadow_step"]
		
		CharacterType.SHARK_TOOTH:
			max_health = 95
			max_mana = 55
			attack = 12
			defense = 5
			speed = 10
			abilities = ["tidal_wave", "rhythm_strike"]
		
		CharacterType.LOCKE_STAR:
			max_health = 130
			max_mana = 40
			attack = 18
			defense = 10
			speed = 6
			abilities = ["inferno_burst", "flame_shield"]
		
		CharacterType.ANCIENT_SAGE:
			max_health = 100
			max_mana = 80
			attack = 11
			defense = 7
			speed = 8
			abilities = ["celestial_judgment", "cosmic_ward"]
		
		CharacterType.PHIA:
			max_health = 110
			max_mana = 70
			attack = 13
			defense = 9
			speed = 8
			abilities = ["radiant_blessing", "divine_strike"]
		
		CharacterType.VEILED_INITIATE:
			max_health = 85
			max_mana = 90
			attack = 9
			defense = 4
			speed = 9
			abilities = ["void_rift", "shadow_clone"]
	
	current_health = max_health
	current_mana = max_mana

func take_damage(damage: float) -> void:
	current_health = max(0, current_health - damage)
	if current_health == 0:
		print("Character defeated!")

func heal(amount: float) -> void:
	current_health = min(max_health, current_health + amount)

func use_mana(amount: float) -> bool:
	if current_mana >= amount:
		current_mana -= amount
		return true
	return false

func restore_mana(amount: float) -> void:
	current_mana = min(max_mana, current_mana + amount)

func gain_experience(amount: int) -> void:
	experience += amount
	var xp_required = level * 100
	if experience >= xp_required:
		level_up()

func level_up() -> void:
	level += 1
	max_health += 10
	max_mana += 5
	attack += 2
	defense += 1
	current_health = max_health
	current_mana = max_mana
	experience = 0
	print("Leveled up to: ", level)

func equip_weapon(weapon_name: String) -> void:
	weapon = weapon_name


func equip_armor(armor_name: String) -> void:
	armor = armor_name

func use_ability(ability_name: String) -> bool:
	if ability_name not in abilities:
		return false
	
	if ability_name in active_ability_cooldowns:
		if active_ability_cooldowns[ability_name] > 0:
			return false
	
	# Execute ability logic here
	print("Using ability: ", ability_name)
	
	# Start cooldown
	active_ability_cooldowns[ability_name] = 5.0  # 5 second cooldown
	
	return true

func _process(delta: float) -> void:
	# Update cooldowns
	for ability in active_ability_cooldowns:
		active_ability_cooldowns[ability] -= delta
		if active_ability_cooldowns[ability] < 0:
			active_ability_cooldowns[ability] = 0
