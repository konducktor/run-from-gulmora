extends Node2D


@export var PARTICLES : Array[CPUParticles2D]

var current_particle


func _ready() -> void:
	for particle in PARTICLES:
		if particle:
			particle.emitting = false
	
	GlobalSignals.new_layer_reached.connect(_on_new_layer_reached)


func _on_new_layer_reached(layer_idx: int) -> void:
	var new_particle = PARTICLES[layer_idx]
	
	if current_particle:
		current_particle.emitting = false
	
	if new_particle:
		new_particle.emitting = true
		current_particle = new_particle
