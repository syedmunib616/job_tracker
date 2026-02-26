#  Job Tracker App — Flutter + Firebase + Riverpod (Enterprise MVVM Architecture)

> **This project follows industry-standard MVVM architecture and demonstrates production-level Flutter engineering practices used in modern US tech companies.**

A scalable Flutter mobile application for job tracking with Firebase authentication, Riverpod state management, and clean enterprise architecture.

This project is built to showcase **professional Flutter engineering skills for US recruiters and tech companies**.

---

# 📌 Overview

The **Job Tracker App** is a modular Flutter application designed for managing job applications while demonstrating:

- Clean architecture
- Feature-based modular structure
- Firebase authentication
- Professional error handling
- Persistent user sessions
- Dark / Light / System theme modes
- Scalable MVVM + Riverpod architecture

---

# ✨ Features

## 🔐 Authentication
- Firebase Email/Password Authentication
- Login, Sign Up, Forgot Password
- Auth Gate for persistent login session
- Splash Screen → Auth Gate → Dashboard flow
- Professional error handling:
    - Incorrect password
    - User not found
    - Invalid email
    - Weak password
    - Email already in use

---

## 🧠 Architecture & State Management
- **MVVM (Model–View–ViewModel)**
- **Riverpod for state management**
- Feature-first modular architecture
- Clean separation of UI, business logic, and services
- Centralized providers and services layer
- Scalable folder structure used in production apps

---

## 📊 Dashboard
- Job application statistics grid
- Recent applications list
- OPT countdown tracker (logic layer implemented)
- Future-ready Firestore analytics integration

---

## 🎨 UI & UX
- Light Mode
- Dark Mode
- System Theme Mode
- Material 3 UI
- Reusable global widgets
- Clean, maintainable UI code

---

# 🏗️ Tech Stack

| Technology | Purpose |
|------------|----------|
| Flutter | Cross-platform mobile framework |
| Dart | Programming language |
| Firebase Authentication | User authentication |
| Cloud Firestore | Job tracking database |
| Riverpod | State management |
| MVVM Architecture | Scalable clean architecture |
| Material 3 | Modern UI design |

---
# 📸 Screenshots

*(Add screenshots later)*

### Login Screen
![Login](screenshots/login.png)

### Dashboard Screen
![Dashboard](screenshots/dashboard.png)

---

# ⚙️ Getting Started

## ✅ Prerequisites

- Flutter SDK (latest stable)
- Dart SDK
- Firebase project with Authentication & Firestore enabled

---

## 📥 Installation

### 1️⃣ Clone Repository

```bash
git clone https://github.com/syedmunib616/job-tracker.git
cd job-tracker
```
---

# 📂 Project Architecture (Enterprise MVVM + Feature-Based)

```text
lib/
├── core/                              # App-wide shared & global logic
│   ├── errors/                         # auth_failure.dart
│   ├── providers/                      # auth_providers.dart, theme_providers.dart
│   ├── constants/                      # app_colors.dart, app_strings.dart
│   ├── services/                       # Firebase & backend wrappers
│   │   ├── auth_service.dart
│   │   ├── employment_service.dart
│   │   ├── job_service.dart
│   │   └── opt_service.dart
│   ├── theme/                          # dark_theme.dart, light_theme.dart
│   └── widgets/                        # Global reusable widgets
│       ├── drawer.dart
│       └── app_text_field.dart
│
├── features/                           # Feature-based modular architecture
│
│   ├── auth/                           # Authentication module
│   │   ├── models/                     # user_model.dart
│   │   ├── view_models/                # auth_view_model.dart, auth_state.dart
│   │   ├── views/                      # login_view.dart, register_view.dart, forget.dart, auth_gate.dart
│   │   └── widgets/                    # login_background.dart, login_form.dart, auth_button.dart
│   │
│   ├── dashboard/                      # Dashboard & Analytics
│   │   ├── view_models/                # dashboard_view_model.dart
│   │   ├── views/                      # dashboard_view.dart
│   │   └── widgets/                    # UI components
│   │       ├── application_tile.dart
│   │       ├── info_row.dart
│   │       ├── job_stats_chart.dart
│   │       ├── job_status_grid.dart
│   │       ├── recent_application_card.dart
│   │       └── status_card.dart
│   │
│   ├── opt/                            # OPT Management Feature
│   │   ├── models/
│   │   │   └── opt_model.dart
│   │   ├── view_models/
│   │   │   └── opt_view_model.dart
│   │   ├── views/
│   │   │   ├── opt_view.dart
│   │   │   └── opt_setup_view.dart
│   │   ├── widgets/
│   │   │   └── info_row.dart
│   │   └── utils/
│   │       └── opt_calculator.dart     # Business logic (unemployment calculation)
│   │
│   ├── employment/                     # Employment Tracking Feature
│   │   ├── models/
│   │   │   └── employment_model.dart
│   │   ├── view_models/
│   │   │   └── employment_view_model.dart
│   │   └── views/
│   │       ├── employment_form_view.dart
│   │       └── employment_list_view.dart
│   │
│   ├── jobs/                           # Job Application CRUD
│   │   ├── models/                     # job_model.dart
│   │   ├── view_models/                # job_view_model.dart
│   │   └── views/                      # job_list_view.dart, job_detail_screen.dart
│   │
│   ├── splash/
│   │   └── views/
│   │       └── splash_view.dart
│   │
│   └── settings/
│       └── views/
│           └── settings_view.dart
│
├── main.dart                            # App entry point & provider setup
└── routes.dart                          # Centralized navigation
```
---

### Install Dependencies 
- flutter pub get
## Add Firebase Configuration
### Android
- android/app/google-services.json
### iOS
- ios/Runner/GoogleService-Info.plist
#### Run the App
- flutter run
---

## Authentication Flow
- Splash screen loads
- Auth Gate checks Firebase user session
- If user is authenticated → Dashboard
- If user is not authenticated → Login screen
- User remains logged in until manual logout

---

## Roadmap (Future Enhancements)
- Full job application CRUD with Firestore
- OPT 90-day unemployment countdown visualization
- Push notifications for OPT reminders
- Resume upload and tracking
- Analytics dashboard
- Web admin panel
- Firebase Cloud Functions automation

---

## Why This Project Matters
This project demonstrates:
- Enterprise-level Flutter MVVM architecture
- Production-ready Firebase integration
- Feature-based scalable code structure
- Modern Riverpod state management
- Clean UI separation and reusable widgets
- Real-world authentication and error handling

---

## Author
Syed Munib
Flutter Developer | Mobile App Engineer
International Computer Science Graduate Student in the United States

GitHub: https://github.com/syedmunib616

LinkedIn: https://www.linkedin.com/in/thesyedmunib/

---

### License

This project is licensed under the MIT License.

---
### Support

If you like this project, please give it a star on GitHub.

---


