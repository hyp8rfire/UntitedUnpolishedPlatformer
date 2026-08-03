extends Camera2D

@export var playerscript : CharacterBody2D
var goalzoom = 1.2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	zoom.y = zoom.x
	if playerscript.chargeddashcombo > 0 and goalzoom > .7:
		goalzoom = 1.2 - (playerscript.chargeddashcombo * 0.02)
		
	elif playerscript.chargeddashcombo == 0:
		if goalzoom < 1.2:
			goalzoom = 1.2
			
	if zoom.x > goalzoom: zoom.x -= delta * 0.1 #zoom is smaller
	elif zoom.x < goalzoom: zoom.x += delta* 0.1
	pass
