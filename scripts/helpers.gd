
class_name Helper

static func big_int_formatter(value: float) -> String:
	var Letter : String = ""
	
	if value < 1000:
		return "%d" % value
	if value < 1000000:
		value /= 1000
		Letter = "K"
	else:
		value /= 1000000
		Letter = "M"
	
	return "%.2f" % value + Letter
