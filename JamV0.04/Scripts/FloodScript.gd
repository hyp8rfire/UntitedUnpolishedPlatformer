extends Area2D

@export var player: CharacterBody2D
@export var Zenmode : bool
@export var Godmode : bool
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
		if Godmode:
			riseSpeed *= 0.8
		else:
			riseSpeed *= 0.5
		player.closecallbonus = true
		if riseSpeed > 600 and !Godmode:
			riseSpeed = 600
	else: 
		player.closecallbonus = false
	if riseSpeed <= 0:
		riseSpeed = 1
	if Godmode == true:
		riseSpeed += 300
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if !Zenmode:
			if GlobalScript.NAME == "":
				print("NO NAME")
				if GlobalScript.HighestName != "":
					GlobalScript.NAME = GlobalScript.HighestName
					print("USING HIGHEST NAME")
				else:
					GlobalScript.NAME = "Unnamed Climber"
					print("NO LONGER")
			GlobalScript.check_and_add_score(GlobalScript.NAME, player.Score)
			print(GlobalScript.high_scores)
			GlobalScript.newscore = true
		get_tree().change_scene_to_file("res://MainMenu.tscn")
	pass # Replace with function body.
