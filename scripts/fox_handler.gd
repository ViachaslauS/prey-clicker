extends AnimalHandlerBase
class_name FoxHandler

const FOX_DATA: FoxData = preload("res://res/data/animals/fox_data.tres")
const FOX_TO_HARE_LEVEL_SUFFIX: String = "fox_to_hares"

var _fox_to_hare_timer : float = FOX_DATA.passive_gain_time

func _process(delta: float) -> void:
	super._process(delta)
	_fox_to_hare_timer -= delta
	if _fox_to_hare_timer <= 0.0:
		_fox_to_hare_timer = FOX_DATA.passive_gain_time
		SaveManager.add_dna(SaveManager.DNAType.Hare, get_hare_per_fox_gain_count())

func _ready() -> void:
	if data == null:
		data = FOX_DATA
	super._ready()

func can_upgrade_fox_to_hare() -> bool:
	return SaveManager.get_dna(get_dna_type()) >= get_fox_to_hare_upgrade_cost()

func get_fox_to_hares_level() -> int:
	return SaveManager.get_value(_get_key(FOX_TO_HARE_LEVEL_SUFFIX), 0) 

func get_fox_to_hare_upgrade_cost() -> int:
	return FOX_DATA.FoxesToHaresPriceBase + get_fox_to_hares_level() * FOX_DATA.FoxesToHaresPricePerMimicStep

func get_hare_per_fox_gain_count() -> int:
	return get_fox_to_hares_level() * FOX_DATA.FoxesToHaresGainPerPerLevelStep

func upgrade_fox_to_mimic_gain() -> void:
	if can_upgrade_fox_to_hare():
		SaveManager.add_dna(get_dna_type(), get_fox_to_hare_upgrade_cost())
		SaveManager.set_value(_get_key(FOX_TO_HARE_LEVEL_SUFFIX), get_fox_to_hares_level() + 1)
