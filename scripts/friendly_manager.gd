extends Node

@export var creatures : Array[FriendlyCreature]
@export var base_unit_selection_period_secs = 3
@onready var picker = %Picker

var farmer = preload("res://scenes/farmer.tscn")

var is_currently_selecting = false
var unselected_creatures = []
var selections_queued = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	picker.propagate_call("set_visible", [false])
	unselected_creatures = creatures

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selections_queued && not is_currently_selecting:
		offer_creature_selection()
		get_tree().create_timer(base_unit_selection_period_secs).timeout.connect(add_selection_to_queue)

func add_selection_to_queue():
	selections_queued += 1

func offer_creature_selection() -> void:
	print(unselected_creatures.size())
	unselected_creatures.shuffle()
	picker.set_creatures(unselected_creatures.slice(0,3))
	open_selection_menu()
	selections_queued -= 1
	print("choose your guy")

func handle_selection(creature: FriendlyCreature) -> void:
	close_selection_menu()
	is_currently_selecting = false
	spawn_creature(creature)

func spawn_creature(creature: FriendlyCreature) -> void:
	print("making a lil guy named " + creature.creature_name)
	var guy = farmer.instantiate()
	guy.position = %Town3/%HomeMarker.global_position
	add_sibling(guy)
	guy.set_appearance(creature.picker_thumbnail)
	guy.set_job(creature.assigned_job)

func open_selection_menu() -> void:
	picker.propagate_call("set_visible", [true])
	is_currently_selecting = true
	
func close_selection_menu() -> void:
	picker.propagate_call("set_visible", [false])
	is_currently_selecting = false
