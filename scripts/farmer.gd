extends CharacterBody2D

@export var SPEED = 300

@onready var task_behavior = $TaskBehavior
@onready var sprite_2d  = $Sprite2D

@onready var mining_marker: Marker2D = get_parent().get_node("%Town3/%MiningMarker")
@onready var water_marker: Marker2D = get_parent().get_node("%Town3/%WaterMarker")
@onready var woods_marker: Marker2D = get_parent().get_node("%Town3/%WoodsMarker")
@onready var farm_marker: Marker2D = get_parent().get_node("%Town3/%FarmMarker")
@onready var home_marker: Marker2D = get_parent().get_node("%Town3/%HomeMarker")

enum State {GOING_HOME, GOING_TO_WORK, RESTING, WORKING}
var state = State.GOING_HOME
var work_location : Vector2

func _physics_process(delta: float) -> void:
	if state in [State.GOING_HOME, State.GOING_TO_WORK]:
		if task_behavior.is_at_location():
			transition_state()
			task_behavior.do_task()
		else:
			velocity = task_behavior.get_task_direction(global_position) * SPEED
			move_and_slide()

func transition_state() -> void:
	match state:
		State.GOING_HOME:
			set_state(State.RESTING)
		State.RESTING:
			set_state(State.GOING_TO_WORK)
		State.GOING_TO_WORK:
			set_state(State.WORKING)
		State.WORKING:
			set_state(State.GOING_HOME)

func set_state(new_state: State):
	match state:
		State.GOING_TO_WORK:
			task_behavior.set_task_location(work_location)
		State.GOING_HOME:
			task_behavior.set_task_location(home_marker.global_position)
	state = new_state

func set_job(new_job: FriendlyCreature.Job):
	match new_job:
		FriendlyCreature.Job.FARMING:
			work_location = farm_marker.global_position
		FriendlyCreature.Job.MINING:
			work_location = mining_marker.global_position
		FriendlyCreature.Job.WATER:
			work_location = water_marker.global_position
		FriendlyCreature.Job.WOODCUTTING:
			work_location = woods_marker.global_position
		var unknown_job:
			print("unbound job: " + FriendlyCreature.Job.keys()[unknown_job])

func set_appearance(texture : CompressedTexture2D):
	sprite_2d.texture = texture

func _on_task_behavior_task_done() -> void:
	transition_state()
