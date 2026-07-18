# ORDER OF THE OUROBOROS - Game Design Document

## 1. VISION & THEME

**Title**: Order of the Ouroboros  
**Genre**: Action RPG + Roguelike  
**Platform**: PC (Windows/Mac/Linux)  
**Engine**: Godot 4.x  

**Core Concept**: 
An action RPG where players embody angelic alchemists undergoing inner alchemy transmutation. Progress through seven transmutation stages (Lead → Copper → Silver → Gold) by battling darkness.

---

## 2. CHARACTER ARCHETYPES (11 Playable Characters)

1. **Serpent Guardian - Fermentation** (Green, venomous, aggressive)
   - Weapon: [Primary weapon]

2. **Shadow Alchemist - Distillation** (Desert rider, wisdom, balance)
   - Weapon: Rope Dart
   - Elements: Dark alchemy, precision strikes

3. **Shark Tooth - Dissolution** (Aquatic, chaos, rhythm)
   - Weapon: [Primary weapon]
   - Elements: Water, cyclical rhythm combat

4. **Locke Star - Coagulation** (Fire, rage, explosive)
   - Weapon: [Primary weapon]

5. **Ancient Sage - Coagulation** (Cosmic, stone weapons, wisdom)
   - Weapon: Stone Weapons
   - Elements: Earth, cosmic wisdom

6. **Phia - Celestial Oracle** (Divine, light, angelic)
   - Weapon: [Primary weapon]

7. **Veiled Initiate - Conjunction** (Void, mystery, purple magic)
   - Weapon: [Primary weapon]

8. **OMRADAHNU** (Warrior, chakram master)
   - Weapon: Chakrams
   - Elements: [Combat elements]

9. **ZOOKU - The Aztec Warrior - Fermentation** (Aztec warrior vibe, earth elements)
   - Weapon: Obsidian Club
   - Elements: Earth magic, ancestral power, ritual combat

10. **RYNO — Twin Hunga Munga Earthshaker** (Colossal guardian, earth elemental)
    - Weapon: Twin Hunga Munga throwing axes (blackened steel and ancient bone)
    - Appearance: Massive body resembling living granite wrapped in ritual armor with glowing ancestral markings. Braided beard with ancestral bones, horned helm evoking rhinoceros strength, eyes burning with protective fury.
    - Combat Style: Spins and recalls axes through devastating circular techniques that shatter armor and split the earth. Each footstep creates earthquakes, every swing scatters enemies like shattered stone.
    - Philosophy: Does not seek conquest—he is the guardian who refuses to let the herd fall.
    - Elements: Earth, seismic power, ancestral protection

11. **SIRENAURA - Water Deity Elder - Dissolution** (Aquatic, siren/mermaid elements, elder wisdom)
    - Weapon: Rope Dart
    - Spirit Animal: Dolphin
    - Elements: Water deity magic, siren songs, elder knowledge
    - Heritage: Elder from Shark Tooth's homeland
    - Traits: Mermaid/siren hybrid form, ancient sea wisdom

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
- **Campaign Mode** (11 chapters, story-driven)

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
