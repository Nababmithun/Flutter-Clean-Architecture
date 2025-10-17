🏗️ Clean Architecture MVVM Starter (Flutter + GetX + Dio + Hive)

A production-ready Flutter starter template built with Clean Architecture and MVVM pattern, using GetX, Dio, Hive, and modern tools for scalable mobile apps.
This boilerplate is designed to help you start new large projects quickly with a consistent, maintainable, and testable structure.

🚀 Features at a Glance

🧠 Clean Architecture + MVVM – Layered, testable & maintainable codebase
⚙️ GetX – State management, routing & dependency injection
🌐 Dio – Powerful REST API client with interceptors
💾 Hive – Lightweight local storage (for tokens, cache, etc.)
🔐 Auth Flow Ready – Register, Login, Logout & Me endpoints pre-wired
🌍 EasyLocalization + Intl – Multi-language support (🇬🇧 English, 🇧🇩 Bangla)
⚡ flutter_dotenv – Environment configuration with .env
📦 Equatable + Logger – Clean entities & easy debugging
📱 Responsive UI & Bottom Navigation – Pre-built splash, auth, home, history & profile screens

🧱 Project Structure
lib/
├─ core/
│  ├─ di/              # Dependency injection
│  ├─ i18n/            # Translations (EasyLocalization)
│  ├─ network/         # Dio API client & interceptors
│  ├─ router/          # GetX routes & pages
│  ├─ storage/         # Hive token store
│  └─ widgets/         # Common reusable widgets
│
├─ features/
│  ├─ splash/          # Splash screen
│  ├─ auth/            # Login, Register, Logout (data, domain, presentation)
│  ├─ home/            # Home screen
│  ├─ history/         # History screen
│  ├─ profile/         # Profile with language switch & logout
│  └─ notifications/   # Notification screen
│
├─ app.dart            # Root app (GetMaterialApp setup)
└─ main.dart           # App entry point
