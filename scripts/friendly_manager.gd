extends Node

@export var creatures : Array[FriendlyCreature]
@export var base_unit_selection_period_secs = 5
@onready var picker = %Picker

var is_currently_selecting = false
var unselected_creatures = []
var selections_queued = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	picker.propagate_call("set_visible", [false])
	unselected_creatures = creatures

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selections_queued && not is_currently_selecting:
		offer_creature_selection()

func offer_creature_selection() -> void:
	print(unselected_creatures.size())
	unselected_creatures.shuffle()
	picker.set_creatures(unselected_creatures.slice(0,3))
	open_selection_menu()
	selections_queued -= 1
	print("choose your guy")

func handle_selection(creature: FriendlyCreature) -> void:
	close_selection_menu()
	spawn_creature(creature)

func spawn_creature(creature: FriendlyCreature) -> void:
	print("making a lil guy named " + creature.creature_name)
	is_currently_selecting = false

func open_selection_menu() -> void:
	picker.propagate_call("set_visible", [true])
	is_currently_selecting = true
	
func close_selection_menu() -> void:
	picker.propagate_call("set_visible", [false])
	is_currently_selecting = false
