extends Node2D
class_name LevelGenerator


@export var LEVELS_IN_LAYER : int = 10
@export var MAX_LEVELS_LOADED : int = 3

@export_group("Debugging")
@export var DISABLE_TUTORIAL : bool = false
@export var GENERATE_LETTERS_FASTER : bool = false
@export var STARTING_LAYER : LEVEL_LAYERS = LEVEL_LAYERS.A_LEVEL

@export_group("Layer directories")
@export var TUTORIAL_DIR : String
@export var A_LEVEL_DIR : String
@export var B_LEVEL_DIR : String
@export var C_LEVEL_DIR : String
@export var D_LEVEL_DIR : String

@export_group("Levels with letters")
@export var A_LETTER_LEVEL : PackedScene
@export var B_LETTER_LEVEL : PackedScene
@export var C_LETTER_LEVEL : PackedScene
@export var D_LETTER_LEVEL : PackedScene

@export_group("Other")
@export var FINAL_LEVEL : PackedScene


var tutorial_levels : Array[PackedScene]
var A_levels : Array[PackedScene]
var B_levels : Array[PackedScene]
var C_levels : Array[PackedScene]
var D_levels : Array[PackedScene]


var random_generator = RandomNumberGenerator.new()

enum LEVEL_LAYERS {
	A_LEVEL = 0, B_LEVEL = 1, C_LEVEL = 2, D_LEVEL = 3
}

var current_level_index : int
var layer_levels_generated : int
var levels_played : int

var current_level_layer : LEVEL_LAYERS

var letter_level_index_in_layer : int
var current_letter_level : PackedScene


func _ready() -> void:
	
	update_current_level_layer(STARTING_LAYER)
	
	if GENERATE_LETTERS_FASTER or GlobalValues.is_generating_letter_levels:
		generate_letter_level_index_in_layer()
		GlobalValues.is_generating_letter_levels = true
	
	if DISABLE_TUTORIAL:
		GlobalValues.is_tutorial_finished = true
	
	levels_played = 0
	layer_levels_generated = 0
	current_level_index = 0
	
	A_levels = get_all_levels(A_LEVEL_DIR)
	B_levels = get_all_levels(B_LEVEL_DIR)
	C_levels = get_all_levels(C_LEVEL_DIR)
	D_levels = get_all_levels(D_LEVEL_DIR)
	
	if not GlobalValues.is_tutorial_finished:
		levels_played -= 1
		tutorial_levels = get_all_levels(TUTORIAL_DIR)
		
		for tutorial_level in tutorial_levels:
			generate_next_level(tutorial_level)
	
	for i in range(2):
		generate_next_level()
	
	GlobalSignals.next_level.connect(_on_next_level)


func _on_next_level() -> void:
	generate_next_level()
	
	levels_played += 1
	
	if (levels_played % LEVELS_IN_LAYER == 0) and (levels_played > 0):
		GlobalSignals.new_layer_reached.emit(current_level_layer)
		
		if current_level_layer == LEVEL_LAYERS.A_LEVEL:
			GlobalSignals.new_lap_started.emit()
	
	if get_child_count() > (MAX_LEVELS_LOADED-1):
		get_child(0).queue_free()


func generate_next_level(custom_level: PackedScene = null) -> Level:
	var level_array : Array[PackedScene] = get_level_array_from_layer(current_level_layer)
	var next_level : PackedScene
	
	
	if custom_level:
		next_level = custom_level
	elif (
		GlobalValues.is_generating_letter_levels and
		(current_level_index % LEVELS_IN_LAYER) == letter_level_index_in_layer
	):
		next_level = current_letter_level
		layer_levels_generated += 1
	else:
		next_level = pick_level_from_level_array(level_array)
		layer_levels_generated += 1
	
	var level_positopn := Vector2(0, -17*64*current_level_index)
	var added_level : Level = add_level_to_scene(next_level, level_positopn)
	
	current_level_index += 1
	
	if (layer_levels_generated % LEVELS_IN_LAYER == 0) and (layer_levels_generated > 0):
		update_current_level_layer()
		generate_letter_level_index_in_layer()
	
	return added_level


func add_level_to_scene(level: PackedScene, level_position: Vector2 = Vector2.ZERO) -> Level:
	var new_level : Level = level.instantiate()
	new_level.position = level_position
	new_level.level_path = level.resource_path
	
	call_deferred('add_child', new_level)
	return new_level


func get_level_array_from_layer(level_layer: LEVEL_LAYERS) -> Array[PackedScene]:
	match level_layer:
		LEVEL_LAYERS.A_LEVEL:
			return A_levels
		LEVEL_LAYERS.B_LEVEL:
			return B_levels
		LEVEL_LAYERS.C_LEVEL:
			return C_levels
		LEVEL_LAYERS.D_LEVEL:
			return D_levels
		_:
			return []


func pick_level_from_level_array(level_array: Array[PackedScene]) -> PackedScene:
	var level_id := random_generator.randi_range(0, len(level_array)-1)
	return level_array[level_id]


@warning_ignore("int_as_enum_without_cast", "int_as_enum_without_match")
func update_current_level_layer(custom: LEVEL_LAYERS = -1) -> void:
	if custom != -1:
		current_level_layer = custom
		return
	
	match current_level_layer:
		LEVEL_LAYERS.A_LEVEL:
			current_level_layer = LEVEL_LAYERS.B_LEVEL
		LEVEL_LAYERS.B_LEVEL:
			current_level_layer = LEVEL_LAYERS.C_LEVEL
			GlobalValues.is_generating_letter_levels = true
		LEVEL_LAYERS.C_LEVEL:
			current_level_layer = LEVEL_LAYERS.D_LEVEL
		LEVEL_LAYERS.D_LEVEL:
			current_level_layer = LEVEL_LAYERS.A_LEVEL


func get_all_levels(directory_path: String) -> Array[PackedScene]:
	var output : Array[PackedScene]
	
	var dir = DirAccess.open(directory_path)
	if dir:
		for file_name in dir.get_files():
			if file_name.get_extension() == "remap":
				file_name = file_name.replace(".remap", "")
			
			if file_name.get_extension() == "tscn":
				var full_path = directory_path.path_join(file_name)
				output.append(load(full_path))
	
	return output


func generate_letter_level_index_in_layer() -> void:
	letter_level_index_in_layer = random_generator.randi_range(0, LEVELS_IN_LAYER-1)
	
	match current_level_layer:
		LEVEL_LAYERS.A_LEVEL:
			current_letter_level = A_LETTER_LEVEL
		LEVEL_LAYERS.B_LEVEL:
			current_letter_level = B_LETTER_LEVEL
		LEVEL_LAYERS.C_LEVEL:
			current_letter_level = C_LETTER_LEVEL
		LEVEL_LAYERS.D_LEVEL:
			current_letter_level = D_LETTER_LEVEL


func generate_final_level() -> void:
	print('generate_next_level(FINAL_LEVEL)')
	generate_next_level(FINAL_LEVEL)
