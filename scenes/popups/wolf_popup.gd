extends Control
class_name WolfPopup

@export var handler_path: NodePath

@onready var _name_label: Label = $Name
@onready var _dna_label: Label = $MarginContainer/Empty/GridContainer/WolfDNA_Count
@onready var _gain_per_click_label: Label = $MarginContainer/Empty/GridContainer/DnaPerClickLevel
@onready var _gain_per_click_button: Button = $MarginContainer/Empty/GridContainer/DnaPerClickButton
@onready var _summon_wolf_label: Label = $MarginContainer/Empty/GridContainer/SummonWolfLabel
@onready var _summon_wolf_button: Button = $MarginContainer/Empty/GridContainer/SummonWolfButton
@onready var _passive_gain_label: Label = $MarginContainer/Empty/GridContainer/IncreaseMimicPowerLabel
@onready var _passive_gain_button: Button = $MarginContainer/Empty/GridContainer/IncreaseMimicPowerButton
@onready var _cross_species_label: Label = $MarginContainer/Empty/GridContainer/CrossSpeciesBoostLabel
@onready var _cross_species_button: Button = $MarginContainer/Empty/GridContainer/CrossSpeciesBoostButton

func _ready() -> void:
	_name_label.text = "WOLF"

func _process(_delta: float) -> void:
	_update_popup()

func _update_popup() -> void:
	var wolf_handler: WolfHandler = _get_handler()
	if wolf_handler == null:
		return

	_gain_per_click_label.text = "DNA per click (%s)" % Helper.big_int_formatter(wolf_handler.get_current_dna_gain_level_per_click())
	_gain_per_click_button.text = Helper.big_int_formatter(wolf_handler.get_current_dna_gain_per_click_upgrade_cost())
	_gain_per_click_button.disabled = not wolf_handler.can_upgrade_dna_gain_per_click()

	_summon_wolf_label.text = "Summon wolf (%s)" % Helper.big_int_formatter(wolf_handler.get_mimic_count())
	_summon_wolf_button.text = Helper.big_int_formatter(wolf_handler.get_mimic_count_upgrade_cost())
	_summon_wolf_button.disabled = not wolf_handler.can_upgrade_mimic_count()

	_passive_gain_label.text = "Donate summoned wolves\nIncrease passive (%s)" % Helper.big_int_formatter(wolf_handler.get_passive_gain_level())
	_passive_gain_button.text = Helper.big_int_formatter(wolf_handler.get_next_passive_gain_level_cost())
	_passive_gain_button.disabled = not wolf_handler.can_upgrade_passive_gain_level() or wolf_handler.get_mimic_count() <= 0

	_cross_species_label.text = "Each summoned wolf boosts\nhares + foxes (%s)" % Helper.big_int_formatter(wolf_handler.get_cross_species_support_level())
	_cross_species_button.text = Helper.big_int_formatter(wolf_handler.get_cross_species_support_upgrade_cost())
	_cross_species_button.disabled = not wolf_handler.can_upgrade_cross_species_support_level() or wolf_handler.get_mimic_count() <= 0

	_dna_label.text = "%s" % Helper.big_int_formatter(SaveManager.get_dna(wolf_handler.get_dna_type()))

func _on_dna_per_click_button_pressed() -> void:
	var wolf_handler: WolfHandler = _get_handler()
	if wolf_handler == null:
		return
	wolf_handler.upgrade_current_dna_gain_per_click()

func _on_mimic_count_upgrade_button_pressed() -> void:
	var wolf_handler: WolfHandler = _get_handler()
	if wolf_handler == null:
		return
	wolf_handler.upgrade_mimic_count()

func _on_increase_mimic_power_button_pressed() -> void:
	var wolf_handler: WolfHandler = _get_handler()
	if wolf_handler == null:
		return
	wolf_handler.upgrade_passive_gain_level()

func _on_send_mimic_to_hares_button_pressed() -> void:
	var wolf_handler: WolfHandler = _get_handler()
	if wolf_handler == null:
		return
	wolf_handler.upgrade_cross_species_support_level()

func _get_handler() -> WolfHandler:
	var resolved_handler: Node = get_node_or_null(handler_path)
	if resolved_handler is WolfHandler:
		return resolved_handler as WolfHandler
	return null
