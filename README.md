# Newsly :

A sophisticated, responsive, and cleanly architected global news aggregator built with Flutter. The app provides a seamless user experience for exploring live world updates, combining robust Clean Architecture with predictable Cubit state management.

🎥 App Demo
---

🔗 **Video Demo**

*(Drag and drop your newsly_demo.mp4 file directly here in GitHub web editor)*


✨ Key Features
---

* **Minimalist UI:** Clean, distraction-free Dark Theme built using precision Custom Containers over standard Cards for absolute layout control.
* **Clean Architecture:** Strictly decoupled into Domain, Data, and Presentation layers for a highly testable, modular, and maintainable codebase.
* **Reactive State Management:** Fully powered by `flutter_bloc` (Cubit) to handle instant UI updates across the breaking news carousel and category feeds.
* **Offline Persistence:** Instant article bookmarking saved locally via **Hive NoSQL DB**, allowing offline reading with zero network latency.
* **Dynamic Discovery:** Integrated live search terminal connected to the 'everything' API endpoint to fetch user-driven topics on the fly.
* **System-Native Sharing:** Deeply integrated with native mobile share sheets to broadcast article links across social apps.


📁 Project Structure
---

The project follows a strict feature-driven Clean Architecture to separate the logic layers from the presentation layer:

```text
lib/
├── core/
│   ├── network/          # Dio REST client & NewsAPI configuration
│   ├── theme/            # Centralized Dark palette & App typography
│   ├── utils/            # GetIt Service Locator setup
│   └── widgets/          # Shared Custom Bottom Navigation Bar
├── features/
│   ├── bookmarks/        # Hive local storage repo + Saved feed UI
│   ├── news/             # Clean Arch (Domain/Data/Presentation) + Home UI
│   └── search/           # Standalone live search terminal UI
└── main_layout/          # Main App wrapper & navigation handler
    ├── main.dart         # Entry point & Hive DB Box initialization
    └── splash_screen.dart# Premium minimalist animated entry view
