extends Button

const per_level_on_click_add_amount = 1

var press_tick : float = 0.5
var pressed_time : float = press_tick

func _get_on_click_add_amount() -> int:
	return SaveManager.get_value("hare_gain_on_click_amount_level", 1) * per_level_on_click_add_amount


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
	SaveManager.add_dna(SaveManager.DNAType.Hare, _get_on_click_add_amount())

func _on_button_up() -> void:
	pressed_time = press_tick

func _on_button_down() -> void:
	_increase_dna_count()
	pressed_time = press_tick
