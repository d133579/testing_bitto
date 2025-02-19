# BitoFX Test

This is a test project for BitoFX built using Flutter.

## Tech Stack

1. **Architecture**: BLoC  
2. **Network**: `http`  
3. **Functional Programming**: `dartz`  
4. **Image Caching**: `cached_network_image`

## Overview

This project utilizes clean architecture to separate business logic from presentation, ensuring that each layer can be developed and tested independently. By using the BLoC pattern, the state management is streamlined and the UI reacts efficiently to state changes.

## Key Features

- **Clean Architecture**: Decouples data handling from UI, facilitating easier testing and maintenance.
- **BLoC Pattern**: Implements robust state management.
- **HTTP Networking**: Handles network requests with the `http` package.
- **Functional Programming**: Utilizes `dartz` to promote immutable data structures and functional paradigms.
- **Image Caching**: Improves performance with `cached_network_image` for efficient image caching.


## Folder Structure
```
lib/
├── core/
│   └── error/
│       └── api_failure.dart
├── data/
│   ├── data_sources/
│   │   └── currency_api_client.dart
│   ├── models/
│   │   └── currency_model.dart
│   └── repositories/
│       └── currency_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── currency.dart
│   ├── repositories/
│   │   └── currency_repository.dart
│   └── use_cases/
│       └── get_currency_pairs.dart
├── presentation/
│   ├── cubit/
│   │   └── currency_cubit.dart
│   └── screens/
│       ├── currency_exchange_rate_screen.dart
│       ├── currency_selection_page.dart
│       └── rate_conversion_screen.dart
└── main.dart

test/
├── data/
│   ├── data_sources/
│   │   └── currency_api_client_test.dart
│   ├── models/
│   │   └── currency_model_test.dart
│   └── repositories/
│       └── currency_repository_impl_test.dart
├── domain/
│   └── use_cases/
│       └── get_currency_pairs_test.dart
├── presentation/
│   └── cubit/
│       └── currency_cubit_test.dart
└── widget_test.dart
```
