extends Control

@onready var score = $Score
@onready var lives = $Lives

func set_score_label(new_score):
	score.text = "SCORE: " + str(new_score)

func set_lives_label(player_lives):
	lives.text = "LIVES: " + str(player_lives)
	
