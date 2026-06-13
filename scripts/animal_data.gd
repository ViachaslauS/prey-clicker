extends Resource
class_name AnimalData

@export var display_name: String = "Animal"
@export var dna_type: SaveManager.DNAType = SaveManager.DNAType.Hare
@export var save_key_prefix: String = "animal"

@export var passive_gain_time: float = 0.5
@export var passive_gain_per_level: int = 1
@export var passive_gain_cost_base: int = 100
@export var passive_gain_cost_step: int = 50

@export var mimic_cost_base: int = 10
@export var mimic_cost_step: int = 50

@export var click_gain_per_level: int = 1
@export var click_upgrade_cost_step: int = 5
@export var click_upgrade_max_level: int = 5

@export var default_passive_level: int = 1
@export var default_mimic_count: int = 0
@export var default_click_level: int = 1
