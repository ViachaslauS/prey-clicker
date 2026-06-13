extends AnimalHandlerBase
class_name FoxHandler

const FOX_DATA: AnimalData = preload("res://res/data/animals/fox_data.tres")

func _ready() -> void:
	if data == null:
		data = FOX_DATA
	super._ready()
