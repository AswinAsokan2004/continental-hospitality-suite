from flask import Flask
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# Register Blueprints
from routes.auth_routes import auth_bp
from routes.booking_routes import booking_bp
from routes.event_routes import event_bp
from routes.restaurant_routes import restaurant_bp
from routes.maintenance_routes import maintenance_bp
from routes.employee_routes import employee_bp

app.register_blueprint(auth_bp)
app.register_blueprint(booking_bp)
app.register_blueprint(event_bp)
app.register_blueprint(restaurant_bp)
app.register_blueprint(maintenance_bp)
app.register_blueprint(employee_bp)

if __name__ == "__main__":
    app.run(debug=True)
