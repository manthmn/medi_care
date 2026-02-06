## MediCare – Offline‑First Pharmacy (Flutter)

MediCare is an offline‑first pharmacy / e‑commerce sample built for an SDE‑2 Flutter assignment. It focuses on clean architecture, robust offline behaviour, and predictable state management rather than on UI gimmicks.

### Architecture

- **Clean 3‑layer structure**
  - `core` – cross‑cutting concerns (`Failure`, connectivity, network info).
  - `features/products` – product listing, search, and detail entities, use cases, repositories, blocs, and UI.
  - `features/cart` – cart persistence, cart domain models, use cases, bloc, and UI.
  - `shared/data/local` – Drift database (`ProductsTable`, `CartTable`, `MetadataTable`) shared across features.
- **State management**
  - Uses **Bloc / Cubit** (`ProductBloc`, `CartBloc`, `ConnectivityCubit`).
  - Bloc is chosen for **predictable state transitions**, great tooling (`BlocObserver`, logging), and scalability when flows grow (sync, retries, pagination).
- **Dependency injection**
  - `get_it` in `injector.dart` wires up Dio, Drift database, repositories, and blocs.

### Offline‑first strategy

- **REMOTE → CACHE → UI fallback**
  - When online, `ProductRepositoryImpl` fetches from FakeStore API via Dio, maps to `ProductModel`, and upserts into Drift using `insertOnConflictUpdate`.
  - On any remote failure, repositories transparently fall back to the cached Drift data.
  - When offline, UI reads from Drift immediately; if the app has never synced before, a **first‑launch offline screen** explains that an initial connection is required.
- **Drift schema**
  - `ProductsTable` – id, title, price, description, image, rating, updatedAt.
  - `CartTable` – id (PK), productId, quantity.
  - `MetadataTable` – generic key/value store, currently used for `products_last_synced`.
- **Sync metadata**
  - `ProductLocalDataSource` stores `last_synced` ISO string in `MetadataTable`.
  - `ConnectivityCubit` exposes `online/offline` and the UI shows an orange offline banner.

### State management & UX

- **Product flow**
  - `ProductBloc` exposes `ProductState` with explicit states: `loading`, `success`, `empty`, `error`, `firstLaunchOffline`.
  - Debounced search (`SearchProducts` use case) keeps the API usage minimal and offers snappy UX.
  - Skeleton loaders (via `shimmer`) give immediate perceived feedback during loading.
- **Cart flow**
  - `CartBloc` keeps cart state in Drift via `CartRepository`.
  - Cart items survive app restarts as they are stored only in the local DB.
  - Total price, quantity steppers, and item removal are all handled via bloc events so the UI is dumb and easily testable.

### Folder structure (high‑level)

- `lib/core`
  - `error/failures.dart`
  - `network/network_info.dart`
  - `network/connectivity_cubit.dart`
- `lib/shared`
  - `data/local/app_database.dart` (Drift database)
- `lib/features/products`
  - `domain/entities/product.dart`
  - `domain/repositories/product_repository.dart`
  - `domain/usecases/get_products.dart`, `search_products.dart`
  - `data/datasources/product_remote_data_source.dart`, `product_local_data_source.dart`
  - `data/models/product_model.dart`
  - `data/repositories/product_repository_impl.dart`
  - `presentation/bloc/product_bloc.dart`
  - `presentation/screens/product_list_screen.dart`
  - `presentation/widgets/product_quantity_stepper.dart`
- `lib/features/cart`
  - `domain/entities/cart_item.dart`
  - `domain/repositories/cart_repository.dart`
  - `domain/usecases/cart_usecases.dart`
  - `data/datasources/cart_local_data_source.dart`
  - `data/repositories/cart_repository_impl.dart`
  - `presentation/bloc/cart_bloc.dart`
  - `presentation/screens/cart_screen.dart`
- `lib/injector.dart`
- `lib/main.dart`

### Trade‑offs & notes

- **FakeStore API** is read‑only; cart operations are intentionally local‑only, which mirrors a common “client‑side basket, server‑side order” production pattern.
!- Pagination is not implemented end‑to‑end but the product repository and bloc are structured to support it by converting list loads into page requests.
- To keep the assignment focused, the product detail screen is minimal and only wired from the list; in a real app it would reuse the product entity and potentially fetch richer detail.

### Running the app

1. **Install dependencies**
   ```bash
   flutter pub get
   ```
2. **Generate Drift code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
3. **Run on device / emulator**
   ```bash
   flutter run
   ```

### Testing (extensible)

- Repositories and use cases are defined behind interfaces (`ProductRepository`, `CartRepository`), which makes them easily mockable with `mocktail`.
- Example tests you can add quickly:
  - `ProductRepositoryImpl` happy‑path and offline fallback using a fake `NetworkInfo`.
  - `ProductBloc` transition from `loading` → `success` and `loading` → `firstLaunchOffline`.

# med_sync

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
