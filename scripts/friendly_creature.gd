class_name FriendlyCreature
extends Node2D

enum Job {FARMING, MINING, WOODCUTTING, WATER}

@export var creature_name : String = "Creature Name"
@export var description : String = "Description"
@export var allowed_jobs : Array[Job] = [Job.FARMING, Job.MINING]
@export var assigned_job = null
@export var picker_thumbnail : CompressedTexture2D

func assign_first_job():
	assigned_job = allowed_jobs[0]

func assign_second_job():
	assigned_job = allowed_jobs[1]
