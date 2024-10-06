extends CanvasModulate

var time:float = 0.0
@export var gradient:GradientTexture1D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	var value = (sin(time/9) + 1.0)/2.0
	self.color = gradient.gradient.sample(value)
