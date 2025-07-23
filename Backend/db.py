import mysql.connector
from config import db_conf

def get_db_connection():
    return mysql.connector.connect(**db_conf)
