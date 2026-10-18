# 🗺️ Store Locator

A full-stack **Store Locator** mobile application built with **Flutter** and **Node.js/Express** backend, using **MongoDB** for data persistence.

Customers can search for items and discover nearby stores on a Google Map, while shop owners can register their stores and manage their product inventory.

---

## 📱 Screenshots

| Login | Customer Dashboard | Shop Dashboard |
|-------|-------------------|----------------|
| Gradient login screen | Full-screen map with search | Inventory management |

---

## 🏗️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Frontend** | Flutter (Dart) |
| **Backend** | Node.js, Express.js |
| **Database** | MongoDB (Mongoose) |
| **Maps** | Google Maps Flutter SDK |
| **Auth** | JWT (JSON Web Tokens), bcrypt |

---

## 📂 Project Structure

```
mobile-project-Store Locator/
├── backend/                    # Node.js REST API
│   ├── config/
│   │   └── db.js               # MongoDB connection
│   ├── controller/
│   │   ├── user.controller.js  # Auth (register/login)
│   │   ├── shop.controller.js  # Shop CRUD
│   │   ├── item.controller.js  # Item CRUD
│   │   └── customer.controller.js
│   ├── models/
│   │   ├── user.model.js
│   │   ├── shop.model.js
│   │   ├── item.model.js
│   │   └── customer.model.js
│   ├── routes/
│   │   ├── user.routes.js
│   │   ├── shop.route.js
│   │   ├── item.router.js
│   │   └── customer.router.js
│   ├── services/
│   │   ├── user.service.js
│   │   ├── shop.service.js
│   │   ├── item.service.js
│   │   └── customer.service.js
│   ├── app.js
│   ├── index.js
│   └── package.json
│
└── store_locator/              # Flutter mobile app
    └── lib/
        ├── main.dart           # App entry point & routing
        ├── config.dart         # API endpoint configuration
        ├── theme/
        │   └── app_theme.dart  # Design system (colors, typography, widgets)
        └── pages/
            ├── user.login.dart           # Login page
            ├── customer.signup.dart      # Customer registration
            ├── customer.dashboard.dart   # Map-based store search
            ├── shop.signup.dart          # Shop registration
            ├── shop.dashboard.dart       # Shop inventory management
            └── item.add.dart             # Add new item to shop
```

---

## 🔌 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/register` | Register a new user (customer/shop) |
| `POST` | `/login` | Authenticate user, returns JWT |
| `POST` | `/createShop` | Register a new shop |
| `POST` | `/createItem` | Add item to a shop's inventory |
| `POST` | `/createCustomer` | Register a customer profile |
| `GET`  | `/getItemsInshop?id=` | Get all items in a specific shop |
| `GET`  | `/getItemsWithName?name=` | Search items by name (for customers) |

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (≥ 3.1.5)
- [Node.js](https://nodejs.org/) (≥ 16)
- [MongoDB](https://www.mongodb.com/try/download/community) (running on `localhost:27017`)
- Google Maps API key (for the map features)

### 1. Backend Setup

```bash
cd backend
npm install
node index.js
```

The server starts on `http://localhost:3000`.

### 2. Flutter App Setup

```bash
cd store_locator
flutter pub get
flutter run
```

> **Note:** For Android emulator, the app auto-uses `10.0.2.2:3000` to reach the host machine. For web/iOS, it uses `localhost:3000`.

### 3. Google Maps API Key

Add your Google Maps API key in:
- **Android:** `store_locator/android/app/src/main/AndroidManifest.xml`
- **iOS:** `store_locator/ios/Runner/AppDelegate.swift`

---

## 🎨 Design System

The app uses a centralized design system in `lib/theme/app_theme.dart`:

- **Color palette:** Deep blue → Teal gradient (`#0D47A1` → `#00BFA5`)
- **Typography:** 7 predefined text styles
- **Components:** Gradient buttons, styled input fields, card decorations
- **Animations:** Fade + slide entrance transitions on all pages

---

## 👥 User Roles

### Customer
- Sign up and log in
- Search for items by name
- View store locations on Google Map

### Shop Owner
- Register a shop with details (name, location, hours, categories)
- Manage product inventory (add items with name, description, price)
- View items in the shop dashboard

---

## 📄 License

This project is for educational purposes.

---

## 👨‍💻 Author

**Danith** — [danithrandula@gmail.com](mailto:danithrandula@gmail.com)
