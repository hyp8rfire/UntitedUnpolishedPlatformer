extends RichTextLabel

@export var playerscript : CharacterBody2D
@onready var Depths = $GameJamSong
@onready var Storm = $JamHeavyTrack
@onready var SkyLimit = $JamElectronic
@onready var Godszone = $EpicJam
@export var Godmode : bool

var Quotenumber = 0
var quoteappeartime = 0.0
var fade_tween : Tween

func _process(delta: float) -> void:
	
	if Godmode and Quotenumber < 5:
		GlobalScript.NAME = GlobalScript.HighestName
		showquote("[font_size=16][i][b]To achieve the impossible, thats what you do well, " + GlobalScript.NAME + " [/b][/i]\n[font_size=64][i][b]Achieve Godhood[/b][/i]")
		FadeSong(SkyLimit, Godszone)
		Quotenumber = 5
	if playerscript.Score > 3000 and Quotenumber < 4:
		Quotenumber = 4
		showquote("[font_size=16][i][b] So, we will tear through the world they want.[/b][/i]\n[font_size=64][i][b]World For The Gods[/b][/i]")
		FadeSong(SkyLimit, Godszone)
		
	elif playerscript.Score > 2000 and Quotenumber < 3:
		Quotenumber = 3
		showquote("[font_size=16][i][b] However, we do not have a defintion for the term 'Limit'.[/b][/i]\n[font_size=64][i][b]The Skylimit[/b][/i]")
		FadeSong(Storm, SkyLimit)
		
	elif playerscript.Score > 1000 and Quotenumber < 2:
		Quotenumber = 2
		showquote("[font_size=16][i][b] We cannot understand them, nor will they understand us.[/b][/i]\n[font_size=64][i][b]The Stormzone[/b][/i]")
		FadeSong(Depths, Storm)
		
	elif playerscript.Score > 1 and Quotenumber < 1:
		Quotenumber = 1
		showquote("[font_size=16][i][b] This is what they left us with.[/b][/i]\n[font_size=64][i][b]Ruins Of The Depths[/b][/i]")
		Depths.playing = true

	if quoteappeartime > 0:
		quoteappeartime -= delta
	else:
		self_modulate.a = max(0.0, self_modulate.a - (delta * 2))

func showquote(new_text: String) -> void:
	text = new_text
	self_modulate.a = 0.5
	quoteappeartime = 2.0

func FadeSong(fading_out: AudioStreamPlayer, fading_in: AudioStreamPlayer, transition: AudioStreamPlayer = null) -> void:
	if fade_tween and fade_tween.is_running():
		fade_tween.kill()

	fade_tween = create_tween().set_parallel(true)
	

	fade_tween.tween_property(fading_out, "volume_db", -40.0, 0.5)
	

	var target_song = transition if transition != null else fading_in
	target_song.volume_db = -40.0
	target_song.playing = true
	fade_tween.tween_property(target_song, "volume_db", -11.0, 0.5)
	

	fade_tween.chain().tween_callback(func(): fading_out.playing = false)
