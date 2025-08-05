# Nexa

A modern, intuitive Flutter e-commerce application that follows **feature-first Clean Architecture** and uses **GetX** for state-management & navigation.

---

## ✨ Features
- **Product List** – grid view with real-time search and shimmer loaders  
- **Product Details** – rating, category chip, description, image carousel  
- **Cart** – quantity controls, badge indicator, summary bar  
- **Favorites** – toggle “like” locally  
- **Responsive UI** – mobile & tablet (ScreenUtil + MediaQuery)  
- **Modern Design** – Material 3, custom theming  
- **Error / Loading States** – graceful UX & retry option

> Data is fetched from the public [Fake Store API](https://fakestoreapi.com).

---

## 🏗️ Project Structure
lib/
├── core/ # shared, feature-agnostic code
│ ├── constants/ # colors, strings, text styles
│ ├── network/ # ApiService (HTTP)
│ ├── utils/ # responsive helpers
│ └── widgets/ # reusable UI (loading, error, app bar…)
├── features/ # feature-first folders
│ ├── product_list/
│ │ ├── data/ # models, repositories
│ │ └── presentation/ # bindings, controllers, screens, widgets
│ ├── product_detail/ # ← same split
│ └── cart/ # ← same split
├── routes/ # GetX route names & pages
└── main.dart # app entry

---

## 🚀 Quick Start

1. **Clone & install**
git clone https://github.com/aaryanraj25/nexa.git
cd nexa
flutter pub get


2. **Run**
flutter run # choose a device or emulator


3. **Build release**
flutter build apk # Android
flutter build ios # iOS (macOS only)


## 🔧 Tech Stack

| Purpose                | Package                |
|------------------------|------------------------|
| State / DI / Routing   | get: ^4.6.6            |
| HTTP requests          | http: ^1.1.0           |
| Responsive sizing      | flutter_screenutil     |
| Cached images          | cached_network_image   |
| Loading shimmer        | shimmer                |
| Rating stars           | flutter_rating_bar     |


## 🛣️ Roadmap
- Persist favorites & cart with local storage
- User authentication
- Checkout & payments
- Dark mode
- Offline caching
