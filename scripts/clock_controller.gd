extends Control

@onready var gameTime:RichTextLabel = %gameTime
@onready var gameDay:RichTextLabel = %gameDay
@onready var sunSprite:Sprite2D = %sunSprite
@onready var moonSprite:Sprite2D = %moonSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gameTime.text = '0:00'
	gameDay.text = 'Day 0'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_canvas_modulate_time_tick(day: int, hour: int, minute: int) -> void:
	var d = str(day)
	var hr = str(hour)
	var min = str(minute)
	gameTime.text = hr + ':' + min
	gameDay.text = 'Day ' + d


func _on_canvas_modulate_is_day(is_day: bool) -> void:
	if is_day == true:
		moonSprite.hide()
		sunSprite.show()
	else:
		sunSprite.hide()
		moonSprite.show()
