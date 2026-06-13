extends Control

@onready var UpgradeHarePassiveGainButton = $GridContainer/IncreaseMimicPowerButton
@onready var UpgradeHarePassiveGainLabel = $GridContainer/IncreaseMimicPowerLabel
@onready var HareDNACount = $GridContainer/HareDNA_Count

@onready var HareMimicCountLabel = $GridContainer/IncreaseMimicCountLabel
@onready var HareMimicCountButton = $GridContainer/HareMimicCountButton

@onready var DNAPerClickLevelLabel = $GridContainer/DnaPerClickLevel
@onready var DNAPerClickLevelButton = $GridContainer/DnaPerClickButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	HareDNACount.text = Helper.big_int_formatter(SaveManager.get_dna(SaveManager.DNAType.Hare))
	
	HareMimicCountButton.disabled = !HareHandler.can_be_hare_mimic_count_upgraded()
	UpgradeHarePassiveGainButton.disabled = HareHandler.get_hare_mimic_count() == 0 || !HareHandler.can_be_passive_hare_gain_upgraded()
	DNAPerClickLevelButton.disabled = !HareHandler.can_be_dna_gain_per_click_upgraded()
	
	DNAPerClickLevelLabel.text = "Increase DNA gain\nper click (%s)" % Helper.big_int_formatter(HareHandler.get_current_dna_gain_level_per_click())
	DNAPerClickLevelButton.text = Helper.big_int_formatter(HareHandler.get_current_dna_gain_per_click_upgrade_cost())
	
	UpgradeHarePassiveGainButton.text = Helper.big_int_formatter(HareHandler.get_next_passive_hare_gain_level_cost())
	UpgradeHarePassiveGainLabel.text = "Increase mimic\npower (%s)" % Helper.big_int_formatter(HareHandler.get_passive_hare_gain_level())
	
	HareMimicCountLabel.text = "Increase mimic\ncount (%s)" % Helper.big_int_formatter(HareHandler.get_hare_mimic_count())
	HareMimicCountButton.text = Helper.big_int_formatter(HareHandler.get_hare_mimic_count_upgrade_cost())

func _on_hare_upgrade_button_pressed() -> void:
	HareHandler.upgrade_hare_mimic_count()

func _on_increase_mimic_power_button_pressed() -> void:
	HareHandler.upgrade_hare_passive_gain_level()

func _on_dna_per_click_button_pressed() -> void:
	HareHandler.upgrade_current_dna_gain_per_click()
