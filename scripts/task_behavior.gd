extends Node2D

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

signal task_done

func _process(delta: float) -> void:
	pass

func set_task_location(new_task_location: Vector2):
	navigation_agent.target_position = new_task_location

func is_at_location() -> bool:
	return navigation_agent.is_navigation_finished()

func get_task_direction(current_location: Vector2):
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	return current_location.direction_to(next_path_position)

func do_task():
	task_done.emit()
