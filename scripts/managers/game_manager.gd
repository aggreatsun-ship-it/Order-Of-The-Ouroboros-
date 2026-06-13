# Game Manager - Central game state controller
extends Node

class_name GameManager

# Singleton pattern
static var instance: GameManager

# Game state
var current_scene: String = "main_menu"
var current_character: Character
var current_transmutation_stage: int = 1  # 1-7
var current_essence_inventory: Dictionary = {}  # essence_type: count
var player_choice_path: String = "neutral"  # "light", "shadow", "neutral"
var roguelike_active: bool = false
var campaign_progress: Dictionary = {}  # chapter: bool_completed

func _ready():
	if instance == null:
		instance = self
		set_as_top_level()
	else:
		queue_free()

func new_game(character_id: int) -> void:
	current_character = Character.new(character_id)
	current_transmutation_stage = 1
	current_essence_inventory.clear()
	player_choice_path = "neutral"
	roguelike_active = false
	campaign_progress.clear()
	print("New game started with character: ", character_id)

func start_roguelike(character_id: int, stage: int) -> void:
	current_character = Character.new(character_id)
	current_transmutation_stage = stage
	roguelike_active = true
	current_essence_inventory.clear()
	print("Roguelike mode started at stage: ", stage)

func add_essence(essence_type: String, amount: int) -> void:
	if essence_type not in current_essence_inventory:
		current_essence_inventory[essence_type] = 0
	current_essence_inventory[essence_type] += amount

func remove_essence(essence_type: String, amount: int) -> bool:
	if essence_type in current_essence_inventory and current_essence_inventory[essence_type] >= amount:
		current_essence_inventory[essence_type] -= amount
		return true
	return false

func make_choice(choice_type: String) -> void:
	match choice_type:
		"light":
			if player_choice_path == "neutral":
				player_choice_path = "light"
			elif player_choice_path == "shadow":
				player_choice_path = "neutral"
		"shadow":
			if player_choice_path == "neutral":
				player_choice_path = "shadow"
			elif player_choice_path == "light":
				player_choice_path = "neutral"

	print("Player choice path: ", player_choice_path)

func advance_transmutation_stage() -> void:
	if current_transmutation_stage < 7:
		current_transmutation_stage += 1
		print("Advanced to transmutation stage: ", current_transmutation_stage)

func complete_chapter(chapter: int) -> void:
	campaign_progress[chapter] = true

func get_current_character() -> Character:
	return current_character

func save_game() -> void:
	print("Game saved")

func load_game() -> void:
	print("Game loaded")
