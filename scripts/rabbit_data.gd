extends Node

const per_level_on_click_add_amount = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_click():
	SaveManager.add_dna(SaveManager.DNAType.Rabbit, _get_on_click_add_amount())

func _get_on_click_add_amount() -> int:
	return SaveManager.get_value("rabbit_on_click_amount_level", 1) * per_level_on_click_add_amount
