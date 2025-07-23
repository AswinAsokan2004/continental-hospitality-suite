from flask import Blueprint, request, jsonify
from db import get_db_connection
from utils import generate_custom_id

restaurant_bp = Blueprint('restaurant', __name__)

@restaurant_bp.route('/restaurant/reserve', methods=['POST'])
def reserve_table():
    data = request.get_json()
    conn = get_db_connection()
    cursor = conn.cursor()

    res_id = generate_custom_id('rest_')
    query = "INSERT INTO restaurant_reservations (reservation_id, customer_name, date, time, table_count) VALUES (%s, %s, %s, %s, %s)"
    cursor.execute(query, (
        res_id,
        data['customer_name'],
        data['date'],
        data['time'],
        data['table_count']
    ))

    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"status": "success", "reservation_id": res_id}), 201
