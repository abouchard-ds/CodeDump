import cx_Oracle

mydsn = cx_Oracle.makedsn(host='scan_name', port='1521', service_name='ORCL')
connection = cx_Oracle.Connection(user='username', password='password', dsn=mydsn)
cursor = connection.cursor()

query = "SELECT * from dba_users"

cursor.execute(query)
data = cursor.fetchall()

# always clean up!
cursor.close()
connection.close()

print(data)
