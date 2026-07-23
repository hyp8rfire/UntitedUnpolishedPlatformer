extends Node

#Get Player Transform
@export var player: Node2D

#Get the different type of platforms
@export var platform_scenes: Array[PackedScene] = []

# Get Zone Platforms Can spawn In
@export var platformZone: Node2D
var maxY
var minY 
var maxX = 1000
var minX = -1000



var MaxSpawns = 10000 


var highest_spawn_y: float = 0.0
var last_platform_position: Vector2 = Vector2.ZERO

#PLAN:
#As player accends, generate platforms leading upwards
#Platforms have limits to where they can generate in.
@export var min_vertical_gap: float = 100.0
@export var max_vertical_gap: float = 200.0
@export var min_horizontal_gap: float = 100.0
#Ensure Platforms Cannot generate too close to eachother.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if MaxSpawns != 0:
		spawn_platform()
		MaxSpawns -= 1
	pass
	
func spawn_platform() -> void:

	# Pick a platform type at random
	var random_index = randi() % platform_scenes.size()
	var selected_scene = platform_scenes[random_index]
	
	var platform_instance = selected_scene.instantiate() as Node2D
	
	# 1. Calculate Y position (moving upwards)
	var vertical_step = randf_range(min_vertical_gap, max_vertical_gap)
	highest_spawn_y -= vertical_step
	
	# 2. Calculate X position within zone limits and away from the last platform
	var spawn_x = get_valid_x_position()
	
	# Set position & add to the world
	var spawn_position = Vector2(spawn_x, highest_spawn_y)
	platform_instance.global_position = spawn_position
	add_child(platform_instance)
	
	# Update tracking
	last_platform_position = spawn_position
func get_valid_x_position() -> float:
	var chosen_x: float = 0.0
	var max_attempts: int = 10
	
	for attempt in max_attempts:
		chosen_x = randf_range(minX, maxX)
		
		# Ensure platform isn't directly above/too close horizontally to the previous platform
		if abs(chosen_x - last_platform_position.x) >= min_horizontal_gap:
			return chosen_x
			
	return chosen_x
