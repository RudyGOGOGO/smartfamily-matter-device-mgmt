import mysql.connector
from mysql.connector.pooling import MySQLConnectionPool


class MySQLConnector:
    _conn_pool: MySQLConnectionPool

    def __init__(self):
        db_config = {
            "host": "localhost",
            "user": "root",
            "password": "Wo2@Coding",
            "database": "dmt",
            "pool_name": "my_connection_pool",
            "pool_size": 5
        }
        self._conn_pool = mysql.connector.pooling.MySQLConnectionPool(**db_config)

    def execute(self, query: str):
        try:
            connection = self._conn_pool.get_connection()
            cursor = connection.cursor(dictionary=True)
            cursor.execute(query)
            result = cursor.fetchall()
            connection.commit()
            connection.close()
            return result
        except:
            return []

    def call_procedure(self, procedure_name: str):
        try:
            connection = self._conn_pool.get_connection()
            cursor = connection.cursor(dictionary=True)
            cursor.callproc(procedure_name)
            result = cursor.fetchall()
            connection.close()
            return result
        except:
            return []




