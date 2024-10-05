extends CharacterBody2D

@export var SPEED = 300.0
@export var REST_TIME = 1
@export var FARM_TIME = 1
const JUMP_VELOCITY = -400.0

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

enum State {GOING_HOME, GOING_TO_FARM, RESTING, FARMING}

var state = State.RESTING

func _ready():
	# Make sure to not await during _ready.
	actor_setup.call_deferred()

func _physics_process(delta: float) -> void:
	if state in [State.RESTING, State.FARMING]:
		return

	if navigation_agent.is_navigation_finished():
		if state == State.GOING_HOME:
			print("Starting to rest")
			get_tree().create_timer(REST_TIME).timeout.connect(finish_resting)
			state = State.RESTING
		if state == State.GOING_TO_FARM:
			print("Starting Farming")
			get_tree().create_timer(FARM_TIME).timeout.connect(finish_farming)
			state = State.FARMING
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * SPEED

	move_and_slide()

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	state = State.GOING_HOME
	set_movement_target(get_movement_target_for_task())

func get_movement_target_for_task() -> Vector2:
	match state:
		State.GOING_HOME:
			return %Home.global_position
		State.GOING_TO_FARM:
			return %Farm.global_position
		var unmapped_location:
			print("can't find unmapped location " + State.keys()[unmapped_location] + "going home instead")
			return %Home.global_position

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func finish_farming():
	state = State.GOING_HOME
	set_movement_target(get_movement_target_for_task())

func finish_resting():
	state = State.GOING_TO_FARM
	set_movement_target(get_movement_target_for_task())
