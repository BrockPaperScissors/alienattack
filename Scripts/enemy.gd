extends Area2D

@export var enemy_speed = 200

func _physics_process(delta):
	global_position.x += -enemy_speed * delta


	

