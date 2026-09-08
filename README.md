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
