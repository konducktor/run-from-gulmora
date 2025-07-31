extends Node2D
class_name LevelGenerator


@export var A_LEVEL_DIR : String
@export var B_LEVEL_DIR : String
@export var C_LEVEL_DIR : String
@export var D_LEVEL_DIR : String


var A_levels : Array[PackedScene]
var B_levels : Array[PackedScene]
var C_levels : Array[PackedScene]
var D_levels : Array[PackedScene]

var random_generator = RandomNumberGenerator.new()

var current_level_index : int

enum LEVEL_TYPES {A_LEVEL, B_LEVEL, C_LEVEL, D_LEVEL}
var current_level_type : LEVEL_TYPES


func _ready() -> void:
	current_level_index = 0
	current_level_type = LEVEL_TYPES.A_LEVEL
	
	A_levels = get_all_levels(A_LEVEL_DIR)
	B_levels = get_all_levels(B_LEVEL_DIR)
	C_levels = get_all_levels(C_LEVEL_DIR)
	D_levels = get_all_levels(D_LEVEL_DIR)
	
	for i in range(2):
		generate_next_level()
	
	GlobalSignals.next_level.connect(_on_next_level)


func _on_next_level():
	generate_next_level()
	
	if get_child_count() > 5:
		get_child(0).queue_free()


func generate_next_level() -> void:
	var level_array : Array[PackedScene] = get_level_array_from_type(current_level_type)
	var next_level : PackedScene = pick_level_from_level_array(level_array)
	
	var level_positopn := Vector2(0, -17*64*current_level_index)
	add_level_to_scene(next_level, level_positopn)
	
	current_level_index += 1
	update_current_level_type()


func add_level_to_scene(level: PackedScene, level_position: Vector2 = Vector2.ZERO) -> void:
	var new_level : Level = level.instantiate()
	new_level.position = level_position
	
	call_deferred('add_child', new_level)


func get_level_array_from_type(type: LEVEL_TYPES) -> Array[PackedScene]:
	match type:
		0:
			return A_levels
		1:
			return B_levels
		2:
			return C_levels
		3:
			return D_levels
		_:
			return []


func pick_level_from_level_array(level_array: Array[PackedScene]) -> PackedScene:
	var level_id := random_generator.randi_range(0, len(level_array)-1)
	return level_array[level_id]


func update_current_level_type():
	match current_level_type:
		0:
			current_level_type = LEVEL_TYPES.B_LEVEL
		1:
			current_level_type = LEVEL_TYPES.C_LEVEL
		2:
			current_level_type = LEVEL_TYPES.D_LEVEL
		3:
			current_level_type = LEVEL_TYPES.A_LEVEL


func get_all_levels(directory_path: String) -> Array[PackedScene]:
	var output : Array[PackedScene]

	var dir = DirAccess.open(directory_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				if file_name.get_extension() == "tscn":
					var full_path = directory_path.path_join(file_name)
					output.append(load(full_path))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

	return output
