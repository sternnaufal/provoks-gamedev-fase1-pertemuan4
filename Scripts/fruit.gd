extends Area2D

@export var fall_speed : float = 200.0

# FUNGSI: _ready()
# APA:     Menghubungkan signal area_entered untuk deteksi collision dengan player.
# PARAM:   Tidak ada.
# KEMBALI: Tidak ada.
# KONSEP:  Signal area_entered — event ketika Area2D bersentuhan dengan Area2D lain.
func _ready():
    area_entered.connect(_on_area_entered)

# FUNGSI: _process(delta)
# APA:     Menggerakkan buah jatuh. Jika lewat layar, kurangi nyawa player.
# PARAM:   delta — waktu sejak frame terakhir.
# KEMBALI: Tidak ada.
# KONSEP:  Cek kondisi game over sebelum bergerak (early return).
func _process(delta):
    var gm = get_node("/root/Main/GameManager")
    # Jika game sudah berakhir, berhenti bergerak.
    if gm and gm.is_game_over:
        return

    position.y += fall_speed * delta

    # Jika buah jatuh melewati batas bawah layar (+50 untuk margin)...
    if position.y > get_viewport_rect().size.y + 50:
        if gm:
            gm.lose_life()  # Beritahu GameManager bahwa nyawa berkurang.
        var sfx = get_node_or_null("/root/Main/SfxLose")
        if sfx:
            sfx.play()  # SFX nyawa berkurang.
        queue_free()

# FUNGSI: _on_area_entered(area)
# APA:     Dipanggil saat buah bersentuhan dengan Area2D lain.
# PARAM:   area — Area2D yang masuk ke area buah.
# KEMBALI: Tidak ada.
# KONSEP:  is_in_group("player") — mengecek apakah area yang masuk adalah player.
func _on_area_entered(area):
    if area.is_in_group("player"):
        collect()  # Jika yang masuk adalah player, maka buah dikumpulkan.

# FUNGSI: collect()
# APA:     Menambah score melalui GameManager lalu menghapus buah.
# PARAM:   Tidak ada.
# KEMBALI: Tidak ada.
# KONSEP:  Memisahkan logika ke fungsi terpisah agar kode lebih rapi (modular).
func collect():
    var gm = get_node("/root/Main/GameManager")
    if gm:
        gm.add_score(10)  # Tambah 10 poin per buah yang berhasil ditangkap.
    var sfx = get_node_or_null("/root/Main/SfxCatch")
    if sfx:
        sfx.play()  # SFX buah tertangkap.
    queue_free()  # Hapus buah dari scene.
