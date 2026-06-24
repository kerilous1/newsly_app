# 📰 Newsly. — Premium Global News Hub

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Clean Architecture](https://img.shields.io/badge/Clean%20Architecture-2b2d42?style=for-the-badge)
![Hive DB](https://img.shields.io/badge/Hive_NoSQL-FF9900?style=for-the-badge)

A sophisticated, production-grade mobile application built with **Flutter**. Engineered with a strict adherence to **Clean Architecture**, **SOLID principles**, and **predictable micro-state management** utilizing the BLoC/Cubit pattern.

---

## 🎥 Application Walkthrough & Test Demo

Click the badge below to watch the live integration test, demonstrating reactive Cubit state transitions, pagination deep-fetching, instant offline bookmarking, and native web-view rendering:

[![Watch the Demo](https://img.shields.io/badge/Watch%20Video%20Demo-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](YOUR_VIDEO_URL_HERE)

> 💡 **Note for Reviewers:** *The demo highlights how the UI completely avoids "Pixel Overflow" drops and showcases the instant reactive memory sync between the Home Feed and the Hive Local Storage.*

---

## ✨ Key Features

* **Premium Minimalist UI (Dark Theme):** Built entirely using custom structural `Containers` to achieve absolute pixel-perfect control, explicitly avoiding the rigid constraints of standard framework `Cards`.
* **Breaking News Carousel:** An automated horizontal momentum-scrolling feed highlighting the top 5 trending global headlines.
* **Deep Category Filtration:** Dedicated news channels (*Business, Technology, Sports, Science, Health, Entertainment*) with customized API page sizing fetching up to 100 deep records per load.
* **Offline Persistence (Bookmarks):** Powered by **Hive NoSQL DB**. Users can bookmark articles instantly; the UI reacts locally with zero network latency.
* **Global Search Terminal:** Connects directly to the `v2/everything` endpoint, allowing users to parse global topics and keywords dynamically.
* **In-App Browser (WebView):** Lets users read complete source publisher articles natively inside the app without bouncing out to external browsers.
* **System-Native Sharing:** Deeply integrated with iOS/Android share sheets to broadcast news links instantly.

---

## 🏛️ Clean Architecture & Tech Stack

The project follows a strict **Feature-First Clean Architecture** approach, ensuring completely decoupled layers and zero UI-to-Data contamination:

```text
lib/
├── main_layout/      # Cubit-persisted Bottom Navigation scaffolding
├── core/                 # Service Locators (GetIt), Global Themes, API Constants
└── features/
    ├── splash/           # Premium animated entry point
    ├── main_layout/      # Cubit-persisted Bottom Navigation scaffolding
    ├── news/             # Domain contracts + Remote Data (Dio) + Presentation
    ├── bookmarks/        # Hive DB implementation + Saved Feed UI
    └── search/           # Dynamic live search terminal
