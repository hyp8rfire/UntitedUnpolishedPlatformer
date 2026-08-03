extends Control

@onready var Depths = $Depths
@onready var Coulds = $Couldzone
@onready var Skylimit = $Skylimit
@onready var Godszone = $Godzone
@onready var Godszonetext = Godszone.get_node("RichTextLabel")
@onready var depthstext = Depths.get_node("RichTextLabel")
@onready var skytext = Skylimit.get_node("RichTextLabel")
@onready var stormtext = Coulds.get_node("RichTextLabel")
@onready var GodButton = $Button
var pagenum = 0

@onready var MenuArray = [Depths, Coulds, Skylimit, Godszone]
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalScript.HighestScore < 3000:
		CensorText(Godszone, "3000", "3500")
	if GlobalScript.HighestScore < 2000:
		CensorText(Skylimit, "2000", "2500")
	if GlobalScript.HighestScore < 1000:
		CensorText(Coulds, "1000", "1500")
		
			
	if GlobalScript.HighestScore > 3500:
			Godszonetext.size.y = 600
			if pagenum == 3:
				GodButton.visible = true
			else:
				GodButton.visible = false
	if GlobalScript.HighestScore > 2500:
			skytext.size.y = 600
	if GlobalScript.HighestScore > 1500:
			stormtext.size.y = 600
			
	MenuArray[pagenum].visible = true
	

	if Godszonetext.text == "":
		Godszonetext.text = "[b][font_size= 32]World For The Gods[/font_size][/b]
Unlocked At 3000m
Info Unlocked At 3500m

[i]\"So, we will tear through the world they want.\"[/i]

That silent answer solved all our questions. They were our limiters. They thought we deserved to suffer. They thought you, and me, were less. However You, dear climber, will prove them wrong.

Show them who they should [b]fear[/b],
Show them who they should [b]worship[/b],
Show them what [b]pain[/b] is, show them what [b]sorrow[/b] is, show them what [b]agony[/b] is.

[b]So, Dearest [i] " + GlobalScript.HighestName +"[/i], tear through the world they want."
		
	pass

func CensorText(hidden : Control, scoreneeded : String, ScoreNeeded2 : String):
	var texthide = hidden.get_node("RichTextLabel") 
	texthide.text = "[b][font_size= 32]???[/font_size][/b]
Unlocked At "+ scoreneeded +"m
Info Unlocked At "+ ScoreNeeded2 +"m

[i]'???'[i]

I believe you can go further than that, Climber."

	
func Hidescreens():
	Depths.visible = false
	Coulds.visible = false
	Skylimit.visible = false
	Godszone.visible = false
	


func _on_button_2_pressed() -> void:
	if pagenum != 3:
		pagenum += 1
		Hidescreens()

	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu.tscn")
	pass # Replace with function body.


func _on_button_4_pressed() -> void:
	if pagenum != 0:
		pagenum -= 1

		Hidescreens()

	pass # Replace with function body.


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Godmode.tscn")
	pass # Replace with function body.
