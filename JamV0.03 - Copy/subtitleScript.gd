extends RichTextLabel

@export var playerscript : CharacterBody2D
@onready var Depths = $GameJamSong
@onready var Storm = $JamHeavyTrack
@onready var SkyLimit = $JamElectronic
@onready var Godszone = $EpicJam

@onready var SkyToGods = $ElectronicToEpic




# Called when the node enters the scene tree for the first time.
var Quotenumber = 0
var quoteappeartime = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playerscript.Score > 3000 and Quotenumber != 4:
		text = "[font_size=16][i][b] So, we will tear through the world they want.
[font_size=64][i][b]Territory Of The Gods[/b][/i]"
		Quotenumber += 1
		self_modulate.a = .5
		quoteappeartime = 2
		FadeSong(SkyLimit, Godszone, null)
		
		
	elif playerscript.Score > 2000 and Quotenumber < 3:
		text = "[font_size=16][i][b] However, there are no limits to our determination.
[font_size=64][i][b]The Skylimit[/b][/i]"
		Quotenumber += 1
		self_modulate.a = .5
		quoteappeartime = 2
		FadeSong(Storm, SkyLimit, null)
		
	elif playerscript.Score > 1000 and Quotenumber < 2:
		text = "[font_size=16][i][b] We cannot understand them, nor will they understand us.
[font_size=64][i][b]The Stormzone[/b][/i]"
		Quotenumber += 1
		self_modulate.a = .5
		quoteappeartime = 2
		FadeSong(Depths, Storm, null)
		
	elif playerscript.Score > 1 and Quotenumber < 1:
		Quotenumber += 1
		self_modulate.a = .5
		quoteappeartime = 2
		Depths.playing = true
		text = "[font_size=16][i][b] This is what they left us with.
[font_size=64][i][b]Realm Of The Depths[/b][/i]"

	if quoteappeartime > 0:
		quoteappeartime -= delta
	else:
		self_modulate.a -= delta*2
	pass
	
func FadeSong(FadingOutSong : AudioStreamPlayer, FadingInSong : AudioStreamPlayer, Transition : AudioStreamPlayer):
	var Fadetime = .5
	FadingInSong.volume_db = -40
	while Fadetime > 0:
		FadingOutSong.volume_db -= .1
		Fadetime -= get_process_delta_time()
		await get_tree().create_timer(.01).timeout
	if Fadetime < 0:
		FadingOutSong.playing = false
		if Transition != null:
			Transition.playing = true
		else:
			FadingInSong.playing = true
			while FadingInSong.volume_db <= -11:
				FadingInSong.volume_db += 0.1
				await get_tree().create_timer(.01).timeout
		
		
			


func _on_electronic_to_epic_finished() -> void:
	Godszone.playing = true
	pass # Replace with function body.
