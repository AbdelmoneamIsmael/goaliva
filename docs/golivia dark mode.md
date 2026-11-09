---
name: Goaliva
colors:
  surface: '#111220'
  surface-dim: '#111220'
  surface-bright: '#373847'
  surface-container-lowest: '#0b0d1a'
  surface-container-low: '#191b28'
  surface-container: '#1d1f2c'
  surface-container-high: '#272937'
  surface-container-highest: '#323442'
  on-surface: '#e1e1f4'
  on-surface-variant: '#cbc3d7'
  inverse-surface: '#e1e1f4'
  inverse-on-surface: '#2e2f3e'
  outline: '#958ea0'
  outline-variant: '#494454'
  surface-tint: '#d0bcff'
  primary: '#d0bcff'
  on-primary: '#3c0091'
  primary-container: '#a078ff'
  on-primary-container: '#340080'
  inverse-primary: '#6d3bd7'
  secondary: '#7bd0ff'
  on-secondary: '#00354a'
  secondary-container: '#00a6e0'
  on-secondary-container: '#00374d'
  tertiary: '#45dfa4'
  on-tertiary: '#003825'
  tertiary-container: '#00a574'
  on-tertiary-container: '#003120'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#e9ddff'
  primary-fixed-dim: '#d0bcff'
  on-primary-fixed: '#23005c'
  on-primary-fixed-variant: '#5516be'
  secondary-fixed: '#c4e7ff'
  secondary-fixed-dim: '#7bd0ff'
  on-secondary-fixed: '#001e2c'
  on-secondary-fixed-variant: '#004c69'
  tertiary-fixed: '#68fcbf'
  tertiary-fixed-dim: '#45dfa4'
  on-tertiary-fixed: '#002114'
  on-tertiary-fixed-variant: '#005137'
  background: '#111220'
  on-background: '#e1e1f4'
  surface-variant: '#323442'
typography:
  display-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 36px
    fontWeight: '700'
    lineHeight: 44px
    letterSpacing: -0.02em
  display-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 30px
    fontWeight: '700'
    lineHeight: 38px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 26px
    fontWeight: '700'
    lineHeight: 34px
    letterSpacing: -0.015em
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 30px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 26px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 22px
  body-sm:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '400'
    lineHeight: 20px
  label-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.02em
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 14px
    letterSpacing: 0.02em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1rem
  margin: 1.25rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2rem
---

## Brand & Style

This design system establishes an atmospheric, focused, and high-performance digital environment tailored for an AI motivation, goal architecture, and intelligent habit companion. Built specifically for ambitious individuals seeking clarity and progress, the aesthetic fuses deep-focus dark surfaces with targeted bursts of luminescent energy.

### Aesthetic Foundation
- **Luminescent Dark Mode:** A midnight navy atmospheric foundation (#0C0E1B) reduces cognitive fatigue and visual noise, allowing goal cards, progress rings, and streaks to emerge with clarity.
- **Micro-Glow Depth:** Subtle radiant gradients and localized atmospheric blurs highlight milestone completions, active AI habit recommendations, and personal best streaks without distracting from data density.
- **Tactile Modernism:** Pill badges, continuous curves, and fluid card transitions create an inviting tactile rhythm that makes daily logging feel like an accomplishment rather than admin work.

### Bilingual Native Ethos
The design treats English and Arabic as equal first-class citizens. Typography, spatial flow, icon mirroring, and directional layouts mirror instinctively between LTR and RTL without visual distortion or unequal typographical hierarchy.

## Colors

The palette balances deep immersion with motivational beacons of light. The primary base remains low-reflectance midnight navy, ensuring the luminous accents function as purposeful interaction anchors.

### Core Roles
- **Primary (`#8B5CF6` / Electric Violet):** Represents active volition, core CTA states, daily primary target markers, and AI generation highlights.
- **Secondary (`#38BDF8` / Sky Blue):** Anchors secondary milestones, scheduled reminders, analytics trackers, and ambient background blooms.
- **Tertiary (`#34D399` / Achievement Green):** Denotes milestone success, maintained streaks, completed habit rings, and positive delta values.
- **Base Neutral (`#0C0E1B` / Midnight Navy):** The structural viewport foundation for all primary screens and canvas backdrops.

### Surface Tiers & Overlays
- **Surface Level 1 (`#171A2B`):** Default card background, bottom navigation container, and app bars.
- **Surface Level 2 (`#21253B`):** Elevated modals, nested subtasks, toggle trays, and interactive list items.
- **Surface Level 3 (`#2C324E`):** Hover/press active states, dropdown overlays, and segmented controls.

### Content & Borders
- **Text Primary (`#F2F5FA`):** Maximum contrast for primary metrics, titles, and body content.
- **Text Secondary (`#9CA3AF`):** Muted utility text, timestamps, inactive icons, and metadata.
- **Stroke Subtle (`rgba(156, 163, 175, 0.12)`): Structure boundaries for cards and interactive inputs.
- **Stroke Glow (`rgba(139, 92, 246, 0.35)`): Dynamic borders for focused states and active AI habit loops.

## Typography

Typography delivers crisp technical legibility and rhythmic pacing across complex analytics and short daily check-ins.

### Bilingual Pairings & Font Stacks
- **English Display & Labels:** `Plus Jakarta Sans`, accompanied by `system-ui`. Provides a clean geometric structure with soft terminals that balance the deep background.
- **English Body:** `Inter`, backed by standard fallback stacks. Selected for optical balance in dense habit logs and long-form AI coach insights.
- **Arabic Systemic Stack:** Map English tokens directly to `Tajawal` or `Cairo` for all levels.
  - Scale Arabic font sizes by +1px relative to English counterparts to account for glyph height and diacritic balance (e.g., `body-md` uses 15px in Arabic).
  - Adjust Arabic line-heights upward by 2–4px to preserve full clearance for ascenders, descenders, and accent marks.

### Rules of Engagement
- Avoid letter-spacing on Arabic script tokens; set tracking strictly to `0` or `normal`.
- Use bold weights sparingly (`700`) solely for primary numeric targets, streak days, and main screen headings. Maintain body and descriptive metadata at `400` or `500` to prevent dense visual clutter in dark mode.

## Layout & Spacing

The spatial engine uses a disciplined 8-point base grid (with a 4-point micro-subgrid for icons, borders, and micro-badges).

### Mobile Canvas Target
- **Primary Mobile Viewport:** 390px base width (iPhone standard viewport) with dynamic vertical viewport adaptation.
- **Screen Margins:** Fixed 20px (`1.25rem`) horizontal margins to frame dashboard content neatly without edge crowding.
- **Internal Column Grid:** 4-column fluid mobile grid with 16px (`1rem`) gutters.

### Component Internal Density
- **Micro Spacing (`0.25rem` / 4px):** Tag badge padding, ring label gaps.
- **Compact Spacing (`0.5rem` / 8px):** Icon-to-text separation within buttons, nested list item margins.
- **Standard Spacing (`1rem` / 16px):** Standard card inner padding, vertical stack gaps between related inputs.
- **Section Spacing (`1.5rem` / 24px):** Separation between functional goal clusters and analytic cards.
- **Major Block Spacing (`2rem` / 32px):** Top hero module offset and modal section spacing.

### Responsive Handlers
On viewport expansions (tablets or wide foldables above 600px), card containers max out at 520px centered width, maintaining an intentional mobile-first vertical column rather than uncomfortably stretching habit rings.

## Elevation & Depth

Visual hierarchy uses three complementary tactics: structural tonal elevation, localized glass transparency, and purposeful chromatic ambient glow.

### Depth Hierarchy
1. **Canvas (`#0C0E1B`):** Deepest ground plane. Contains ambient background mesh gradients that subtly drift behind active milestones.
2. **Base Containers (`#171A2B`):** Resting state for cards, habit tiles, and daily task lists. Flat tonal surface framed by a 1px `rgba(156, 163, 175, 0.12)` border.
3. **Elevated Surfaces (`#21253B`):** Used for bottom sheets, expanded habit views, dropdown menus, and active swipe cards. Elevation is reinforced by subtle directional shadow: `0 8px 24px -4px rgba(0, 0, 0, 0.45)`.
4. **Floating HUD & System Bars:** Bottom navigation and floating action pods utilize a glassmorphic treatment: `rgba(23, 26, 43, 0.82)` with `backdrop-filter: blur(20px)` and an inner highlight line along the top border (`rgba(242, 245, 250, 0.08)`).

### Luminous Motivation Glows
Shadows do not rely solely on black alphas. High-priority components leverage soft colored glows:
- **Active Goal / In Progress:** `0 0 20px -4px rgba(139, 92, 246, 0.35)`
- **Completed Streak / Today’s Win:** `0 0 24px -4px rgba(52, 211, 153, 0.40)`
- **AI Recommendation Alert:** `0 0 16px -2px rgba(56, 189, 248, 0.30)`

## Shapes

The design system employs a rounded, organic geometry that balances technical structure with approachable consumer wellness.

### Radius Scale
- **Pills & Badges (`rounded-full`):** Category tags, streak counts, action buttons, and segmented control chips use continuous full radii.
- **Large Cards & Modals (`rounded-xl` to 24px):** Standard goal containers, daily performance dashboards, and AI summary modals.
- **Inner Controls (`rounded-lg` / 16px):** Checkboxes, nested input blocks, and sub-metric displays.
- **Micro Elements (`rounded-md` / 8px):** Calendar day chips, graph bars, and tooltip indicators.

### Corner Treatment
All surface edges utilize continuous squircle curvature where native platform rendering allows (iOS continuous corner smoothing), eliminating harsh apex points.

## Components

### Buttons
- **Primary Action:** Solid Electric Violet (`#8B5CF6`) background, White text (`#F2F5FA`), `rounded-full`, 52px height for mobile touch ergonomics. Includes a 12px outer violet drop glow when active.
- **Secondary Action:** Ghost surface with `#21253B` fill, 1px `#9CA3AF` stroke (at 20% opacity), 48px height.
- **AI Spark Action:** Gradient fill from `#8B5CF6` to `#38BDF8`, white text, accompanied by an AI icon.

### Cards & Habit Tiles
- **Structure:** Level 1 dark surface (`#171A2B`), 20px padding, 20px corner radius, hairline 1px border.
- **Interactive State:** Depressing a card scales it to `0.98` with haptic feedback.
- **Streak Variant:** Displays flame or streak integer within an Achievement Green (`#34D399`) pill positioned at the trailing edge (right in LTR, left in RTL).

### Progress Rings & Visual Trackers
- **Ring Geometry:** 8px stroke width for circular progress widgets. Background track in `#21253B`, active track rendered in an Electric Violet to Sky Blue linear gradient.
- **Success State:** Transitions entirely to Achievement Green (`#34D399`) with celebratory particle or pulse micro-interaction upon 100% completion.

### Bottom Navigation Bar
- **Form:** Floating docked capsule 16px above the device safe area, 68px height, `rounded-full` or 28px continuous radius.
- **Backdrop:** 80% opacity `#171A2B` with 24px blur.
- **Active Tab:** Electric Violet tinted icon with a miniature 4px glow dot centered beneath it.

### Input Fields & Selectors
- **Input Wells:** Height 52px, filled with `#171A2B`, border 1px `rgba(156, 163, 175, 0.20)`. Focused state shifts border to `#8B5CF6` with a faint 3px outer glow ring.
- **Typography:** Placeholder text rendered in `#9CA3AF`, user value in `#F2F5FA`. Directional alignment flips automatically based on active language keyboard input.

### Bilingual RTL / LTR Behavioral Rules
- **Back Navigation & Arrows:** Flip horizontal orientation strictly in Arabic mode (e.g., standard chevron `>` becomes `<`).
- **Progress Indicators:** Linear progress bars fill Left-to-Right in English and Right-to-Left in Arabic.
- **Number Placement:** Metrics (e.g., "12/20 Tasks") retain their logical order alongside Arabic descriptive nouns without scrambling mathematical order.