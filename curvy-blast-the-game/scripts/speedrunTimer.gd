extends CanvasLayer
 
var second : float = 0
var minuts = 0
var hours = 0

func _physics_process(delta):
	second = second + delta
	print(second)
	if second >= 60:
		minuts += 1
		second = 0
		if minuts >= 60:
			hours += 1
	update_ui()
	
func update_ui():
	# Format time with two decimal places
	var formatted_time = str(second)
	var decimal_index = formatted_time.find(".")
	
	if decimal_index > 0:
		formatted_time = formatted_time.left(decimal_index + 3)  # Take only two decimal places
		formatted_time = str(hours) + ":" + str(minuts) + ":" + formatted_time
	$Label.text = formatted_time
