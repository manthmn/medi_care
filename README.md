# MediCare – Offline-First e-commerce App

MediCare is a high-performance, offline-first e-commerce application built with Flutter. Designed with **Clean Architecture** and **SOLID principles**, it provides a seamless user experience regardless of internet connectivity.

## 🚀 What I Have Built
- **Product Ecosystem**: Comprehensive listing with real-time search and detailed product views.
- **Offline-First Engine**: Intelligent data synchronization that caches remote data locally for instant access.
- **Smart Cart Management**: A persistent shopping basket that survives app restarts, featuring quantity controls and total price calculation.
- **Multi-lingual Support**: Full localization support for English and Hindi.
- **Dynamic UX**: Skeleton loaders (shimmer), connectivity banners, and graceful error/empty state handling.

---

## 🛠️ Project Setup & How to Run

### Prerequisites
- Flutter SDK (>=3.3.0)
- Android Studio / VS Code with Flutter extension
- Xcode (for iOS development)

### Step-by-Step Installation
1. **Clone the repository**
2. **Install dependencies**
   ```bash
   flutter pub get
   ```
3. **Generate required code**
   This project uses `drift` and `freezed` for code generation. Run the builder:
   ```bash
   # Run once
   dart run build_runner build --delete-conflicting-outputs
   
   # Or keep it running in the background
   dart run build_runner watch --delete-conflicting-outputs
   ```
4. **Run the application**
   ```bash
   # Detect and run on available device
   flutter run
   ```

### Platform Specifics
- **Android**: Ensure you have an emulator or physical device with API 21+.
- **iOS**: Run `pod install` in the `ios` directory before running if you've added new native-linked plugins.

---

## 🏗️ Architecture & Patterns

### Clean Architecture
The project follows a strict 3-layer architecture to ensure separation of concerns:
- **Presentation**: UI widgets, Blocs, and Cubits that handle user interaction and state display.
- **Domain**: Pure Dart logic containing Entities, Repository interfaces, and Use Cases (The "Brain" of the app).
- **Data**: Implementation of repositories, Data Sources (Remote/Local), and Models (JSON mapping).

### Key Principles Followed
- **SOLID**: Each class has a single responsibility. We use dependency inversion by depending on interfaces rather than implementations.
- **Repository Pattern**: Centralized data access logic that chooses between local cache and remote API.
- **Dependency Injection**: Powered by `get_it`. All components are wired in `lib/injector.dart`, making the codebase decoupled and testable.
- **BloC State Management**: Used for predictable state transitions and unidirectional data flow.

---

## 📡 Technical Functionality

### 📶 Offline-First Strategy
- **Caching**: Uses **Drift (SQLite)** for high-performance local persistence.
- **Fallback Logic**: When the network is unavailable, the repository automatically serves data from the local database.
- **Sync Metadata**: Tracks `last_synced` timestamps to inform users of data freshness.
- **Connectivity Awareness**: A dedicated `ConnectivityCubit` listens to network changes and triggers UI updates (like the offline banner).

### 🌍 Localization
- Supports **English (en)** and **Hindi (hi)**.
- Implemented using Flutter's official `l10n` tool with `.arb` files for easy translation management.

### 🛡️ Error & Edge Case Handling
- **Empty States**: Custom illustrations and messages for empty carts or search results.
- **Error Handling**: Uses `Dartz` for functional error handling (Either `Failure` or `Success`), avoiding unexpected crashes.
- **Shimmer Effects**: Provides visual feedback during data fetching to reduce perceived latency.
- **First Launch**: Special handling for users opening the app for the first time without internet.

---

## 📦 Package Catalog

| Category | Package | Why we use it? |
| :--- | :--- | :--- |
| **State Management** | `flutter_bloc` | Unidirectional data flow and clear separation of logic. |
| **Storage** | `drift` | A powerful, reactive SQLite library for complex offline data. |
| **Networking** | `dio` | Better interceptors and robust configuration over the default HTTP client. |
| **Dependency Injection** | `get_it` | Faster and lighter than manual DI for wiring up the app. |
| **Functional Programming** | `dartz` | For robust error handling using the `Either` type. |
| **UI Enhancements** | `cached_network_image` | Automatically handles image caching for offline viewing. |
| **Code Generation** | `freezed` & `json_serializable` | Eliminates boilerplate for models and state classes. |
| **Testing** | `bloc_test` & `mocktail` | Ensures business logic is verified with high confidence. |

---

## ⚖️ Architectural Trade-offs
- **Local-Only Cart**: As the FakeStore API is read-only, cart persistence is implemented entirely client-side. This mirrors a real-world scenario where a guest basket is managed locally before conversion to an order.
- **Drift vs. Sqflite**: Chose **Drift** despite a slightly higher setup cost because its reactive streams allow the UI to update automatically whenever the underlying database changes (e.g., adding to cart from different screens).
- **First-Launch Sync**: The app requires a one-time initial connection to fetch the product catalog. This trade-off was made to ensure the user has a rich experience even during their first offline session after setup.

---

## 🧪 Testing Strategy
- **Unit Tests**: Coverage for Use Cases and Repositories.
- **Bloc Tests**: Verifying state transitions for every user action.
- **Mocking**: Using `mocktail` to isolate dependencies and test complex scenarios like network failures.

---

## 📸 Screenshots & Demo
*Add your screenshots or video links here*

| Product List | Detailed View | Cart Page |
| :---: | :---: | :---: |
| ![List](https://via.placeholder.com/200x400?text=Product+List) | ![Details](https://via.placeholder.com/200x400?text=Details) | ![Cart](https://via.placeholder.com/200x400?text=Cart) |

---
