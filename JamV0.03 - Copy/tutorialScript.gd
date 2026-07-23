extends Control

@onready var Walk = $Walk
@onready var jump = $Jump
@onready var Wall = $Wallgrab
@onready var Dashcharge = $DashCharge
@onready var dashrel = $DashReleasse
@onready var dashChain = $DashChaining

@onready var MenuArray = [Walk, jump, Wall, Dashcharge, dashrel, dashChain]
var Pagenum = 0

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu.tscn")
	pass # Replace with function body.
	
func HideScreens():
	MenuArray[0].visible = false
	MenuArray[1].visible = false
	MenuArray[2].visible = false
	MenuArray[3].visible = false
	MenuArray[4].visible = false
	MenuArray[5].visible = false


func OnNext() -> void:
	if Pagenum != 5:
		HideScreens()
		Pagenum += 1
		MenuArray[Pagenum].visible = true
		pass # Replace with function body.


func _onPrevious() -> void:
	if Pagenum != 0:
		HideScreens()
		Pagenum -= 1
		MenuArray[Pagenum].visible = true
	pass # Replace with function body.
