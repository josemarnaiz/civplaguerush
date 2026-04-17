class_name PlatformProfile
extends RefCounted


func current_profile() -> Dictionary:
	var profile: Dictionary = {
		"name": "desktop",
		"is_touch": false,
		"button_min_size": Vector2i(220, 54),
		"font_size": 22
	}

	if OS.has_feature("web"):
		profile["name"] = "web"
		profile["font_size"] = 20

	if OS.has_feature("mobile"):
		profile["name"] = "mobile"
		profile["is_touch"] = true
		profile["button_min_size"] = Vector2i(280, 74)
		profile["font_size"] = 28

	return profile
