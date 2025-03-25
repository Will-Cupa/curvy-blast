class_name mathFunction extends Expression

var XYScale : float = 30.0

func valueAt(x : float) -> float:
	return -execute([x/XYScale])*XYScale

func slopeAt(x : float, precision : float) -> float:
	return (valueAt(x + precision) -valueAt(x))/precision
	
