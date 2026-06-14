extends Node2D

@onready var TotalDNA: Label = $DNA_Amount
@onready var TotalDNAProgress: ProgressBar = $TotalDNAProgressBar

@onready var UnlockList: Array = [
	[1000, $Fox],
	[5000, $Wolf],
]

func _ready() -> void:
	_update_areas_visibility()

func _process(_delta: float) -> void:
	TotalDNA.text = "Total DNA: %s" % Helper.big_int_formatter(SaveManager.get_dna(SaveManager.DNAType.Overall))
	_update_areas_visibility()

func _update_areas_visibility() -> void:
	var current_dna: float = SaveManager.get_dna(SaveManager.DNAType.Overall)
	var current_dna_target: float = 0.0

	for i: int in UnlockList.size():
		if current_dna >= UnlockList[i][0]:
			UnlockList[i][1].show()
		else:
			UnlockList[i][1].hide()
			if current_dna_target == 0.0:
				current_dna_target = UnlockList[i][0]

	if current_dna_target > 0.0:
		var progress: float = current_dna / current_dna_target
		TotalDNAProgress.value = progress * 100.0
	else:
		TotalDNAProgress.value = TotalDNAProgress.max_value

func _on_reset_progress_button_pressed() -> void:
	SaveManager.reset()
