# 🏨 Hospitality Management System

A **full-stack hospitality management system** that supports hotel room booking, event management, restaurant reservations, employee management, and maintenance tracking. Built with a modular **Flask backend**, a **Flutter mobile app**, and a **React web frontend**.

---

## 📁 Project Structure

```plaintext
.
├── backend/
│   └── app.py               # Flask backend entry point
├── App/
│   └── paris/
│       └── lib/
│           └── main.dart    # Flutter mobile frontend
├── Frontend/
│   └── Hospitality-management-system/
│       └── src/
│           └── main.jsx     # React web frontend
└── README.md
```

---

## 🚀 Features

- 🛏️ Hotel room booking  
- 📅 Event management  
- 🍽️ Restaurant reservations  
- 🧹 Maintenance request tracking  
- 👨‍💼 Employee management  
- 📧 Email notifications (for bookings)  
- 📱 Flutter-based mobile app  
- 🖥️ React-based responsive web frontend  
- 🛠️ Modular backend with MySQL integration  

---

## 🧠 Tech Stack

| Layer       | Technology                        |
|-------------|-----------------------------------|
| Backend     | Python (Flask) + MySQL            |
| Mobile App  | Flutter (Dart)                    |
| Web App     | React (JSX)                       |
| Database    | MySQL                             |
| Others      | Flask-Mail, JWT (optional), REST API |

---

## 🛠️ Getting Started

### ✅ Backend Setup (Flask)

1. Navigate to `backend/`  
2. Create and activate a virtual environment  
3. Install dependencies:  
   ```bash
   pip install -r requirements.txt
   ```
4. Configure `.env` for DB credentials and email  
5. Run the server:  
   ```bash
   python app.py
   ```

### ✅ Mobile App Setup (Flutter)

1. Navigate to `App/paris/`  
2. Run on emulator/device:  
   ```bash
   flutter pub get
   flutter run
   ```

### ✅ Web Frontend Setup (React)

1. Navigate to `Frontend/Hospitality-management-system/`  
2. Install dependencies:  
   ```bash
   npm install
   ```
3. Start the development server:  
   ```bash
   npm start
   ```

---

## 🧩 Backend API Overview

All endpoints follow RESTful structure and are organized in separate route files:

- `/booking` – Book and manage rooms  
- `/event` – Manage event bookings  
- `/restaurant` – Handle restaurant reservations  
- `/employee` – Employee CRUD operations  
- `/maintenance` – Maintenance tracking  

➡️ **Example:** `POST /booking` – to book a hotel room

---

## 📬 Email Integration

- Uses **Flask-Mail** for sending booking confirmation emails  
- Ensure SMTP credentials are properly set in your `.env` file

---

## 🔒 Authentication (Optional)

- JWT-based authentication can be integrated for secured API access

---

## ✨ Demo Video & UI

🎬 [Watch the Demo Video](https://drive.google.com/file/d/1KQLeWcc61L0FReqLQfV-EMo8kZkSjmG3/view?usp=sharing)

---

## 🤝 Contributors

- **Aswin Asokan** – Full Stack Developer

---
