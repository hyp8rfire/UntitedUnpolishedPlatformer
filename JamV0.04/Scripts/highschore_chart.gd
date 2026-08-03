extends RichTextLabel

func _ready() -> void:
	render_leaderboard()

func render_leaderboard():
	clear()
	
	# Centered green title header
	append_text("[i][center][font_size=24]Highscores[/font_size][/center][i]\n")
	append_text("[font_size=12]Name will deafult to Highest name on the leaderboard or Unnamed Climber[/font_size]\n\n")
	
	# Iterate over the singleton's high score data array
	var rank = 1
	for entry in GlobalScript.high_scores:
		var line_text = ""
		
		# Give the #1 champion a distinct gold color highlight
		if rank == 1:
			line_text = "[color=gold]%d. %s [/color] [right][color=gold]%d[/color][/right]\n" % [rank, entry["name"], entry["score"]]
		else:
			line_text = "%d. %s [right]%d[/right]\n" % [rank, entry["name"], entry["score"]]
			
		append_text(line_text)
		rank += 1
