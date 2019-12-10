import cx_Oracle
import pandas as pd

mydsn = cx_Oracle.makedsn(host='scan_name', port='1521', service_name='ORCL')
connection = cx_Oracle.Connection(user='username', password='password', dsn=mydsn)

query = "SELECT * from dba_users"

def getData(connection, query):
  cursor = connection.cursor()
  try:
    dataframe = pd.read_sql(query, con=connection)
    return dataframe
  finally:
    if cursor is not None:
      cursor.close()

connection.close()

x = getData(connection, query)
print(x)
