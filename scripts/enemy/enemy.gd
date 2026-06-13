# Enemy class - Base enemy system
extends Node

class_name Enemy

enum EnemyType {
	VOID_MINION,
	TWILIGHT_KNIGHT,
	ABYSS_CASTER,
	NIGHTMARE,
	TWISTED_BEAST
}

# Enemy properties
var enemy_type: EnemyType
var level: int = 1
var max_health: float = 50
var current_health: float = 50
var attack: float = 8
var defense: float = 3
var speed: float = 6
var xp_reward: int = 100

# Status effects
var status_effects: Dictionary = {}  # effect_name: remaining_time

# Abilities
var abilities: Array = []

func _init(enemy_id: int, lvl: int = 1):
	enemy_type = enemy_id
	level = lvl
	initialize_enemy(enemy_id, lvl)

func initialize_enemy(enemy_id: int, lvl: int) -> void:
	match enemy_id:
		EnemyType.VOID_MINION:
			max_health = 30 + (lvl * 5)
			attack = 5 + (lvl * 1)
			defense = 2
			speed = 5
			xp_reward = 50 + (lvl * 10)
			abilities = ["shadow_bolt"]
		
		EnemyType.TWILIGHT_KNIGHT:
			max_health = 60 + (lvl * 10)
			attack = 10 + (lvl * 2)
			defense = 6 + (lvl * 1)
			speed = 6
			xp_reward = 150 + (lvl * 20)
			abilities = ["dark_slash", "shield_bash"]
		
		EnemyType.ABYSS_CASTER:
			max_health = 40 + (lvl * 7)
			attack = 12 + (lvl * 2)
			defense = 3
			speed = 8
			xp_reward = 120 + (lvl * 15)
			abilities = ["void_blast", "curse"]
		
		EnemyType.NIGHTMARE:
			max_health = 100 + (lvl * 15)
			attack = 15 + (lvl * 3)
			defense = 8 + (lvl * 2)
			speed = 7
			xp_reward = 300 + (lvl * 50)
			abilities = ["nightmare_strike", "terror_aura", "void_summon"]
		
		EnemyType.TWISTED_BEAST:
			max_health = 80 + (lvl * 12)
			attack = 13 + (lvl * 2)
			defense = 4
			speed = 9
			xp_reward = 200 + (lvl * 30)
			abilities = ["feral_bite", "roar"]
	
	current_health = max_health

func take_damage(damage: float) -> void:
	current_health = max(0, current_health - damage)
	if current_health == 0:
		print("Enemy defeated!")

func apply_status_effect(effect_name: String, duration: float) -> void:
	status_effects[effect_name] = duration
	print("Enemy affected by ", effect_name)

func remove_status_effect(effect_name: String) -> void:
	if effect_name in status_effects:
		status_effects.erase(effect_name)

func get_abilities() -> Array:
	return abilities

func _process(delta: float) -> void:
	# Update status effects
	for effect in status_effects:
		status_effects[effect] -= delta
		if status_effects[effect] <= 0:
			status_effects.erase(effect)

func apply_passive_damage() -> void:
	# Apply damage from status effects
	if "poison" in status_effects:
		take_damage(2)
	if "burn" in status_effects:
		take_damage(3)
