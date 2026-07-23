extends Button
@export var Username : TextEdit

# Called when the node enters the scene tree for the first time.


func _on_pressed() -> void:
	Username.text = GlobalScript.NAME
	get_tree().change_scene_to_file("res://GamejamGAME.tscn")
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Tutorial.tscn")
	pass # Replace with function body.


func _on_button3_pressed() -> void:
	get_tree().change_scene_to_file("res://ZenMode.tscn")
	pass # Replace with function body.
