extends Control
class_name WolfPopup

@export var handler_path: NodePath

@onready var _name_label: Label = $Name
@onready var _dna_label: Label = $MarginContainer/Empty/Panel/DNALabel
@onready var _gain_per_click_label: Label = $MarginContainer/Empty/GridContainer/IncreaseDNAByClickLabel
@onready var _gain_per_click_button: Button = $MarginContainer/Empty/GridContainer/IncreaseDNAByClickButton
@onready var _summon_wolf_label: Label = $MarginContainer/Empty/GridContainer/IncreaseMimicCountLabel
@onready var _summon_wolf_button: Button = $MarginContainer/Empty/GridContainer/IncreaseMimicCountButton
@onready var _passive_gain_label: Label = $MarginContainer/Empty/GridContainer/IncreaseMimicPowerLabel
@onready var _passive_gain_button: Button = $MarginContainer/Empty/GridContainer/IncreaseMimicPowerButton
@onready var _cross_species_label: Label = $MarginContainer/Empty/GridContainer/SendMimicToHaresLabel
@onready var _cross_species_button: Button = $MarginContainer/Empty/GridContainer/SendMimicToHaresButton

func _ready() -> void:
	_name_label.text = "WOLF"
	_summon_wolf_label.text = "Summon wolf"

func _process(_delta: float) -> void:
	_update_popup()

func _update_popup() -> void:
	var wolf_handler: WolfHandler = _get_handler()
	if wolf_handler == null:
		return

	_gain_per_click_label.text = "DNA per click (%s)" % Helper.big_int_formatter(wolf_handler.get_current_dna_gain_level_per_click())
	_gain_per_click_button.text = Helper.big_int_formatter(wolf_handler.get_upgrade_dna_gain_per_click_cost())
	_gain_per_click_button.disabled = not wolf_handler.can_upgrade_dna_gain_per_click()

	_summon_wolf_button.text = Helper.big_int_formatter(wolf_handler.get_upgrade_mimic_count_cost())
	_summon_wolf_button.disabled = not wolf_handler.can_upgrade_mimic_count()

	_passive_gain_label.text = "Donate summoned wolves\nincrease passive (%s)" % Helper.big_int_formatter(wolf_handler.get_passive_gain_level())
	_passive_gain_button.text = Helper.big_int_formatter(wolf_handler.get_upgrade_passive_gain_cost())
	_passive_gain_button.disabled = not wolf_handler.can_upgrade_passive_gain() or wolf_handler.get_mimic_count() <= 0

	_cross_species_label.text = "Each summon boosts\nhares+foxes (%s)" % Helper.big_int_formatter(WolfHandler.get_cross_species_bonus())
	_cross_species_button.text = Helper.big_int_formatter(wolf_handler.get_cross_species_support_upgrade_cost())
	_cross_species_button.disabled = not wolf_handler.can_upgrade_cross_species_support_level() or wolf_handler.get_mimic_count() <= 0

	_dna_label.text = "DNA: %s" % Helper.big_int_formatter(wolf_handler.get_dna())

func _on_increase_dna_by_click_button_pressed() -> void:
	var wolf_handler: WolfHandler = _get_handler()
	if wolf_handler == null:
		return
	wolf_handler.upgrade_dna_gain_per_click()

func _on_increase_mimic_count_button_pressed() -> void:
	var wolf_handler: WolfHandler = _get_handler()
	if wolf_handler == null:
		return
	wolf_handler.upgrade_mimic_count()

func _on_increase_mimic_power_button_pressed() -> void:
	var wolf_handler: WolfHandler = _get_handler()
	if wolf_handler == null:
		return
	wolf_handler.upgrade_passive_gain()

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
