extends CanvasLayer

var level_label
var lives_label
var gems_label


func _ready():
	level_label = $LevelLabel
	lives_label = $LivesContainer/LivesLabel
	gems_label = $GemsContainer/GemsLabel
	update_hud()


func update_hud():
	level_label.text = "Level: " + str(Global.current_level)
	lives_label.text = str(Global.lives)
	gems_label.text = str(Global.gems_collected)
