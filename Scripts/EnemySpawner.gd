extends Node2D

@onready var timer = $Timer
@onready var enemy_container = $EnemyContainer
@onready var spawn_positions = $SpawnPositions

var enemy_scene = preload("res://Scenes/enemy.tscn")

func _ready():
	timer.connect("timeout", _on_timeout)
	
func _on_timeout():
	SpawnEnemy()

func SpawnEnemy():
	var spawn_positions_array = spawn_positions.get_children()
	var random_spawn_position = spawn_positions_array.pick_random()
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_container.add_child(enemy_instance)
	enemy_instance.global_position = random_spawn_position.global_position
	
	
