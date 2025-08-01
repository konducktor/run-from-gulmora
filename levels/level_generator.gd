extends Node2D
class_name LevelGenerator



@export var LEVELS_IN_LAYER : int = 5
@export var MAX_LEVELS_LOADED : int = 3

@export_group("Debugging")
@export var DISABLE_TUTORIAL : bool = false
@export var GENERATE_LETTERS_FASTER : bool = false

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

@export_group("")
@export var FINAL_LEVEL : PackedScene


var tutorial_levels : Array[PackedScene]
var A_levels : Array[PackedScene]
var B_levels : Array[PackedScene]
var C_levels : Array[PackedScene]
var D_levels : Array[PackedScene]

var random_generator = RandomNumberGenerator.new()

var current_level_index : int

enum LEVEL_LAYERS {
	A_LEVEL = 0, B_LEVEL = 1, C_LEVEL = 2, D_LEVEL = 3
}
var current_level_layer : LEVEL_LAYERS

var is_generating_letter_levels : bool
var letter_level_index_in_layer : int
var current_letter_level : PackedScene


func _ready() -> void:
	is_generating_letter_levels = false
	
	if GENERATE_LETTERS_FASTER:
		generate_letter_level_index_in_layer()
		new_lap()
	
	current_level_index = 0
	current_level_layer = LEVEL_LAYERS.A_LEVEL
	
	A_levels = get_all_levels(A_LEVEL_DIR)
	B_levels = get_all_levels(B_LEVEL_DIR)
	C_levels = get_all_levels(C_LEVEL_DIR)
	D_levels = get_all_levels(D_LEVEL_DIR)
	
	if not DISABLE_TUTORIAL:
		tutorial_levels = get_all_levels(TUTORIAL_DIR)
		
		for tutorial_level in tutorial_levels:
			generate_next_level(tutorial_level)
	
	for i in range(2):
		generate_next_level()
	
	GlobalSignals.next_level.connect(_on_next_level)


func _on_next_level() -> void:
	generate_next_level()
	
	if get_child_count() > (MAX_LEVELS_LOADED-1):
		get_child(0).queue_free()


func generate_next_level(custom_level: PackedScene = null) -> Level:
	var level_array : Array[PackedScene] = get_level_array_from_layer(current_level_layer)
	var next_level : PackedScene
	
	
	if custom_level:
		next_level = custom_level
	elif (
		is_generating_letter_levels and
		(current_level_index % LEVELS_IN_LAYER) == letter_level_index_in_layer
	):
		next_level = current_letter_level
	else:
		next_level = pick_level_from_level_array(level_array)
	
	var level_positopn := Vector2(0, -17*64*current_level_index)
	var added_level : Level = add_level_to_scene(next_level, level_positopn)
	
	current_level_index += 1
	
	if current_level_index % LEVELS_IN_LAYER == 0:
		generate_letter_level_index_in_layer()
		update_current_level_layer()
	
	return added_level


func add_level_to_scene(level: PackedScene, level_position: Vector2 = Vector2.ZERO) -> Level:
	var new_level : Level = level.instantiate()
	new_level.position = level_position
	
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


func update_current_level_layer() -> void:
	match current_level_layer:
		LEVEL_LAYERS.A_LEVEL:
			current_level_layer = LEVEL_LAYERS.B_LEVEL
		LEVEL_LAYERS.B_LEVEL:
			current_level_layer = LEVEL_LAYERS.C_LEVEL
		LEVEL_LAYERS.C_LEVEL:
			current_level_layer = LEVEL_LAYERS.D_LEVEL
		LEVEL_LAYERS.D_LEVEL:
			current_level_layer = LEVEL_LAYERS.A_LEVEL
			new_lap()


func get_all_levels(directory_path: String) -> Array[PackedScene]:
	var output : Array[PackedScene]
	
	var dir = DirAccess.open(directory_path)
	if dir:
		for file_name in dir.get_files():
			if file_name.get_extension() == "tscn":
				var full_path = directory_path.path_join(file_name)
				output.append(load(full_path))
	
	return output


func new_lap() -> void:
	is_generating_letter_levels = true
	GlobalSignals.new_lap_started.emit()


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
	print(current_level_layer)


func generate_final_level() -> void:
	generate_next_level(FINAL_LEVEL)
