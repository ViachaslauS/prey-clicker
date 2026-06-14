extends Node
class_name AnimalHandlerBase

const PASSIVE_GAIN_LEVEL_KEY_SUFFIX: String = "gain_passive_amount_level"
const MIMIC_COUNT_KEY_SUFFIX: String = "mimic_count"
const CLICK_GAIN_LEVEL_KEY_SUFFIX: String = "dna_click_gain_level"

@export var data: AnimalData

var _passive_gain_timer: float = 0.0

func _ready() -> void:
	assert(data != null, "AnimalHandlerBase requires AnimalData resource.")
	_passive_gain_timer = data.passive_gain_time

func _process(delta: float) -> void:
	if data == null:
		return

	_passive_gain_timer -= delta
	if _passive_gain_timer <= 0.0:
		_passive_gain_timer = data.passive_gain_time
		var passive_gain: int = get_mimic_count() * get_passive_gain_amount()
		if passive_gain > 0:
			SaveManager.add_dna(get_dna_type(), passive_gain)

func get_display_name() -> String:
	return data.display_name

func get_dna_type() -> SaveManager.DNAType:
	return data.dna_type

func get_passive_gain_amount() -> int:
	return get_passive_gain_level() * data.passive_gain_per_level

func get_passive_gain_level() -> int:
	return int(SaveManager.get_value(_get_key(PASSIVE_GAIN_LEVEL_KEY_SUFFIX), data.default_passive_level))

func get_next_passive_gain_level_cost() -> int:
	return data.passive_gain_cost_base + get_passive_gain_level() * data.passive_gain_cost_step

func can_upgrade_passive_gain_level() -> bool:
	return SaveManager.get_dna(get_dna_type()) >= get_next_passive_gain_level_cost()

func upgrade_passive_gain_level() -> void:
	if can_upgrade_passive_gain_level():
		SaveManager.add_dna(get_dna_type(), -get_next_passive_gain_level_cost())
		SaveManager.set_value(_get_key(PASSIVE_GAIN_LEVEL_KEY_SUFFIX), get_passive_gain_level() + 1)

func get_mimic_count() -> int:
	return int(SaveManager.get_value(_get_key(MIMIC_COUNT_KEY_SUFFIX), data.default_mimic_count))

func get_mimic_count_upgrade_cost() -> int:
	return data.mimic_cost_base + get_mimic_count() * data.mimic_cost_step

func can_upgrade_mimic_count() -> bool:
	return SaveManager.get_dna(get_dna_type()) >= get_mimic_count_upgrade_cost()

func upgrade_mimic_count() -> void:
	if can_upgrade_mimic_count():
		SaveManager.add_dna(get_dna_type(), -get_mimic_count_upgrade_cost())
		SaveManager.set_value(_get_key(MIMIC_COUNT_KEY_SUFFIX), get_mimic_count() + 1)

func get_current_dna_gain_level_per_click() -> int:
	return int(SaveManager.get_value(_get_key(CLICK_GAIN_LEVEL_KEY_SUFFIX), data.default_click_level))

func get_current_dna_gain_per_click() -> int:
	return get_current_dna_gain_level_per_click() * data.click_gain_per_level

func can_upgrade_dna_gain_per_click() -> bool:
	return get_current_dna_gain_level_per_click() < data.click_upgrade_max_level and SaveManager.get_dna(get_dna_type()) >= get_current_dna_gain_per_click_upgrade_cost()

func is_dna_per_click_maxed() -> bool:
	return get_current_dna_gain_level_per_click() >= data.click_upgrade_max_level

func get_current_dna_gain_per_click_upgrade_cost() -> int:
	if get_current_dna_gain_level_per_click() >= data.click_upgrade_max_level:
		return 0
	return get_current_dna_gain_level_per_click() * data.click_upgrade_cost_step

func upgrade_current_dna_gain_per_click() -> void:
	if can_upgrade_dna_gain_per_click():
		SaveManager.add_dna(get_dna_type(), -get_current_dna_gain_per_click_upgrade_cost())
		SaveManager.set_value(_get_key(CLICK_GAIN_LEVEL_KEY_SUFFIX), get_current_dna_gain_level_per_click() + 1)

func add_click_dna() -> void:
	SaveManager.add_dna(get_dna_type(), get_current_dna_gain_per_click())

func _get_key(key_suffix: String) -> String:
	return "%s_%s" % [data.save_key_prefix, key_suffix]
