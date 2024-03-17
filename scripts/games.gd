extends Node2D

@export var world_speed = 1

@export var moving_environment: Node2D

func _physics_process(delta):
	
	moving_environment.position.x -= world_speed * delta
