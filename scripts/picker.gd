extends Control

signal creature_selected()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func creature_1_job_1_clicked() -> void:
	print("creature selected!")
	creature_selected.emit()
	pass
