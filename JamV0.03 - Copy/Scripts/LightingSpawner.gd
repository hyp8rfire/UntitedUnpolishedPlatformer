extends Node2D

var lightingspawn = 2
var lightingspawntime = 3
var instance
@export var Lighting : PackedScene
@export var Player : CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Player.Score > 1500:lightingspawntime = 2
	if Player.Score > 2000:lightingspawntime = 1
	if Player.Score > 3000:lightingspawntime = .5
	if Player.Score > 1000:
		if lightingspawn > 0:
			lightingspawn -= delta
		else:
			instance = Lighting.instantiate()
			instance.global_position = global_position
			get_tree().current_scene.add_child(instance)
			var chosen_x = randf_range(Player.global_position.x - 500,Player.global_position.x + 500)
			instance.position = Vector2(chosen_x, Player.global_position.y)
			lightingspawn = lightingspawntime
	pass
