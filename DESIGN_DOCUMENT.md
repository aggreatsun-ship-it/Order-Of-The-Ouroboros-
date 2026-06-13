# ORDER OF THE OUROBOROS - Game Design Document

## 1. VISION & THEME

**Title**: Order of the Ouroboros  
**Genre**: Action RPG + Roguelike  
**Platform**: PC (Windows/Mac/Linux)  
**Engine**: Godot 4.x  

**Core Concept**: 
An action RPG where players embody angelic alchemists undergoing inner alchemy transmutation. Progress through seven transmutation stages (Lead → Copper → Silver → Gold) by battling darkness, mastering alchemical magic, and making moral choices that shape your journey from shadow to light.

---

## 2. CHARACTER ARCHETYPES (7 Playable Characters)

1. **Serpent Guardian - Fermentation** (Green, venomous, aggressive)
2. **Shadow Alchemist - Distillation** (Desert rider, wisdom, balance)
3. **Shark Tooth - Dissolution** (Aquatic, chaos, rhythm)
4. **Locke Star - Coagulation** (Fire, rage, explosive)
5. **Ancient Sage - Coagulation** (Cosmic, dual-pistols, wisdom)
6. **Phia - Celestial Oracle** (Divine, light, angelic)
7. **Veiled Initiate - Conjunction** (Void, mystery, purple magic)

---

## 3. TRANSMUTATION STAGES (Progression)

1. Calcination (Lead)
2. Dissolution (Silver)
3. Separation (Copper)
4. Conjunction (Union)
5. Fermentation (Growth)
6. Distillation (Refinement)
7. Coagulation (Gold - Ascension)

---

## 4. CORE SYSTEMS

- **Real-time Action Combat** (dodge, parry, combos)
- **Alchemy Essence System** (combine for spells)
- **Skill Trees** (3 branches per character)
- **Equipment System** (weapons, armor, talismans)
- **Moral Choice System** (Light/Shadow/Balanced paths)
- **Roguelike Mode** (procedural levels, permadeath optional)
- **Campaign Mode** (7 chapters, story-driven)

---

## 5. TECHNICAL ARCHITECTURE

```
Order-Of-The-Ouroboros/
├── scenes/
│   ├── main.tscn
│   ├── ui/
│   ├── levels/
│   ├── characters/
│   ├── enemies/
│   └── bosses/
├── scripts/
│   ├── character/
│   ├── combat/
│   ├── alchemy/
│   ├── enemy/
│   ├── ui/
│   ├── level/
│   └── managers/
├── assets/
│   ├── sprites/
│   ├── audio/
│   ├── fonts/
│   └── data/
└── project.godot
```

See full DESIGN_DOCUMENT.md for complete details.
