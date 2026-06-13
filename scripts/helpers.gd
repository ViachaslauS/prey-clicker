
class_name Helper

static func big_int_formatter(value: int) -> String:
	if value < 1000:
		return str(value)
	elif value < 1000000:
		value /= 1000
		return str(value) + "K"
	else:
		value /= 1000000
		return str(value) + "M"
