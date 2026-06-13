extends Button
class_name AnimalClickButton

@export var press_tick: float = 0.5
@export var handler_path: NodePath = NodePath("../HareHandler")
@export var popup_path: NodePath = NodePath("HarePopup")

var _pressed_time: float = 0.0
var _handler: AnimalHandlerBase
var _popup: Control

func _ready() -> void:
	_pressed_time = press_tick
	_handler = get_node_or_null(handler_path) as AnimalHandlerBase
	_popup = get_node_or_null(popup_path) as Control

	if _handler == null:
		push_warning("AnimalClickButton could not find AnimalHandlerBase at path: %s" % str(handler_path))

func _process(delta: float) -> void:
	if button_pressed:
		_pressed_time -= delta
		if _pressed_time <= 0.0:
			_pressed_time = press_tick
			_increase_dna_count()

func _on_mouse_entered() -> void:
	if _popup != null:
		_popup.show()

func _on_mouse_exited() -> void:
	if _popup != null:
		_popup.hide()

func _increase_dna_count() -> void:
	if _handler != null:
		_handler.add_click_dna()

func _on_button_up() -> void:
	_pressed_time = press_tick

func _on_button_down() -> void:
	_increase_dna_count()
	_pressed_time = press_tick
