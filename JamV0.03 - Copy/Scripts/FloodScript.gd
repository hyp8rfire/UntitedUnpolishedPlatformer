extends Area2D

@export var player: CharacterBody2D
@export var Zenmode : bool
@export var ScoreLog : Node
@onready var anims = $AnimatedSprite2D
var riseSpeed = 5

# Called when the node enters the scene tree for the first time.

func _physics_process(delta: float) -> void:
	if Zenmode:
		riseSpeed = 0
		if Input.is_action_just_pressed("Leave"):
			get_tree().change_scene_to_file("res://MainMenu.tscn")
	position.y -= riseSpeed * delta
	anims.play("Flood")
	if player.Score > 1000:
		riseSpeed = player.Score*0.3 + 25
	else:
		riseSpeed = player.Score*0.3
	if (-player.position.y - -position.y) < 400:
		riseSpeed *= 0.5
		if riseSpeed > 600:
			riseSpeed = 600
	if riseSpeed <= 0:
		riseSpeed = 1


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if !Zenmode:
			if ScoreLog.NAME == "":
				ScoreLog.NAME = "Unnamed Climber"
			ScoreLog.check_and_add_score(ScoreLog.NAME, player.Score)
			print(ScoreLog.high_scores)
		get_tree().change_scene_to_file("res://MainMenu.tscn")
	pass # Replace with function body.
