extends Node
class_name SaveManager

const SAVE_FILE_PATH: String = "user://save_game.cfg"
const SAVE_SECTION: String = "data"

static var instance: SaveManager
var _config: ConfigFile = ConfigFile.new()

enum DNAType
{
	Overall,
	Rabbit,
	Fox,
	Wolf,
	Bear,
	Human,
}

enum ResourceType
{
	Gold,
	Knowledge,
	Bribe,
	LegalForm1,
	Permit,
	Inlfuence,
}

func add_dna(DNA : DNAType, num : int) -> void:
	assert(DNA != DNAType.Overall)
	var res_name = str(DNA)
	set_value(res_name, num + get_value(res_name))
	
	# each time add overall DNA
	var overall_name = str(DNAType.Overall)
	set_value(overall_name, get_value(overall_name, 0) + max(num, 0))
	
func get_dna(DNA : DNAType) -> int:
	return get_value(str(DNA), 0)

func set_resource(resource : ResourceType, num : int) -> void:
	set_value(str(resource), num)

func get_resource(resource : ResourceType, num : int) -> int:
	return get_value(str(resource), num)

func add_resource(resource : ResourceType, num : int) -> void:
	var res_name = str(resource)
	set_value(res_name, num + get_value(res_name))

func _enter_tree() -> void:
	instance = self

func _ready() -> void:
	_load()
	get_tree().set_auto_accept_quit(false)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save()
		get_tree().quit()

func _exit_tree() -> void:
	_save()

func _load() -> void:
	_config = ConfigFile.new()
	if _config.load(SAVE_FILE_PATH) != OK:
		_config.clear()

func _save() -> void:
	_config.save(SAVE_FILE_PATH)

static func set_value(key: String, value: Variant) -> void:
	if instance:
		instance._config.set_value(SAVE_SECTION, key, value)
	else:
		push_warning("SaveManager not initialized.")

static func get_value(key: String, default_value: Variant = null) -> Variant:
	if instance and instance._config.has_section_key(SAVE_SECTION, key):
		return instance._config.get_value(SAVE_SECTION, key, default_value)
	return default_value
