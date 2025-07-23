from flask import Blueprint, request, jsonify
from db import get_db_connection
from utils import generate_custom_id

employee_bp = Blueprint('employee', __name__)

@employee_bp.route('/employee/add', methods=['POST'])
def add_employee():
    data = request.get_json()
    conn = get_db_connection()
    cursor = conn.cursor()

    emp_id = generate_custom_id('emp_')
    query = "INSERT INTO employee_list (employee_id, username, userid, job_title) VALUES (%s, %s, %s, %s)"
    cursor.execute(query, (
        emp_id,
        data['username'],
        data['userid'],
        data['job_title']
    ))

    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"status": "success", "employee_id": emp_id}), 201
