extends Node2D

@onready var TotalDNA = $DNA_Amount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	TotalDNA.text = "Total DNA: %s" % Helper.big_int_formatter(SaveManager.get_dna(SaveManager.DNAType.Overall))

func _on_reset_progress_button_pressed() -> void:
	SaveManager.reset()
