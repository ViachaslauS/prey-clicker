extends AnimalHandlerBase
class_name WolfHandler

const WOLF_DATA: WolfData = preload("res://res/data/animals/wolf_data.tres")
const CROSS_SPECIES_SUPPORT_LEVEL_SUFFIX: String = "cross_species_support_level"

func _ready() -> void:
	if data == null:
		data = WOLF_DATA
	super._ready()

static func get_cross_species_bonus() -> int:
	var summoned_wolf_count: int = int(SaveManager.get_value("wolf_%s" % MIMIC_COUNT_KEY_SUFFIX, WOLF_DATA.default_mimic_count))
	var support_level: int = int(SaveManager.get_value("wolf_%s" % CROSS_SPECIES_SUPPORT_LEVEL_SUFFIX, 0))
	if support_level <= 0 or summoned_wolf_count <= 0:
		return 0
	return summoned_wolf_count * support_level * WOLF_DATA.cross_species_bonus_per_summoned_wolf_per_level

func get_cross_species_support_level() -> int:
	return int(SaveManager.get_value(_get_key(CROSS_SPECIES_SUPPORT_LEVEL_SUFFIX), 0))

func get_cross_species_support_upgrade_cost() -> int:
	return WOLF_DATA.cross_species_bonus_upgrade_cost_base + get_cross_species_support_level() * WOLF_DATA.cross_species_bonus_upgrade_cost_step

func can_upgrade_cross_species_support_level() -> bool:
	return SaveManager.get_dna(get_dna_type()) >= get_cross_species_support_upgrade_cost()

func upgrade_cross_species_support_level() -> void:
	if can_upgrade_cross_species_support_level():
		SaveManager.add_dna(get_dna_type(), -get_cross_species_support_upgrade_cost())
		SaveManager.set_value(_get_key(CROSS_SPECIES_SUPPORT_LEVEL_SUFFIX), get_cross_species_support_level() + 1)
