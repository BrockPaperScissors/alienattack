extends Node2D

var lives = 3
var score = 0

@onready var player = $Player
@onready var enemy_container = $EnemySpawner/EnemyContainer
@onready var hud = $UI/HUD
@onready var ui = $UI
@onready var enemy_hit_sound = $EnemyHitSound
@onready var explode_sound = $ExplodeSound
@onready var death_animation = $EnemyDeath

var game_over_screen = preload("res://Scenes/game_over_screen.tscn")


func _ready():
	hud.set_score_label(score)
	hud.set_lives_label(lives)

func _on_deathzone_area_entered(area):
	area.queue_free()

func _on_player_took_damage():
	explode_sound.play()
	lives -= 1
	hud.set_lives_label(lives)
	
	if lives == 0:
		player.die()
		
		await get_tree().create_timer(1.5).timeout
		
		var game_over_menu = game_over_screen.instantiate()
		game_over_menu.set_score(score)
		ui.add_child(game_over_menu)
	else: 
		print(str(lives) + " lives left")


func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("enemy_died", on_enemy_died)
	enemy_container.add_child(enemy_instance)
	
func on_enemy_died(death_position):
	print(death_position)
	death_animation.global_position = death_position
	death_animation.emitting = true
	score += 100
	enemy_hit_sound.play()
	hud.set_score_label(score)


func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance):
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("enemy_died", on_enemy_died)
