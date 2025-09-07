# 📚 Task App

Welcome to the **Task App**, a dynamic Flutter application that enhances reading experiences with intelligent voice feedback, real-time skill tracking, and multilingual support. Designed for scalability, testability, and modularity, this app uses Flutter’s latest development practices along with advanced tooling and structured state management.

---

## 🚀 Getting Started

This project uses **Flutter** with **flavor-based environments** for smooth development, staging, and production lifecycle management.

### ✅ Prerequisites

Before you begin, ensure you have the following installed:

- Flutter SDK (>= 3.0.0)
- Dart SDK
- Android Studio / VSCode
- Xcode (for iOS development)
- Firebase CLI (if using Firebase services)
- Git

---

## 🧪 Flavors and Build Commands

The app supports 3 environments:

- 🔧 `development`
- 🚧 `staging`
- 🚀 `production`

### ➤ Run the App (Based on Flavor)

```bash
# Development
flutter run --flavor development --target lib/main_development.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor production --target lib/main_production.dart

➤ Build APK or App Bundle

# Development
flutter build apk --flavor development --target lib/main_development.dart
flutter build appbundle --flavor development --target lib/main_development.dart

# Staging
flutter build apk --flavor staging --target lib/main_staging.dart
flutter build appbundle --flavor staging --target lib/main_staging.dart

# Production
flutter build apk --flavor production --target lib/main_production.dart
flutter build appbundle --flavor production --target lib/main_production.dart


```
### ⚙️ Code Generation
Some parts of the app use code generation (e.g., dependency injection, localization, JSON parsing):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
### 📦 Key Dependencies
| Package                | Purpose                        |
| ---------------------- |--------------------------------|
| `flutter_bloc`         | State management (BLoC pattern) |
| `dio`                  | API networking                 |
| `easy_localization`    | Multi-language support         |
| `flutter_easyloading`  | Loading overlay UI             |
| `get_it` + `injectable` | Dependency injection           |
| `lottie`               | Animations                     |
| `flutter_screenutil`   | Responsive layout              |
| `equatable`            | Value comparison in state      |
| `connectivity_plus`    | Network status detection       | 
 -------------------------------------------------------------
### 🏛 Architecture Overview
This project follows a feature-first, layered architecture approach to ensure scalability, maintainability, and clear separation of concerns.
```plaintext
lib/
│
├── core/                   # Application-wide core functionalities (constants, utils, services)
│
├── data/                   # Data layer (API clients, repositories, models)
│
├── features/               # Feature-based modules
│   ├── auth/               # Authentication feature
│   ├── dashboard/          # Dashboard UI and logic
│   ├── home/               # Home screen and related logic          
│   ├── no_internet/        # Offline handling UI and logic
│   ├── profile/            # User profile management
│   ├── splash/             # Splash screen and initialization
│   └── theme/              # App theme, colors, and typography
│
├── generated/              # Auto-generated files (e.g., localization, build configs)
│
├── main_development.dart   # Entry point for Development environment
├── main_production.dart    # Entry point for Production environment
└── main_staging.dart       # Entry point for Staging environment
```
📂 Folder Responsibilities
core/ → Shared utilities, constants, themes, error handling, and base classes.

data/ → Responsible for managing data sources (API, local DB) and repositories.

features/ → Each subfolder represents a self-contained feature module, containing its own UI, state management (Bloc/Cubit), and logic.

generated/ → Contains build-time generated files. Do not edit manually.

main_*.dart → Environment-specific entry points, allowing different configurations for Development, Staging, and Production.

🏗 Architecture Principles
Feature-based structure: Keeps all related files (UI, state, data) in one place per feature.
Environment separation: Different main_*.dart files make it easy to switch between environments.
Layered approach: Clear separation of Core, Data, and Feature layers.

📱 APK Demo Video
Experience the app in action:
📹 https://drive.google.com/file/d/1f3qkuySVNEp7sVBueb4CVshvwl3yflp1/view?usp=sharing

