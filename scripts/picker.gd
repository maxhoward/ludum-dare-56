extends Control

signal creature_selected(selectedCreature: FriendlyCreature)

var creatures: Array[FriendlyCreature] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_creatures(new_creatures: Array[FriendlyCreature]):
	creatures = new_creatures
	%Creature1Name.text = creatures[0].creature_name
	%Creature2Name.text = creatures[1].creature_name
	%Creature3Name.text = creatures[2].creature_name

func _on_creature_1_job_a_button_down() -> void:
	creatures[0].assign_first_job()
	print("creature selected!")
	creature_selected.emit(creatures[0])
	pass


func _on_creature_1_job_b_button_down() -> void:
	creatures[0].assign_second_job()
	print("creature selected!")
	creature_selected.emit(creatures[0])

func _on_creature_2_job_a_button_down() -> void:
	creatures[1].assign_first_job()
	print("creature selected!")
	creature_selected.emit(creatures[1])

func _on_creature_2_job_b_button_down() -> void:
	creatures[1].assign_second_job()
	print("creature selected!")
	creature_selected.emit(creatures[1])

func _on_creature_3_job_a_button_down() -> void:
	creatures[2].assign_first_job()
	print("creature selected!")
	creature_selected.emit(creatures[2])

func _on_creature_3_job_b_button_down() -> void:
	creatures[2].assign_second_job()
	print("creature selected!")
	creature_selected.emit(creatures[2])
