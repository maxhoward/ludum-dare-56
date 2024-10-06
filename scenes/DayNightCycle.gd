extends CanvasModulate

var time:float = 0.0
var past_minute:float = -1.0
var isday = true

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2*PI)/MINUTES_PER_DAY

signal time_tick(day:int, hour:int, minute:int)
signal is_day(is_day:bool)

@export var gradient:GradientTexture1D
@export var INGAME_SPEED = 48
@export var INITIAL_HOUR = 6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta * INGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED
	
	var value = (sin(time - PI/2.0) + 1.0)/2.0
	self.color = gradient.gradient.sample(value)
	
	_recalculate_time()

func _recalculate_time() -> void:
	var total_minutes = int(time/INGAME_TO_REAL_MINUTE_DURATION)
	var day = int(total_minutes/MINUTES_PER_DAY)
	
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	var hour = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute = current_day_minutes % MINUTES_PER_HOUR
	
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day,hour,minute)
	
	if hour >= 6 && hour <= 18:
		isday = true
	else:
		isday = false
	is_day.emit(isday)
		
