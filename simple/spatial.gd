extends Spatial

const looksize = 100
var lx = 100
var ly = 100

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# load the Simple library
onready var data = preload("res://bin/simple.gdns").new()


func _on_Button_pressed():
	var imgdata = []
	var view = get_tree().current_scene.find_node("view")

	view.Texture = get_viewport().get_texture()
	#view.draw_rect
	var image = get_viewport().get_texture().get_data()
	for j in range(0,looksize):
		for i in range(0,looksize):
		  var color = image.get_pixel(lx+i,ly+j)
		  imgdata.append(color.to_rgba32())

	print("got image data")
	print(data.get_data(imgdata))


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
