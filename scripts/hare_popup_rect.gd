extends Button

var press_tick : float = 0.5
var pressed_time : float = press_tick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if button_pressed:
		pressed_time -= delta
		if pressed_time <= 0:
			pressed_time = press_tick
			_increase_dna_count()


func _on_mouse_entered() -> void:
	$HarePopup.show()
	
func _on_mouse_exited() -> void:
	$HarePopup.hide()

func _increase_dna_count() -> void:
	SaveManager.add_dna(SaveManager.DNAType.Hare, HareHandler.get_current_hare_dna_gain_per_click())

func _on_button_up() -> void:
	pressed_time = press_tick

func _on_button_down() -> void:
	_increase_dna_count()
	pressed_time = press_tick
