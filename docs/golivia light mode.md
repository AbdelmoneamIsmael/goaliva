---
name: Goaliva Momentum
colors:
  surface: '#faf8ff'
  surface-dim: '#d2d9f4'
  surface-bright: '#faf8ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f3ff'
  surface-container: '#eaedff'
  surface-container-high: '#e2e7ff'
  surface-container-highest: '#dae2fd'
  on-surface: '#131b2e'
  on-surface-variant: '#4a4455'
  inverse-surface: '#283044'
  inverse-on-surface: '#eef0ff'
  outline: '#7b7487'
  outline-variant: '#ccc3d8'
  surface-tint: '#732ee4'
  primary: '#630ed4'
  on-primary: '#ffffff'
  primary-container: '#7c3aed'
  on-primary-container: '#ede0ff'
  inverse-primary: '#d2bbff'
  secondary: '#006398'
  on-secondary: '#ffffff'
  secondary-container: '#5bb8fe'
  on-secondary-container: '#00476e'
  tertiary: '#005a3d'
  on-tertiary: '#ffffff'
  tertiary-container: '#007551'
  on-tertiary-container: '#88fbc6'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#eaddff'
  primary-fixed-dim: '#d2bbff'
  on-primary-fixed: '#25005a'
  on-primary-fixed-variant: '#5a00c6'
  secondary-fixed: '#cce5ff'
  secondary-fixed-dim: '#93ccff'
  on-secondary-fixed: '#001d31'
  on-secondary-fixed-variant: '#004b73'
  tertiary-fixed: '#85f8c4'
  tertiary-fixed-dim: '#68dba9'
  on-tertiary-fixed: '#002114'
  on-tertiary-fixed-variant: '#005137'
  background: '#faf8ff'
  on-background: '#131b2e'
  surface-variant: '#dae2fd'
typography:
  display-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 3.5rem
    fontWeight: '800'
    lineHeight: 4rem
    letterSpacing: -0.03em
  display-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 2.5rem
    fontWeight: '800'
    lineHeight: 3rem
    letterSpacing: -0.025em
  headline-xl:
    fontFamily: Plus Jakarta Sans
    fontSize: 2.25rem
    fontWeight: '700'
    lineHeight: 2.75rem
    letterSpacing: -0.02em
  headline-xl-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 1.75rem
    fontWeight: '700'
    lineHeight: 2.25rem
    letterSpacing: -0.015em
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 1.5rem
    fontWeight: '600'
    lineHeight: 2rem
    letterSpacing: -0.01em
  title-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 1.25rem
    fontWeight: '600'
    lineHeight: 1.75rem
    letterSpacing: -0.005em
  title-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 1.125rem
    fontWeight: '600'
    lineHeight: 1.625rem
  body-lg:
    fontFamily: Inter
    fontSize: 1rem
    fontWeight: '400'
    lineHeight: 1.625rem
  body-md:
    fontFamily: Inter
    fontSize: 0.875rem
    fontWeight: '400'
    lineHeight: 1.375rem
  label-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 0.875rem
    fontWeight: '600'
    lineHeight: 1.25rem
    letterSpacing: 0.01em
  label-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 0.75rem
    fontWeight: '600'
    lineHeight: 1rem
    letterSpacing: 0.02em
  caption:
    fontFamily: Inter
    fontSize: 0.75rem
    fontWeight: '400'
    lineHeight: 1rem
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1.5rem
  gutter-sm: 1rem
  margin: 2rem
  margin-sm: 1rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2rem
  space-2xl: 3rem
---

## Brand & Style

The design system establishes an uplifting, serene, and razor-sharp environment tailored for high-performance wellness, habit tracking, and goal execution. It balances vitality with composure, steering clear of clinical sterility and overwhelming gamification.

### Visual Style
The aesthetic aligns with **Modern Precision Minimalism**:
- Immaculate white and slate surfaces punctuated by purposeful, energetic micro-accents.
- Soft, atmospheric elevation paired with hairline borders for structural distinction.
- Generous internal padding and breathable layout rhythms to induce focus and intentionality.
- Bilateral aesthetic support for Latin and Arabic typography, celebrating the dual identity of the platform ("Your Goals. Your Momentum." / "جوليفا").

## Colors

The palette operates in strict high-key light mode, engineered around slate clarity and saturated kinetic drivers.

### Palette Roles & Application
- **Primary Violet (`#7C3AED`)**: The primary kinetic color. Used for dominant calls-to-action, primary milestones, active navigation states, and focal metrics.
- **Secondary Sky Blue (`#0284C7`)**: Communicates cadence, flow, and structural progress. Used for habit routines, analytics segments, and interactive sub-actions.
- **Tertiary Achievement Emerald (`#059669`)**: Reserved strictly for validated success: completed streaks, resolved goals, positive performance deltas, and celebration rings.
- **Neutral Deep Slate (`#0F172A`)**: Provides optical grounding, high readability, and sharp contrast against light-slate backing.
- **Surface Architecture**:
  - Base Canvas: `#F8FAFC`
  - Floating Surfaces & Cards: `#FFFFFF`
  - Recessed Containers & Segment Tracks: `#F1F5F9`
  - Structural Hairlines: `#E2E8F0`

### Contrast & Hierarchy
Avoid using the primary violet on saturated secondary surfaces. Keep backgrounds light (`#FFFFFF` or `#F8FAFC`) to preserve an ambient, clutter-free canvas.

## Typography

The typographic system creates clear hierarchy between structural motivation numbers and comfortable reading text.

- **Plus Jakarta Sans** delivers warm geometry for display values, card headings, progress milestones, and interactive controls.
- **Inter** handles narrative reflections, activity descriptions, data logs, and utility labels, providing neutral clarity across dense information.
- Numeric counters, streak badges, and milestone percentages must utilize tabular figures (`tnum`) to avoid shifting layout during real-time updates.

## Layout & Spacing

The layout model uses an 8px base rhythmic grid paired with a modular container strategy to ensure clean adaptation across devices.

### Breakpoints & Grid Structure
- **Mobile (< 768px)**: 4-column fluid layout with `margin-sm` (16px) margins and `gutter-sm` (16px) gutters. Stacked cards and full-width swipeable tracking segments.
- **Tablet (768px – 1024px)**: 8-column fluid layout with 24px margins and 20px gutters. Dual-pane view for calendar scheduling alongside habit lists.
- **Desktop (> 1024px)**: 12-column layout maxing out at `1280px` centered canvas, utilizing `margin` (32px) margins and `gutter` (24px) gutters. Multi-column views for analytics dashboards, daily rituals, and goal timelines.

### Component Spacing Principles
- Internal card padding scales between `space-md` (mobile list cards) and `space-xl` (hero goal milestones).
- Vertical stack separation adheres to `space-lg` between distinct logical clusters and `space-xs` to `space-sm` between title-body pairings.

## Elevation & Depth

Visual depth is achieved through quiet ambient diffusion rather than deep directional drop-shadows, creating weightless, clean layers over the `#F8FAFC` base canvas.

### Ambient Shadow Levels
- **Level 0 (Flat Surface)**: Used for recessed sections, calendar headers, and input wells (`#F1F5F9` background, `0 0 0 1px #E2E8F0`).
- **Level 1 (Card Default)**: Used for habit rows, objective cards, and persistent controls:
  `box-shadow: 0 1px 3px 0 rgba(15, 23, 42, 0.04), 0 4px 12px 0 rgba(15, 23, 42, 0.03); border: 1px solid #E2E8F0;`
- **Level 2 (Active / Hover / Overlay)**: Used for focused cards, interactive modals, date pickers, and popovers:
  `box-shadow: 0 4px 6px -1px rgba(15, 23, 42, 0.05), 0 12px 24px -4px rgba(15, 23, 42, 0.06); border: 1px solid #E2E8F0;`
- **Level 3 (Floating Action / Sticky Bottom Bar)**: Used for primary quick-add launchers and transient toast alerts:
  `box-shadow: 0 10px 30px -5px rgba(124, 58, 237, 0.15), 0 4px 10px -2px rgba(15, 23, 42, 0.04);`

Hairline stroke containment (`1px solid #E2E8F0`) is mandatory across all cards to maintain crisp separation under bright light environments.

## Shapes

The geometric personality features rounded corners that communicate hospitality and modern wellness ergonomics.

### Curvature Application
- **Standard UI Elements & Inputs (`rounded-default`)**: 8px (`0.5rem`) for form inputs, tooltips, and compact action controls.
- **Interactive Badges & Streak Counters**: Full pill curvature (`9999px`) for goal tags, metric indicators, and filter chips.
- **Cards & Habit Blocks (`rounded-lg`)**: 16px (`1rem`) for daily action cards, metric widgets, and list containers.
- **Hero Containers & Visual Modals (`rounded-xl`)**: 24px (`1.5rem`) for weekly review modals, achievement cards, and primary dashboard summaries.

## Components

### Buttons & Trigger Elements
- **Primary Action**: Solid `#7C3AED` fill, white `#FFFFFF` text, `rounded-xl` (16px) or pill, 48px standard touch target height. Subtle hover state transitions to `#6D28D9`.
- **Secondary Action**: Solid `#F1F5F9` background, `#0F172A` text, no visible border, hovering shifts to `#E2E8F0`.
- **Ghost/Tertiary**: Transparent fill, `#475569` text, hover reveals subtle `#F1F5F9` background wash.
- **Success Trigger**: `#059669` fill with white text, deployed for check-ins and completed milestones.

### Cards & Habit Containers
- Background must always be `#FFFFFF` over the `#F8FAFC` canvas.
- Must feature a `1px solid #E2E8F0` border and Level 1 ambient shadow.
- Corner radius is fixed to 16px (`rounded-lg`) for sub-items and 24px (`rounded-xl`) for main containers.
- Padding should be 16px (`space-md`) on mobile, scaling to 24px (`space-lg`) on desktop.

### Chips & Badges
- **Status/Streak Pill**: Saturated soft background tint (e.g., `#059669` at 10% opacity, text in `#059669`), `rounded-full`, vertical padding `4px`, horizontal padding `10px`.
- **Filter Chips**: Inactive uses `#FFFFFF` with `#E2E8F0` border and `#475569` text. Active uses `#7C3AED` with `#FFFFFF` text.

### Inputs & Checkboxes
- **Input Fields**: 44px to 48px height, `#FFFFFF` background, `1px solid #E2E8F0` border, `rounded-default` (8px). On focus: transitions to `1px solid #7C3AED` with an outer ring glow of `0 0 0 3px rgba(124, 58, 237, 0.12)`.
- **Goal Completion Checkbox**: Circular (`rounded-full`), 24px diameter. Default empty state has a 2px `#CBD5E1` outline. Active/completed state transitions via spring animation to `#059669` fill with a crisp white interior checkmark.

### Progress Rings & Milestone Bars
- **Track**: `#F1F5F9` solid tone with rounded ends.
- **Active Fill**: Single tone `#7C3AED` or `#059669` based on category context. Avoid complex muddy gradients; maintain crisp vector paths.