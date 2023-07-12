extends ProgressBar

@export var runtime_data: RuntimeData


func _process(delta):
	set_value(runtime_data.factor_progress)
