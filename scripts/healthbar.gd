extends ProgressBar
var max_health := 100
var health := 100
var display_health := 100
@onready var hud: CanvasLayer = $".."

func _process(delta: float) -> void:
	display_health = lerp(display_health, health, 5 * delta)
	self.value = display_health
	@warning_ignore("integer_division")
	var t = display_health/max_health
	self.modulate = Color.RED.lerp(Color.GREEN, t)
	
	
func _ready() -> void:
	hud.connect("reduce_bar", Callable(self, "_reduce_bar"))

func _reduce_bar() -> void:
	health -= 10
