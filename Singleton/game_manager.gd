extends Node

const MAX_HAND_SIZE = 1

signal set_up_card(type: int)

@export var isDebug := true
enum FRIEND_TYPES {ADDING, MULTIPLYING}

var base_card = preload("res://Cards/base_card.tscn")
var base_friend = preload("res://Friends/base_friend.tscn")

var baseballer_sprite = preload("res://Assets/baseballer.png")
var witch_sprite = preload("res://Assets/witch.png")

var friends_dictionary = {
    FRIEND_TYPES.ADDING: {
        "friend_name": "Adding Friend",
        "sprite": baseballer_sprite,
        "description": "Add 10 damage",
        "cost": "2",
        "type": FRIEND_TYPES.ADDING
    },
    FRIEND_TYPES.MULTIPLYING: {
        "friend_name": "Multiplying Friend",
        "sprite": witch_sprite,
        "description": "Multiply damage by 2",
        "cost": "3",
        "type": FRIEND_TYPES.MULTIPLYING
    },
}

enum BOSSES {CRAB, DRAGON}

var cards_in_hand = []
var cards_in_set_up = []
var cards_in_field = []

var current_damage : int

func _process(_delta)-> void:
    if isDebug:
        if Input.is_action_just_pressed("ui_cancel"):
            get_tree().quit()
        if Input.is_action_just_pressed("reload"):
            get_tree().reload_current_scene()


func generate_card(type: int) -> Card:
    var return_card = base_card.instantiate()
    match type:
        FRIEND_TYPES.ADDING:
            return_card.card_name = friends_dictionary[FRIEND_TYPES.ADDING].friend_name
            return_card.sprite = friends_dictionary[FRIEND_TYPES.ADDING].sprite
            return_card.description = friends_dictionary[FRIEND_TYPES.ADDING].description
            return_card.cost = friends_dictionary[FRIEND_TYPES.ADDING].cost
            return_card.card_type = friends_dictionary[FRIEND_TYPES.ADDING].type
        FRIEND_TYPES.MULTIPLYING:
            return_card.card_name = friends_dictionary[FRIEND_TYPES.MULTIPLYING].friend_name
            return_card.sprite = friends_dictionary[FRIEND_TYPES.MULTIPLYING].sprite
            return_card.description = friends_dictionary[FRIEND_TYPES.MULTIPLYING].description
            return_card.cost = friends_dictionary[FRIEND_TYPES.MULTIPLYING].cost
            return_card.card_type = friends_dictionary[FRIEND_TYPES.MULTIPLYING].type

    return return_card

func generate_friend(type: int) -> Friend:
    var return_friend = base_friend.instantiate()
    match type:
        FRIEND_TYPES.ADDING:
            return_friend.friend_type = friends_dictionary[FRIEND_TYPES.ADDING].type
            return_friend.sprite = friends_dictionary[FRIEND_TYPES.ADDING].sprite
        FRIEND_TYPES.MULTIPLYING:
            return_friend.friend_type = friends_dictionary[FRIEND_TYPES.MULTIPLYING].type
            return_friend.sprite = friends_dictionary[FRIEND_TYPES.MULTIPLYING].sprite
        
    return return_friend
    
