# Combat System - Handles real-time combat mechanics
extends Node

class_name CombatSystem

# Combat state
var player: Character
var current_enemy: Enemy
var is_combat_active: bool = false
var player_combo_count: int = 0
var player_combo_timer: float = 0.0

signal combat_started
signal combat_ended
signal player_attacked(damage: float)
signal enemy_attacked(damage: float)
signal combat_status_changed

func _ready():
	pass

func _process(delta: float) -> void:
	if is_combat_active:
		player_combo_timer -= delta
		if player_combo_timer <= 0:
			player_combo_count = 0

func start_combat(player_char: Character, enemy: Enemy) -> void:
	player = player_char
	current_enemy = enemy
	is_combat_active = true
	player_combo_count = 0
	combat_started.emit()
	print("Combat started!")

func end_combat() -> void:
	is_combat_active = false
	combat_ended.emit()
	print("Combat ended!")

func player_basic_attack() -> void:
	if not is_combat_active or player == null or current_enemy == null:
		return
	
	player_combo_count += 1
	player_combo_timer = 3.0  # 3 second window for combos
	
	var base_damage = player.attack
	var combo_multiplier = 1.0 + (player_combo_count * 0.2)  # 20% per combo
	var total_damage = base_damage * combo_multiplier
	
	# Apply enemy defense
	total_damage = max(1, total_damage - (current_enemy.defense * 0.5))
	
	current_enemy.take_damage(total_damage)
	player_attacked.emit(total_damage)
	
	print("Player attacks for ", total_damage, " damage! Combo: ", player_combo_count)
	
	if current_enemy.current_health <= 0:
		end_combat()
		player.gain_experience(current_enemy.xp_reward)

func player_use_ability(ability_name: String) -> void:
	if not is_combat_active or player == null or current_enemy == null:
		return
	
	if not player.use_ability(ability_name):
		print("Ability ", ability_name, " failed or on cooldown")
		return
	
	match ability_name:
		"venom_strike":
			var damage = player.attack * 1.5
			current_enemy.take_damage(damage)
			current_enemy.apply_status_effect("poison", 3.0)
			player_attacked.emit(damage)
		
		"inferno_burst":
			var damage = player.attack * 2.0
			current_enemy.take_damage(damage)
			current_enemy.apply_status_effect("burn", 5.0)
			player_attacked.emit(damage)
		
		"tidal_wave":
			var damage = player.attack * 1.8
			current_enemy.take_damage(damage)
			current_enemy.apply_status_effect("slow", 4.0)
			player_attacked.emit(damage)
		
		"radiant_blessing":
			var heal_amount = 30
			player.heal(heal_amount)
			player_attacked.emit(-heal_amount)  # Negative for healing
	
	if current_enemy.current_health <= 0:
		end_combat()
		player.gain_experience(current_enemy.xp_reward)

func player_dodge() -> bool:
	if not is_combat_active:
		return false
	
	# Dodge chance based on speed stat
	var dodge_chance = player.speed * 0.05  # 5% per speed point
	var random_roll = randf()
	
	return random_roll < dodge_chance

func enemy_turn() -> void:
	if not is_combat_active or current_enemy == null or player == null:
		return
	
	# Simple AI: attack or use ability randomly
	var action = randi() % 3
	
	match action:
		0:  # Basic attack
			enemy_basic_attack()
		1:  # Use ability
			enemy_use_ability()
		2:  # Defend
			enemy_defend()

func enemy_basic_attack() -> void:
	if player == null or current_enemy == null:
		return
	
	var damage = current_enemy.attack
	
	# Check player dodge
	if player_dodge():
		print("Player dodged!")
		return
	
	# Apply player defense
	damage = max(1, damage - (player.defense * 0.5))
	
	player.take_damage(damage)
	enemy_attacked.emit(damage)
	print("Enemy attacks for ", damage, " damage!")
	
	if player.current_health <= 0:
		end_combat()

func enemy_use_ability() -> void:
	if current_enemy == null or player == null:
		return
	
	var enemy_abilities = current_enemy.get_abilities()
	if enemy_abilities.is_empty():
		enemy_basic_attack()
		return
	
	var random_ability = enemy_abilities[randi() % enemy_abilities.size()]
	var damage = current_enemy.attack * 1.3
	
	if player_dodge():
		print("Player dodged enemy ability!")
		return
	
	damage = max(1, damage - (player.defense * 0.5))
	player.take_damage(damage)
	enemy_attacked.emit(damage)

func enemy_defend() -> void:
	current_enemy.defense *= 1.5
	print("Enemy defends!")
