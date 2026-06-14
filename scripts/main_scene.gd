extends Node2D

@onready var TotalDNA = $DNA_Amount

@onready var TotalDNAProgress : ProgressBar = $TotalDNAProgressBar

@onready var UnlockList = [
	[ 1000, $Fox ]
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_areas_visibility()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	TotalDNA.text = "Total DNA: %s" % Helper.big_int_formatter(SaveManager.get_dna(SaveManager.DNAType.Overall))
	_update_areas_visibility()

func _update_areas_visibility():
	var current_dna : float = SaveManager.get_dna(SaveManager.DNAType.Overall)
	
	var current_dna_target : float = 0
	for i in UnlockList.size():
		if current_dna >= UnlockList[i][0]:
			UnlockList[i][1].show()
		else:
			UnlockList[i][1].hide()
			current_dna_target = UnlockList[i][0]
	
	if current_dna_target > 0:
		var progress : float = current_dna / current_dna_target
		TotalDNAProgress.value = progress * 100
	else:
		TotalDNAProgress.value = TotalDNAProgress.max_value

func _on_reset_progress_button_pressed() -> void:
	SaveManager.reset()
