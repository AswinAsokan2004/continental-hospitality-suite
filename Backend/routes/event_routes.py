from flask import Blueprint, request, jsonify
from db import get_db_connection
from utils import generate_custom_id

event_bp = Blueprint('event', __name__)

@event_bp.route('/event', methods=['POST'])
def create_event():
    data = request.get_json()
    conn = get_db_connection()
    cursor = conn.cursor()

    event_id = generate_custom_id('evt_')
    query = "INSERT INTO event_bookings (event_id, event_name, organizer, date, time, guests) VALUES (%s, %s, %s, %s, %s, %s)"
    cursor.execute(query, (
        event_id,
        data['event_name'],
        data['organizer'],
        data['date'],
        data['time'],
        data['guests']
    ))

    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"status": "success", "event_id": event_id}), 201
