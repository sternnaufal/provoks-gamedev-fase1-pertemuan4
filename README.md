# PROVOKS Game Dev — Fase 1, Checkpoint Pertemuan 4

Project Godot 4 contoh untuk **Pertemuan 4: User Interface & Polish**.
Game catching sudah lengkap: layar start, skor, nyawa, layar game over, tombol restart, plus SFX.

## Jalankan

1. Buka **Godot 4** (dites di 4.7.2, seharusnya jalan di 4.4+).
2. **Import** → pilih `project.godot` di folder ini.
3. Tekan **F5**.

Kontrol: **A / D** atau **← / →** untuk gerak · **SPACE / Enter** untuk mulai · klik **Restart** setelah game over.

## Struktur

```
project.godot            800x600, stretch canvas_items, texture filter Nearest
Assets/
  bg_sky.png             background langit
  player_hunter.png      sprite player (frame 17x27, scale 2.5)
  Fruit+.png             spritesheet buah 16x16
  font_pixel.ttf         font HUD & game over
  sfx_catch.wav          SFX buah tertangkap
  sfx_lose.wav           SFX nyawa berkurang
Scenes/
  main.tscn              Main → BackgroundLayer + GameManager + Player + Spawner
                         + SfxCatch + SfxLose + HUD + GameOver
  Player.tscn            Area2D, layer 1
  Fruit.tscn             Area2D, layer 0, mask 1
  GameOver.tscn          CanvasLayer, visible = false
Scripts/
  game_manager.gd        state + 4 signal (score_changed, lives_changed, game_started, game_over)
  player.gd              grup "player" + guard is_started
  fruit.gd               jatuh, +10 saat ditangkap, -1 nyawa saat lolos, SFX
  spawner.gd             spawn hanya saat PLAY
  ui.gd                  HUD + tombol start (ui_accept)
  game_over.gd           tampilkan skor akhir + restart
```

## Checklist checkpoint (akhir Pertemuan 4)

- [ ] `GameManager` = **Node** di bawah `Main`, script `game_manager.gd`
- [ ] `Player` masuk grup `player`, diam sebelum game start
- [ ] `Fruit` → `add_score(10)` saat ditangkap, `lose_life()` saat lolos
- [ ] `HUD` = **CanvasLayer**, 3 label: `ScoreLabel`, `LivesLabel`, `StartLabel`
- [ ] `GameOver` = **CanvasLayer**, `visible = false`, tombol Restart
- [ ] `Spawner` tidak spawn saat start / game over
- [ ] Path semua ke `/root/Main/GameManager`
- [ ] SPACE → main · tangkap +10 · lolos −1 · nyawa habis → Game Over → Restart bersih

## Alur state

```
START  → SPACE → start_game() → PLAY → nyawa 0 → GAME OVER → Restart → START
```

## Troubleshooting

| Gejala | Penyebab paling sering |
|---|---|
| Buah tetap spawn di layar start | `spawner.gd` belum cek `is_started` |
| Skor tidak bertambah | `fruit.gd` lama (P3) / player belum `add_to_group("player")` |
| Nyawa tidak berkurang | `lose_life()` tidak dipanggil saat buah lolos |
| UI tidak berubah | signal belum di-connect / path GameManager salah |
| Error null instance | root scene bukan `Main` |
| HUD ikut gerak | label ditaruh di Node2D, bukan CanvasLayer |
| Tidak ada suara | `SfxCatch` / `SfxLose` belum ada di `Main` |

## Milestone 1

Setelah checkpoint ini: **Project → Export → Add → Windows Desktop** → Export Project → uji `.exe` di luar Godot.

## Kredit aset

- Background: Legacy Fantasy – High Forest (Senin Terus Studio asset library)
- Player: Pixel Pete's Art Assets
- Font: Star Choco (2D Platformer Starter Kit)
- SFX: dibuat khusus untuk checkpoint ini
