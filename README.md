# Mario Maker 3 Prototype

This repository contains a playable early prototype inspired by the feel of Mario Maker, built in Godot 4 for desktop. It focuses on a retro NES-style look and a simple Mario-like platformer loop.

## What is included
- Side-scrolling 2D platformer movement
- Jumping, running, and collisions
- Basic enemy patrols and stomp behavior
- Simple block platforms and ground generation
- Camera follow
- NES-inspired color palette and pixel-art presentation
- Export settings for Windows and Linux desktop builds

## Controls
- A / D: Move left / right
- W / Space / Up Arrow: Jump

## How to run
1. Download and install Godot 4.x from https://godotengine.org/download
2. Open the project folder in Godot
3. Press F5 or click Run

## Exporting a build
- Open the project in Godot
- Go to Project > Export
- Choose the desktop preset and export a binary for Windows/Linux

## Current scope
This is intentionally a prototype and not a full Mario Maker 2 clone. It is the foundation for a larger game:
- level editor
- more enemy types
- blocks and item system
- save/load levels
- more polished UI

## Repo structure
- `scenes/`: node scenes for the main game, player, and enemy
- `scripts/`: gameplay logic
- `project.godot`: project configuration
- `export_presets.cfg`: desktop export settings
