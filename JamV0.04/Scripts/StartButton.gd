extends Button
@export var Username : TextEdit

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	
	if GlobalScript.STOREDNAME != "":
		Username.text = GlobalScript.STOREDNAME
	else:
		Username.text = GlobalScript.HighestName
func _on_pressed() -> void:
	if Username.text != "":
		print(Username.text)
		GlobalScript.NAME = Username.text
		GlobalScript.STOREDNAME = Username.text
	
		
	get_tree().change_scene_to_file("res://GamejamGAME.tscn")
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Tutorial.tscn")
	pass # Replace with function body.


func _on_button3_pressed() -> void:
	get_tree().change_scene_to_file("res://ZenMode.tscn")
	pass # Replace with function body.


func _on_button_4_pressed() -> void:
	GlobalScript.load_scores()
	get_tree().change_scene_to_file("res://LoreFile.tscn")
	pass # Replace with function body.
