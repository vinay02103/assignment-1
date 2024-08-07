import mysql.connector
from mysql.connector import Error

def connect_to_db():
    try:
        connection = mysql.connector.connect(
            host='localhost',
            database='car_rental',
            user='your_username',
            password='your_password'
        )
        if connection.is_connected():
            print("Connected to the database")
            return connection
    except Error as e:
        print(f"Error: {e}")
        return None

def add_customer(connection, name, phone, customer_type):
    cursor = connection.cursor()
    query = "INSERT INTO CUSTOMER (Name, Phone, CustomerType) VALUES (%s, %s, %s)"
    values = (name, phone, customer_type)
    cursor.execute(query, values)
    connection.commit()
    print("Customer added successfully") 

def add_car(connection, model, year, car_type, category, daily_rate, weekly_rate, owner_id):
    cursor = connection.cursor()
    query = "INSERT INTO CAR (Model, Year, Type, Category, DailyRate, WeeklyRate, OwnerID) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    values = (model, year, car_type, category, daily_rate, weekly_rate, owner_id)
    cursor.execute(query, values)
    connection.commit()
    print("Car added successfully")

def add_rental(connection, vehicle_id, id_no, rental_type, start_date, return_date, amount_due, no_of_days, no_of_weeks):
    cursor = connection.cursor()
    query = "INSERT INTO RENTAL (VehicleID, IdNo, RentalType, StartDate, ReturnDate
