extends Area2D

@export var speed : float = 400.0

# FUNGSI: _ready()
# APA:     Mendaftarkan player ke grup "player" untuk deteksi oleh node lain (fruit).
# PARAM:   Tidak ada.
# KEMBALI: Tidak ada.
# KONSEP:  Group di Godot — cara mengelompokkan node agar mudah dicari/dicek.
#          Berguna untuk deteksi: "apakah area yang masuk adalah player?"
func _ready():
    add_to_group("player")

# FUNGSI: _process(delta)
# APA:     Menggerakkan player jika game sudah dimulai.
# PARAM:   delta — waktu sejak frame terakhir.
# KEMBALI: Tidak ada.
# KONSEP:  get_node() — mengakses node lain dari path scene tree.
#          Early return — cek kondisi dulu sebelum eksekusi kode utama.
func _process(delta):
    # Mendapatkan referensi ke GameManager dari path absolut di scene tree.
    var gm = get_node("/root/Main/GameManager")

    # Jika GameManager ada dan game belum dimulai, jangan gerakkan player.
    if gm and not gm.is_started:
        return  # KONSEP: Early return — keluar fungsi lebih awal jika kondisi terpenuhi.

    var direction = Input.get_axis("move_left", "move_right")
    position.x += direction * speed * delta

    var view_size = get_viewport_rect().size
    position.x = clamp(position.x, 0, view_size.x)
