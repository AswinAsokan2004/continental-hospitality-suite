from flask import Blueprint, request, jsonify
from db import get_db_connection

auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    user_id = data['user_id']
    password = data['password']

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    query = """SELECT e.username, e.userid, e.job_title, j.category 
               FROM employee_list e 
               JOIN job_tag j ON e.job_title = j.job_title 
               WHERE e.username = %s AND e.userid = %s"""
    cursor.execute(query, (user_id, password))
    result = cursor.fetchone()

    response = {
        "status": "valid" if result else "invalid",
        "data": result if result else {}
    }

    cursor.close()
    conn.close()
    return jsonify(response), 200
