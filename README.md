# minddy — Free Project Management Software

**minddy** is a modular, open-source project management tool built in Dart and Flutter.  
It was designed to be simple, customizable, and accessible to everyone — even if it's far from perfect.

> **⚠️ Status:** This project is no longer maintained.  
> **🔒 License:** [GNU GPL v3](https://www.gnu.org/licenses/gpl-3.0.html)

---

## About this project

minddy started as a personal project in October 2023.  
At first, it was just something I made for myself. But soon, I started building it in a more open way, hoping it could serve more use cases than I initially imagined.

I taught myself design and development along the way, and development really started around February/March 2024.  
I spent months coding it, learning, testing, redoing. It became my main focus — until I discovered photography, which quickly became my true passion.

So yes: this project is now **abandoned**, but I want to release it anyway — because it meant a lot to me.

---

## Why open-source?

I didn’t want to let this project die silently on my computer.  
It was always meant to be open-source… just not unfinished.

Even if minddy never gets widely used, even if it's full of bugs or questionable code, I’m proud of what it taught me.  
If a single line of it is useful to someone else, then it’s already a success.

---

## Key features

minddy is a desktop app based on **modules** — you only use the parts you need.  
At the moment, the following modules are available:

- ✅ **Tasks** – a simple to-do list
- ✅ **Notes** – categorized note-taking
- ✅ **Tables** – editable data tables with basic graphing
- 🧪 **Articles** – create and share text-based articles, block by block
- 📅 **Calendar** – create events and deadlines with weekly/hourly views

There was also a module creation system in progress, allowing users to create new modules with node-based logic. This part is **unfinished**, but partially implemented.

---

## Architecture & Codebase

> ⚠️ Disclaimer: I’m not a professional developer, and this code was written while learning.

- The project uses a **clean architecture**… more or less.  
  I ended up diverging from it quite a bit.

- `/lib/system`: main app logic (encryption, config, utils, etc.)
- `/lib/ui`: all interface-related files, views and controllers
- `custom_components`: reusable UI elements
- `view_models`: logic for each page
- `initialize`, `files`, `model`, `interfaces`, `router`: various internal systems

The app uses **`dart intl`** for localization. It’s currently translated in:
- 🇫🇷 French (fully done)
- 🇬🇧 English (roughly translated)
- 🇪🇸 Spanish (machine-translated, probably full of mistakes)

---

## Known issues

- On the **Table module**, too many data points in the graph cause visual overflow.
- Occasionally, saved data in tables disappears (no idea why — couldn’t reproduce it reliably).
- Some modules are poorly structured or lack explanations.
- A long list of TODOs still exists in `main.dart` — most of them no longer make sense, even to me.

---

## 🔧 Development notes

minddy was developed on **macOS**, and the macOS build may require a **valid Apple Developer certificate** to run.

If you encounter issues when building for macOS:
- Make sure you have Xcode installed
- In `macos/Runner.xcodeproj`, disable "Automatically manage signing"
- You may need to remove or change the **signing team ID** in the project settings

> This only affects macOS builds. The code is still cross-platform and should work on Windows and Linux (though not all platforms were tested).

---

## 🚫 No prebuilt binaries

This repository does **not include any compiled binaries** or installers.

To run the project, you'll need to:
1. Install [Flutter](https://flutter.dev/docs/get-started/install)
2. Clone the repository
3. Run it with `flutter run` from your preferred platform folder

There is currently **no automatic release pipeline** for Windows or macOS.

## Final words

minddy isn’t perfect. The code is messy. Some features are incomplete.  
But building it taught me a lot, and I hope opening it up can help someone, even just a little.

Feel free to explore, use, remix — it's all yours now.

— Clément (a.k.a. mangué)