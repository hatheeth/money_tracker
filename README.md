<<<<<<< HEAD
# money_tracker

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
=======
# 💸 Expense Monitoring App

A sleek, cross-platform expense tracking application built with **Flutter**. This app helps users effortlessly log, categorize, and monitor their daily spending with a robust **offline-first** architecture.

## ✨ Key Features

- **Secure Authentication:** Quick and secure sign-in using **Google Authentication**.
- **Offline-First Design:** Add and view expenses without an internet connection using **SQLite** local storage.
- **Cloud Synchronization:** Seamless background syncing of local data to **Firebase Firestore** when online.
- **Expense Management:** Easily add, edit, and delete transactions with custom categories.
- **Dashboard & Insights:** Visualize spending habits with a clean, intuitive UI.

## 🛠️ Tech Stack

- **Frontend:** Flutter (Dart)
- **Authentication:** Firebase Auth (Google Sign-In)
- **Cloud Database:** Firebase Firestore
- **Local Database:** SQLite (`sqflite`)
- **State Management:** Provider / Riverpod *(Update based on what you used)*

## ️ Architecture: Offline-First Approach

To ensure a seamless user experience, this app utilizes a dual-database strategy:
1. **SQLite** acts as the single source of truth for the UI, ensuring lightning-fast read/writes and full offline capability.
2. **Firebase Firestore** handles cloud backups and multi-device synchronization, pushing and pulling data in the background.

## 📱 Screenshots

| Home Dashboard | Add Expense | History |
| :---: | :---: | :---: |
| *[Insert Image]* | *[Insert Image]* | *[Insert Image]* |

## ⚙️ Setup and Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/your-repo-name.git
   cd your-repo-name
>>>>>>> d5b578eda83e74964808f2c6b08b7187f058278f
