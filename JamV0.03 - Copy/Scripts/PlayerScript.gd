class_name Player
extends CharacterBody2D

enum MoveState {Normal, Dash, Wall, Dead}
var CurrentState = MoveState.Normal
#Movement
var SPEED = 250
var NORMSPEED = 250
var JUMP_VELOCITY = -450.0
var LastPressedRight = false
var chargeddashchain = 0

# Ints
var Jumps = 0
var JumpLimit = 2

var Dashes = 0
var DashesLimit = 2

#Meters & Counters
var DashChargeTime = 0

#bools
var HoldDash = false
var RightSideCollsion = false
var AnimationBusy = 0.1

var changedDashCount = false
var Dashfall = false

#Counters and score
var chaineddashcounter = 0
var Score = 0
@onready var ScoreCount = $Camera2D/RichTextLabel
@onready var Times = $Camera2D/RichTextLabel2
@onready var ScoreAVG = $Camera2D/RichTextLabel3
@onready var chargedashcount = $Camera2D/RichTextLabel4
@onready var SpeedBoost = $Camera2D/RichTextLabel5
@onready var FloodSpeed = $Camera2D/RichTextLabel6
@onready var FloodDist = $Camera2D/RichTextLabel7
@onready var ComboDashTimer = $Camera2D/RichTextLabel8
@export var Floodscript : Area2D
var timervar = 0.0
var starttime = false
var chargeddashcombo = 0.0




#Animation
@onready var AnimatedSprite = $AnimatedSprite2D

func _ready() -> void: #godot version of start lol

	pass
func _physics_process(delta: float) -> void: #Godot Version of FixedUpdate        
	var move_direction := Input.get_vector("Left", "Right", "Up", "Down")
	if move_direction != Vector2.ZERO: starttime = true
	
	if CurrentState == MoveState.Normal and not is_on_floor() and not is_on_wall() and AnimationBusy < 0  and AnimationBusy != -1:
		if Dashfall == false:
			AnimatedSprite.play("FallIdle", 2)
		else:
			AnimatedSprite.play("DashFallIdle", 2)
	
	#Returning speed back to norm speed
	if SPEED > NORMSPEED:
		SPEED -= 100*delta
		
		#General Movement
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
		if CurrentState == MoveState.Wall:
			AnimatedSprite.play("FallIdle")
		

	else:
		velocity.x = move_toward(velocity.x, 0 , SPEED * delta * 2)
		
	#flipping sprite
	if direction == -1:
		AnimatedSprite.flip_h = 1
	elif direction == 1:
		AnimatedSprite.flip_h = 0
		
		#Dashing
	if Input.is_action_pressed("Dash") and Dashes < DashesLimit and CurrentState == MoveState.Normal and not is_on_floor() or Input.is_action_pressed("Dash") and CurrentState == MoveState.Dash:
		CurrentState = MoveState.Dash
		gravityReduction(delta, 0.01)
		DashChargeTime += delta
		HoldDash = true
		velocity = velocity * 0.95
		
	elif HoldDash == true and CurrentState == MoveState.Dash:
		Dashes += 1
		AnimationBusy = .8
		Dashfall = true
		if chargeddashchain > 0 or DashChargeTime > .8:
			if chargeddashchain > 0:
				print("CHAINED")
				changedDashCount = true
				chargeddashcombo += 1
			print("CHARGED DASH", 1.5)
			SPEED = 800
			velocity = Vector2(move_direction.x, move_direction.y - 0.2).normalized() * (-JUMP_VELOCITY * 2)
			Jumps = 1
			chargeddashchain = 2
		else:
			print("REGULAR DASH")
			SPEED = 600
			velocity = Vector2(move_direction.x, move_direction.y - 0.2).normalized() * (-JUMP_VELOCITY * 1.5)
		AnimatedSprite.play("DashRelease")
		DashChargeTime = 0
		CurrentState = MoveState.Normal
		HoldDash = false

	# Gravity (Disabled when Dashing And On Wall)
	if not is_on_floor() and CurrentState == MoveState.Normal:
		velocity += get_gravity() * delta
	#Wall Holds
	if is_on_wall_only():
		gravityReduction(delta, 0.01)
		HoldDash = true
		velocity = velocity * 0.9
		Jumps = 0
		if Dashes != 0:
				Dashes = 1
		DashChargeTime = 0
		CurrentState = MoveState.Wall
		AnimatedSprite.play("Wall")
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var normal = collision.get_normal()
	
			if normal.x > 0:
				RightSideCollsion = false
				AnimatedSprite.flip_h = 0
			elif normal.x < 0:
				RightSideCollsion = true
				AnimatedSprite.flip_h = 1
		
	elif not is_on_wall_only() and CurrentState == MoveState.Wall:
		CurrentState = MoveState.Normal
		SPEED = NORMSPEED
		
	# Jumping
	if Input.is_action_just_pressed("Up") and Jumps < JumpLimit and CurrentState != MoveState.Dash:
		Dashfall = false
		if Jumps == 1:
			velocity.y = JUMP_VELOCITY * 1.2
			AnimationBusy = 1
			AnimatedSprite.play("Jump2")
		else:
			velocity.y = JUMP_VELOCITY
			AnimationBusy = -1
			AnimatedSprite.play("Jump1")
		Jumps += 1
		if chargeddashchain > 0:
				chargeddashchain += .5
		if CurrentState == MoveState.Wall:
			if RightSideCollsion == true:
				velocity.x = -400
			else:
				velocity.x = 400
				
		
		
	
		

	#Reseting Jumps When On Floor, also animations
	if is_on_floor() and not Input.is_action_just_pressed("Up"):
		if CurrentState == MoveState.Dash:
			SPEED = NORMSPEED
		Dashfall = false
		CurrentState = MoveState.Normal
		Jumps = 0
		Dashes = 0
		if SPEED == 50 and CurrentState != MoveState.Dash:
			SPEED = NORMSPEED
		AnimationBusy = .05
		velocity.x = move_toward(velocity.x, 0 , SPEED * delta * 5)
	move_and_slide() # magical apply movement function
	
	#RUN ANIMATIONS AFTER MOVE AND SLIDE! (EXCEPT JUMPS.. AND DASH.)
	if is_on_floor():
		
		if direction != 0:
			AnimatedSprite.play("Walk")
		else:
			AnimatedSprite.play("Idle")
	elif DashChargeTime > 0 and Input.is_action_pressed("Dash"):
		if chargeddashchain > 0:
			AnimatedSprite.play("InstantCharge", 2)
		else:
			AnimatedSprite.play("DashCharge")
	
		
	
func _process(delta: float) -> void: #godot version of update loop
	#Running Down Cooldowns
	var boost = (1.0+ chargeddashcombo*.05)
	if chargeddashcombo > 0:
		if boost > 1.5 and Score < 2000:
			boost = 1.5
		if boost > 2 and Score < 2000:
			boost = 2
		NORMSPEED = 200 * boost
		JUMP_VELOCITY = -450 * boost
	else:
		NORMSPEED = 200
		JUMP_VELOCITY = -450
	
	if chargeddashchain > 0:
		chargeddashchain -= delta
	else:
		chargeddashcombo = 0
	if AnimationBusy >= 0:
		AnimationBusy -= delta
	Score = (position.y * -1) * 0.05
	Score = snapped(Score, 0.1)
	var scorestring = str(Score)
	ScoreCount.text = "[font_size=32][b][i]" + scorestring
	
	var chaineddashcounterstring = str(chargeddashcombo)
	chargedashcount.text = "[font_size=16][i][b]Chain Dash Combo " + chaineddashcounterstring
	
	var Speedboosttotal = str(boost)
	SpeedBoost.text = "[font_size=16][i][b]" + Speedboosttotal +  "x Speed Boost"
	
	var floodscore = (Floodscript.position.y * -1) * 0.05
	var floodspeed = floodscore/timervar
	floodspeed = str(snapped(floodspeed, 0.1))
	floodscore = str(snapped(floodscore, 0.1))
	
	FloodSpeed.text = "[font_size=16][i][b]" + floodspeed +"m/s Flood Speed"
	FloodDist.text = "[font_size=16][i][b]Flood Height " + floodscore
	
	ComboDashTimer.text = "[font_size=14][i][b]" + str(snapped(chargeddashchain, .01))
	

	
	if starttime == true:
		timervar += delta
		var timessnapped = snapped(timervar, 0.01)
		timessnapped = str(timessnapped)
		Times.text =  "[font_size=16][b][i]" + timessnapped
		
		var scoreaverage = Score/timervar
		scoreaverage = snapped(scoreaverage, 0.01)
		scoreaverage = str(scoreaverage)
		ScoreAVG.text = "[font_size=16][b][i]" + scoreaverage + "m/s"
		
		
		
	pass

func gravityReduction(delta: float, SlowVal: float) -> void: #Remember to change CurrentState off normal to prevent  reverting back to normal gravity.
	velocity += get_gravity() * SlowVal * delta
	SPEED = 50
	

	
	
	
