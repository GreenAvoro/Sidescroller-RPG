extends Area2D

# ALl Scene change nodes need an attached Label or control element. This needs to be done after instanceing
	#The reason for creating control elements after instance is so they can be placed in appropriate places

export var currentScene = "None"
export var newScene = "None"




func _on_SceneChange_body_entered(body):
	if body.name == "Player":
		Global.current_Level = newScene
		get_tree().change_scene("res://Scenes/" + newScene + ".tscn")


func _on_Nearby_body_entered(body):
	if body.name == "Player":
		get_node("Label").show()


func _on_SceneChange_body_exited(body):
	if body.name == "Player":
		get_node("Label").hide()
