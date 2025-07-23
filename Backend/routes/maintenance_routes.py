from flask import Blueprint, request, jsonify
from db import get_db_connection
from utils import generate_custom_id

maintenance_bp = Blueprint('maintenance', __name__)

@maintenance_bp.route('/maintenance/request', methods=['POST'])
def raise_maintenance_request():
    data = request.get_json()
    conn = get_db_connection()
    cursor = conn.cursor()

    req_id = generate_custom_id('mnt_')
    query = "INSERT INTO maintenance_requests (request_id, room_no, issue_description, priority) VALUES (%s, %s, %s, %s)"
    cursor.execute(query, (
        req_id,
        data['room_no'],
        data['issue_description'],
        data['priority']
    ))

    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"status": "success", "request_id": req_id}), 201
