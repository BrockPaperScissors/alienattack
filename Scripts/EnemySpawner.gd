extends Node2D

@onready var timer = $Timer

func _ready():
	timer.connect("timeout", _on_timeout)
	
func _on_timeout():
	print("times up")
