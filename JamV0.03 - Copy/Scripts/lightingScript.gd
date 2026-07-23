extends Area2D

@onready var Anim = $AnimatedSprite2D
@onready var sound = $AudioStreamPlayer2D
var StrikeTime = 1.5
var StrikeDuration = .2
var animationduration = .2



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if StrikeTime > 0:
		StrikeTime -= delta
		Anim.play("Charge", .3)
	elif StrikeDuration > 0:
		StrikeDuration -= delta
		sound.playing = true
		Anim.play("Strike", 3)
	elif animationduration > 0:
		animationduration -= delta
	else:
		await get_tree().create_timer(2).timeout
		queue_free()
		
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and StrikeDuration > 0 and StrikeDuration != .2:
		body.SPEED = 50
		body.Dashes = 2
		body.Jumps = 2
		body.Dashfall = true
		body.AnimationBusy = -.1
	pass # Replace with function body.
