extends Timer

@export var fruit_scene : PackedScene

func _ready():
    timeout.connect(_on_timeout)

# FUNGSI: _on_timeout()
# APA:     Membuat instance buah baru jika game sedang berjalan dan belum game over.
# PARAM:   Tidak ada.
# KEMBALI: Tidak ada.
# KONSEP:  Conditional spawning — spawn hanya jika state game mengizinkan.
#          Mencegah buah muncul saat game belum dimulai atau sudah selesai.
func _on_timeout():
    var gm = get_node("/root/Main/GameManager")

    # KONSEP: Guard clause — jika game over atau belum started, jangan spawn.
    if gm and (gm.is_game_over or not gm.is_started):
        return

    if fruit_scene:
        var fruit = fruit_scene.instantiate()
        var view_size = get_viewport().get_visible_rect().size
        fruit.position.x = randf_range(50, view_size.x - 50)
        fruit.position.y = -50
        add_sibling(fruit)
