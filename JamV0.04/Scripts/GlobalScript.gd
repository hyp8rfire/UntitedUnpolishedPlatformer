extends Node

const SAVE_PATH = "user://highscores.save"
const MAX_SCORES = 5
var NAME = ""
var HighestScore = 0.0
var HighestName = ""
var lastscore 
var newscore = false

# Default chart data
var high_scores: Array = [
	{"name": "Placeholder", "score": 5},
	{"name": "Placeholder", "score": 4},
	{"name": "Placeholder", "score": 3},
	{"name": "Placeholder", "score": 2},
	{"name": "Placeholder", "score": 1}
]

func _ready() -> void:
	load_scores()

# Call this whenever a player finishes a game
func check_and_add_score(new_name: String, new_score: int) -> bool:
	# Add the new score entry
	lastscore = new_score
	high_scores.append({"name": new_name, "score": new_score})
	
	# Sort descending based on the "score" key
	high_scores.sort_custom(func(a, b): return a["score"] > b["score"])
	
	# Trim list to only keep the top positions
	if high_scores.size() > MAX_SCORES:
		high_scores.resize(MAX_SCORES)
	
	if HighestScore < new_score:
		HighestScore = new_score
		
	save_scores()
	
	# Returns true if the new score successfully made it onto the leaderboard
	for entry in high_scores:
		if entry["name"] == new_name and entry["score"] == new_score:
			return true
	return false

func save_scores():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(high_scores)
		file.close()

func load_scores():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			var data = file.get_var()
			if data is Array:
				high_scores = data
				
				if high_scores.size() > 0:
					HighestScore = high_scores[0]["score"]
					HighestName = high_scores[0]["name"]
					print("WAITTTTTTTTTTTTTTTTTTTTT " + str(HighestScore))
					print("WAITTTTTTTTTTTTTTTTTTTTT " + HighestName)
			file.close()
