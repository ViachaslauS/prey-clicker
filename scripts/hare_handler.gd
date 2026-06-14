extends AnimalHandlerBase
class_name HareAnimalHandler

@export var data_path: String = "res://res/data/animals/hare_data.tres"

func _ready() -> void:
	if data == null:
		data = load(data_path) as AnimalData
	super._ready()

func get_click_dna_bonus() -> int:
	return WolfHandler.get_cross_species_bonus()

func get_passive_gain_bonus() -> int:
	return WolfHandler.get_cross_species_bonus()
