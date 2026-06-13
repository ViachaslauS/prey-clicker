extends Node

# Legacy backup copy kept without global class registration.

const passive_hare_gain_time : float = 0.5
var passive_hare_gain_timer : float = 0

const per_level_passive_hare_gain : int = 1
const per_level_passive_hare_gain_upgrade_cost = 10

const per_level_mimic_count_upgrade_cost = 50

const mimic_count : int = 0

const HareDNAClickGainPerLevel : int = 1
const hare_dna_gain_per_click_upgrade_cost = 5
const hare_dna_gain_per_click_max_level = 5

static var HareDNAClickGainLevelName : String = "hare_dna_click_gain_level"

static var HarePassiveGainLevelName : String = "hare_gain_passive_amount_level"
static var HareMimicCount : String = "hare_mimic_count"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	passive_hare_gain_timer = passive_hare_gain_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	passive_hare_gain_timer -= delta
	if passive_hare_gain_timer <= 0:
		passive_hare_gain_timer = passive_hare_gain_time
		SaveManager.add_dna(SaveManager.DNAType.Hare, get_hare_mimic_count() * get_passive_hare_gain_amount())

static func get_passive_hare_gain_amount() -> int:
	return get_passive_hare_gain_level() * per_level_passive_hare_gain

static func get_passive_hare_gain_level() -> int:
	return SaveManager.get_value(HarePassiveGainLevelName, 1)

static func get_next_passive_hare_gain_level_cost() -> int:
	return 100 + get_passive_hare_gain_level() * per_level_passive_hare_gain_upgrade_cost * 5

static func can_be_passive_hare_gain_upgraded() -> bool:
	return SaveManager.get_dna(SaveManager.DNAType.Hare) >= get_next_passive_hare_gain_level_cost()

static func upgrade_hare_passive_gain_level():
	if can_be_passive_hare_gain_upgraded():
		SaveManager.add_dna(SaveManager.DNAType.Hare, -get_next_passive_hare_gain_level_cost())
		SaveManager.set_value(HarePassiveGainLevelName, get_passive_hare_gain_level() + 1)

static func get_hare_mimic_count():
	return SaveManager.get_value(HareMimicCount)
	
static func get_hare_mimic_count_upgrade_cost():
	return 10 + get_hare_mimic_count() * per_level_mimic_count_upgrade_cost
	
static func can_be_hare_mimic_count_upgraded():
	return SaveManager.get_dna(SaveManager.DNAType.Hare) >= get_hare_mimic_count_upgrade_cost()
	
static func upgrade_hare_mimic_count():
	if can_be_hare_mimic_count_upgraded():
		SaveManager.add_dna(SaveManager.DNAType.Hare, -get_hare_mimic_count_upgrade_cost())
		SaveManager.set_value(HareMimicCount, get_hare_mimic_count() + 1)

static func get_current_dna_gain_level_per_click():
	return SaveManager.get_value(HareDNAClickGainLevelName, 1)

static func get_current_hare_dna_gain_per_click() -> int:
	return get_current_dna_gain_level_per_click() * HareDNAClickGainPerLevel
	
static func can_be_dna_gain_per_click_upgraded() -> bool:
	return get_current_dna_gain_level_per_click() < hare_dna_gain_per_click_max_level && SaveManager.get_dna(SaveManager.DNAType.Hare) >= get_current_dna_gain_per_click_upgrade_cost()
	
static func get_current_dna_gain_per_click_upgrade_cost() -> int:
	if get_current_dna_gain_level_per_click() >= hare_dna_gain_per_click_max_level:
		return 0
	return get_current_dna_gain_level_per_click() * hare_dna_gain_per_click_upgrade_cost

static func upgrade_current_dna_gain_per_click():
	if can_be_dna_gain_per_click_upgraded():
		SaveManager.add_dna(SaveManager.DNAType.Hare, -get_current_dna_gain_per_click_upgrade_cost())
		SaveManager.set_value(HareDNAClickGainLevelName, get_current_dna_gain_level_per_click() + 1)
