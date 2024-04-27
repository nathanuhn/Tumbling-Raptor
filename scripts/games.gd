extends Node2D

@export var world_speed = 1

@export var moving_environment: Node2D

@export var collectible_pitch_reset_interval = 2000

@onready var collect_sound = $Sounds/CollectSound


var platform = preload("res://scenes/platform.tscn")

var rng = RandomNumberGenerator.new()
var last_platform_position = Vector2.ZERO
var next_spawn_time = 0
var score = 0
var collectible_pitch = 1.0
var reset_collectible_pitch_time = 0

func _ready():
	rng.randomize()
	
func _process(delta):
	if Time.get_ticks_msec() > reset_collectible_pitch_time:
		collectible_pitch = 1.0
	if Time.get_ticks_msec() > next_spawn_time:
		_spawn_next_platform()

func _spawn_next_platform():
	var new_platform = platform.instantiate()
		
	if last_platform_position == Vector2.ZERO:
		
		
		new_platform.position = Vector2(400,0)
	else:
		var x = last_platform_position.x + rng.randi_range(450, 550)
		var y = last_platform_position.y + rng.randi_range(-150,150)
		new_platform.position = Vector2(x, y)
		
	moving_environment.add_child(new_platform)
	last_platform_position = new_platform.position
	
	next_spawn_time += world_speed
		
func _physics_process(delta):
	
	
	moving_environment.position.x -= world_speed * delta
	

func add_score(value):
	score += value
	collect_sound.set_pitch_scale(collectible_pitch)
	collect_sound.play()
	collectible_pitch += 0.1  
	reset_collectible_pitch_time = Time.get_ticks_msec() + collectible_pitch_reset_interval
	print(score)
