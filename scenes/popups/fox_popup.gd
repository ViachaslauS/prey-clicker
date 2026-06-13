extends Control
class_name FoxPopup

@export var handler_path: NodePath = NodePath("res://scripts/fox_handler.gd")

@onready var _upgrade_passive_gain_button: Button = $GridContainer/IncreaseMimicPowerButton
@onready var _upgrade_passive_gain_label: Label = $GridContainer/IncreaseMimicPowerLabel
@onready var _dna_count_label: Label = $GridContainer/HareDNA_Count

@onready var _mimic_count_label: Label = $GridContainer/IncreaseMimicCountLabel
@onready var _mimic_count_button: Button = $GridContainer/HareMimicCountButton

@onready var _dna_per_click_level_label: Label = $GridContainer/DnaPerClickLevel
@onready var _dna_per_click_level_button: Button = $GridContainer/DnaPerClickButton
@onready var _name_label: Label = $Name

var _handler: AnimalHandlerBase

func _ready() -> void:
	hide()
	_handler = get_node_or_null(handler_path) as AnimalHandlerBase
	if _handler == null:
		push_warning("AnimalPopup could not find AnimalHandlerBase at path: %s" % str(handler_path))

func _process(_delta: float) -> void:
	if _handler == null:
		return

	_name_label.text = _handler.get_display_name().to_upper()
	_dna_count_label.text = Helper.big_int_formatter(SaveManager.get_dna(_handler.get_dna_type()))

	_mimic_count_button.disabled = !_handler.can_upgrade_mimic_count()
	_upgrade_passive_gain_button.disabled = _handler.get_mimic_count() == 0 or !_handler.can_upgrade_passive_gain_level()
	_dna_per_click_level_button.disabled = !_handler.can_upgrade_dna_gain_per_click()

	_dna_per_click_level_label.text = "Increase DNA gain\nper click (%s)" % Helper.big_int_formatter(_handler.get_current_dna_gain_level_per_click())
	_dna_per_click_level_button.text = Helper.big_int_formatter(_handler.get_current_dna_gain_per_click_upgrade_cost())

	_upgrade_passive_gain_button.text = Helper.big_int_formatter(_handler.get_next_passive_gain_level_cost())
	_upgrade_passive_gain_label.text = "Increase mimic\npower (%s)" % Helper.big_int_formatter(_handler.get_passive_gain_level())

	_mimic_count_label.text = "Increase mimic\ncount (%s)" % Helper.big_int_formatter(_handler.get_mimic_count())
	_mimic_count_button.text = Helper.big_int_formatter(_handler.get_mimic_count_upgrade_cost())

func _on_mimic_count_upgrade_button_pressed() -> void:
	if _handler != null:
		_handler.upgrade_mimic_count()

func _on_increase_mimic_power_button_pressed() -> void:
	if _handler != null:
		_handler.upgrade_passive_gain_level()

func _on_dna_per_click_button_pressed() -> void:
	if _handler != null:
		_handler.upgrade_current_dna_gain_per_click()
