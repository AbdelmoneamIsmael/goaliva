# Goaliva — Version 1 Product Vision & Requirements

**Document type:** Product identity and functional requirements  
**Product:** Goaliva (جوليفا)  
**Tagline:** Your Goals. Your Momentum.  
**Arabic tagline:** هدفك قدامك، وخطوتك تقرّبك.  
**Status:** Version 1 product definition; the brand name is provisional pending trademark and domain clearance.

## 1. What is Goaliva?

Goaliva is a bilingual (Arabic and English), mobile-first personal motivation and task companion. It helps people turn intentions into concrete daily actions and stay connected to the reasons those actions matter.

Goaliva combines **simple task creation** with a **personal motivational message library**. Users can write their own motivational messages, or import messages they generated with an external AI tool as a JSON file. They can organize these messages and arrange for them to appear as scheduled local notifications on their phone.

Goaliva is not a generic quote wallpaper app, a complex project-management system, or a chatbot. It is a focused, personal experience built around a simple loop: **decide what matters → create a task → receive meaningful encouragement → take action → repeat**.

## 2. The problem we want to solve

People often know what they want to achieve but lose momentum in everyday life. Conventional to-do apps remind them *what* to do without reminding them *why*. Generic motivation apps deliver inspirational phrases that may feel unrelated to a user's real circumstances.

Goaliva connects both sides. It provides a lightweight place to create and manage tasks while allowing users to bring in their own words, reasons, and AI-generated encouragement. The motivation should feel personal because the user controls its content and timing.

## 3. Who the app is for

Goaliva is designed for students, professionals, creators, people learning new skills, and anyone pursuing personal goals. Examples include someone studying programming, preparing for an exam, exercising consistently, building a business, or improving daily habits.

The app is intended for Arabic-speaking and English-speaking users. Both languages are first-class experiences, not an afterthought. Arabic must have natural right-to-left layouts and readable typography.

## 4. Product promise

**“Keep your next step clear and your motivation personal.”**

Goaliva should make it easy to:

- Write down what needs to get done.
- Create a personal collection of encouraging messages.
- Import AI-generated messages from a JSON file without requiring an AI subscription inside Goaliva.
- Schedule those messages as reminders on the device.
- Return to the app and continue making progress without feeling overwhelmed.

## 5. Version 1 scope

Version 1 concentrates on three connected experiences:

1. **Tasks:** Users can create and manage actionable tasks.
2. **Motivation Library:** Users can manually write motivational messages or import them from JSON files.
3. **Scheduled Local Notifications:** Users can choose when motivational messages appear on their phone.

These features must work together as one coherent experience, while each remains useful independently. Version 1 should prioritize simplicity, reliability, privacy, and offline usability over advanced analytics or AI chat features.

## 6. Tasks — what users should be able to do

A task is a specific action the user wants to complete, such as “Study Python for 30 minutes” or “Go for a walk.” Tasks are intentionally simpler than large projects or elaborate goal plans.

Users should be able to:

- Create a task with a clear title.
- Optionally add a description or note.
- Optionally set a due date and time.
- View pending and completed tasks.
- Mark a task as complete or incomplete.
- Edit or delete a task.
- Easily see what they plan to do today.

The task experience should be quick and encouraging. Completing a task should feel satisfying, but the app must not punish users for missing a day. In Version 1, tasks do not require complicated subtasks, dependencies, team collaboration, or project boards.

## 7. Motivation Library — the core differentiator

The Motivation Library is where users control the words they want to see in notifications. Goaliva must not depend exclusively on generic preloaded quotes.

### 7.1 Manually written messages

Users can write their own motivational messages directly in the app. A message may include:

- An optional short title.
- The main motivational text.
- An optional association with a collection or topic.

Users can view, edit, and delete their messages. They should be able to create multiple messages without navigating through an unnecessarily complex workflow.

Example:

> **Title:** Keep going  
> **Message:** You don't need to finish everything today. One meaningful step still counts.

### 7.2 Import AI-generated messages from JSON

Users can ask ChatGPT, Gemini, Claude, or another AI service to generate messages, save them as a JSON file, and import that file into Goaliva.

The app must offer a friendly, understandable import flow:

1. Choose a JSON file from the device.
2. Read and validate its structure.
3. Show a preview of the messages detected.
4. Explain invalid entries clearly rather than silently losing content.
5. Allow the user to confirm the import.
6. Save accepted messages locally so they remain available offline.

The import process should avoid creating accidental duplicates where possible. Importing a file must not erase existing messages. Users should be able to review imported content before using it in notifications.

**Suggested Version 1 JSON format:**

```json
{
  "collection": "Learning Motivation",
  "language": "en",
  "quotes": [
    {
      "title": "Start small",
      "body": "One focused session today is progress toward your goal."
    },
    {
      "title": "Stay consistent",
      "body": "Your future grows through the small actions you repeat."
    }
  ]
}
```

The application should also accept a straightforward documented structure for a list of messages if appropriate. The exact schema must be clear to users and consistent across examples. Imported JSON is treated as untrusted input: malformed files, missing text, unexpectedly large files, and unsupported structures should be handled safely.

### 7.3 Collections

Users should be able to group messages into collections such as “Study Motivation,” “Fitness,” or “Personal Reminders.” A collection can contain manually created and imported messages. Users can browse collections and inspect their contents.

Collections are organizational tools, not social feeds. Public sharing, community discovery, and an online marketplace are outside Version 1.

## 8. Scheduled motivational notifications

Goaliva's reminders should show the actual motivational message in the device notification, rather than a generic “open the app” placeholder.

Users should be able to:

- Turn motivational reminders on or off.
- Choose one or more reminder times.
- Choose the weekdays on which reminders should appear.
- Select the message collection used for a reminder schedule.
- Preview how a notification will read.
- Change or remove a schedule.

The app should rotate messages in a collection to reduce immediate repetition. If the collection is small, repetition may eventually be necessary; this should be handled predictably rather than promising infinite unique content.

Notifications should be **local notifications**: once messages are stored and scheduled on the device, they should not need an internet connection at delivery time. Scheduling must respect device permissions and operating-system limitations. Exact delivery at every requested minute cannot be guaranteed on all devices or battery settings. The experience must handle denied permissions gracefully and explain why reminders may not appear.

A motivational notification can be useful on its own; it should not require the user to open the app to read the message. The amount of visible text may still depend on device notification settings and screen space.

## 9. How the features connect

Tasks and motivation are related, but users should not be forced to configure both.

A user might create “Finish one Flutter lesson,” import a collection of learning-related motivational messages, and schedule a message each morning before their study session. Another user may only want to write personal encouragement and receive it throughout the day. Both experiences are valid.

The core Version 1 user journey is:

**Open Goaliva → create a task → write or import motivational messages → choose a collection and reminder schedule → receive encouragement → return to complete the task.**

The app may display tasks and motivation together on the home screen, but it must not falsely claim that a notification caused a task to be completed or that a quote was generated by Goaliva's own AI.

## 10. Main areas of the app

### Home

A calm, welcoming overview of today's tasks, a featured motivational message, and a quick way to create a task or add motivational content. It should answer: “What is my next useful step?”

### Tasks

A focused list of pending and completed tasks, with straightforward creation, editing, and completion interactions.

### Motivation

The user's collections and messages, with obvious entry points for **Write Message** and **Import JSON**. Importing personal content is a signature feature and should never be buried deep in Settings.

### Reminders

A simple view of active notification schedules, with the ability to create, preview, pause, edit, and delete schedules.

### Settings

Language, theme, notification permission guidance, and basic local-data preferences. Users should understand what data is stored on their device.

## 11. Language and accessibility

Goaliva must support:

- English, using left-to-right layouts.
- Arabic, using right-to-left layouts and natural Arabic wording.
- Readable typography, sufficient contrast, and comfortable touch targets.
- Both light and dark themes if feasible for the initial design.
- Clear empty states, errors, and success messages.
- Respectful encouragement that avoids shame, pressure, or guilt.

The app's tone should be supportive, optimistic, practical, and calm. It should motivate users to take action rather than overwhelm them with exaggerated promises.

## 12. Brand identity

**Name:** Goaliva (جوليفا)  
**Meaning and positioning:** A memorable name built around the idea of goals, forward movement, and personal momentum.  
**Tagline:** Your Goals. Your Momentum.

The desired visual identity is modern, premium, minimal, and approachable. It should work equally well for Arabic and international audiences.

**Proposed visual palette:**

| Role | Color |
| --- | --- |
| Dark background | `#0C0E1B` |
| Dark surface | `#171A2B` |
| Primary accent | `#8B5CF6` |
| Secondary accent | `#38BDF8` |
| Success / progress | `#34D399` |
| Primary light text | `#F2F5FA` |
| Muted text | `#9CA3AF` |

The brand should evoke progress and clarity, not aggressive hustle culture. A simple target, path, or upward movement motif is appropriate. Visuals should be restrained; gradients and celebratory effects should reinforce meaningful moments rather than dominate every screen.

## 13. Product principles

1. **Personal over generic.** Users choose what motivates them.
2. **Action over inspiration alone.** Motivation should support real tasks.
3. **Simple by default.** A new user should understand the core flow quickly.
4. **Offline-first.** Core tasks, stored messages, and scheduled local reminders should remain usable without an account or continuous connection.
5. **Private by default.** Personal messages and tasks should remain local in Version 1 unless the user explicitly exports them.
6. **Bilingual from day one.** Arabic and English receive equal product attention.
7. **Reliable expectations.** Explain notification permission and operating-system limits honestly.
8. **User control.** Users can edit, remove, disable, and organize their own content.

## 14. What Version 1 deliberately does not include

To keep the initial product focused, Version 1 does **not** require:

- A built-in AI chatbot or paid AI generation API.
- User accounts, login, or cloud synchronization.
- A social network, public quote marketplace, or follower system.
- Complex goal hierarchies, team projects, or collaboration.
- Advanced charts, detailed analytics, or competitive leaderboards.
- Subscription billing or a premium paywall.
- AI-generated messages appearing automatically without a user import.

These are possible future directions, not current product promises.

## 15. What success looks like for Version 1

A new user can install Goaliva, understand its purpose, create a task, write a motivational message or import a valid JSON file, create a reminder schedule, and receive the message in a local device notification. They can return later, see their task, and mark it complete.

A returning user can manage their messages and collections, adjust reminder times, and continue using the app without signing in or needing a backend.

Most importantly, Goaliva should feel like **a small daily companion that keeps both the next action and the reason behind it visible**.

---

*This document defines the product identity and intended Version 1 experience. It is not a coding specification, implementation task list, or commitment to a particular technical architecture.*
