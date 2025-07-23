from flask import Blueprint, request, jsonify
from db import get_db_connection
from utils import generate_custom_id
from mailer import send_booking_email

booking_bp = Blueprint('booking', __name__)

@booking_bp.route('/booking', methods=['POST'])
def book_room():
    data = request.get_json()
    conn = get_db_connection()
    cursor = conn.cursor()

    booking_id = generate_custom_id('book_')
    insert_query = """INSERT INTO room_bookings (booking_id, customer_name, gmail_id, checkin, checkout, room_type, no_of_adults, no_of_children, amount, date, time)
                      VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"""
    cursor.execute(insert_query, (
        booking_id,
        data['customer_name'],
        data['gmail_id'],
        data['checkin'],
        data['checkout'],
        data['room_type'],
        data['no_of_adults'],
        data['no_of_children'],
        data['amount'],
        data['date'],
        data['time']
    ))

    conn.commit()
    cursor.close()
    conn.close()

    data['booking_id'] = booking_id
    send_booking_email(data)

    return jsonify({"status": "success", "booking_id": booking_id}), 201
