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

🚀 Features
  🛏️ Hotel room booking
  
  📅 Event management
  
  🍽️ Restaurant reservations
  
  🧹 Maintenance request tracking
  
  👨‍💼 Employee management
  
  📧 Email notifications (for bookings)
  
  📱 Flutter-based mobile app
  
  🖥️ React-based responsive web frontend
  
  🛠️ Modular backend with MySQL integration

🧠 Tech Stack
  Layer	Technology
  Backend	Python (Flask) + MySQL
  Mobile App	Flutter (Dart)
  Web App	React (JSX)
  Database	MySQL
  Others	Flask-Mail, JWT (optional), REST API architecture

🛠️ Getting Started
✅ Backend Setup (Flask)
  1.Navigate to backend/
  2.Create a virtual environment and activate it
  3.Install dependencies:
  4.Configure .env for DB credentials and email
  5. Run the server:
  ```bash
  python app.py

✅ Mobile App Setup (Flutter)
  1.Navigate to App/paris/
  2.Run on emulator/device:
  
    ```bash
  flutter pub get
  flutter run


✅ Web Frontend Setup (React)
  1.Navigate to Frontend/Hospitality-management-system/
  2.Install dependencies:
  ```bash
  npm install
  ```
  Start the development server:
  
  ```bash
  npm start
  ```


🧩 Backend API Overview
All endpoints are RESTful and organized under route files like:

/booking
/event
/restaurant
/employee
/maintenance
Example: POST /booking to book a room

📬 Email Integration
Flask-Mail is used to send booking confirmations

Ensure SMTP credentials are set in your environment

🔒 Authentication
You can integrate JWT-based authentication for secured APIs

✨ Demo Video & UI 
[Watch the Demo Video](https://drive.google.com/file/d/1KQLeWcc61L0FReqLQfV-EMo8kZkSjmG3/view?usp=sharing)

🤝 Contributors
Aswin Asokan – Full Stack Developer
