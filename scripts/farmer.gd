extends CharacterBody2D

@export var SPEED = 300

@onready var task_behavior = $TaskBehavior

@onready var farm_marker: Marker2D = %Town3/%FarmMarker
@onready var home_marker: Marker2D = %Town3/%HomeMarker

enum State {GOING_HOME, GOING_TO_FARM, RESTING, FARMING}
var state = State.GOING_HOME

func _physics_process(delta: float) -> void:
	if state in [State.GOING_HOME, State.GOING_TO_FARM]:
		if task_behavior.is_at_location():
			transition_state()
			task_behavior.do_task()
		else:
			velocity = task_behavior.get_task_direction(global_position) * SPEED
			move_and_slide()

func transition_state() -> void:
	print(state)
	match state:
		State.GOING_HOME:
			set_state(State.RESTING)
		State.RESTING:
			set_state(State.GOING_TO_FARM)
		State.GOING_TO_FARM:
			set_state(State.FARMING)
		State.FARMING:
			set_state(State.GOING_HOME)

func set_state(new_state: State):
	match state:
		State.GOING_TO_FARM:
			task_behavior.set_task_location(farm_marker.global_position)
		State.GOING_HOME:
			task_behavior.set_task_location(home_marker.global_position)
	state = new_state


func _on_task_behavior_task_done() -> void:
	transition_state()
