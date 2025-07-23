# SQL query templates and reusable query strings

GET_ALL_BOOKINGS = "SELECT * FROM room_bookings"
GET_ALL_EMPLOYEES = "SELECT * FROM employee_list"
GET_ALL_EVENTS = "SELECT * FROM event_bookings"
GET_ALL_MAINTENANCE = "SELECT * FROM maintenance_requests"
GET_ALL_RESERVATIONS = "SELECT * FROM restaurant_reservations"

GET_EMPLOYEE_BY_JOB = "SELECT * FROM employee_list WHERE job_title = %s"
GET_ROOM_AVAILABILITY = "SELECT * FROM room_bookings WHERE checkin <= %s AND checkout >= %s"
