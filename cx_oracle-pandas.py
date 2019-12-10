import cx_Oracle
import pandas as pd
from pandas import ExcelWriter

mydsn = cx_Oracle.makedsn(host='scan_name', port='1521', service_name='ORCL')
connection = cx_Oracle.Connection(user='username', password='password', dsn=mydsn)

query = "SELECT * from dba_users"

dataframe = pd.read_sql(query, con=connection)
connection.close()

writer = ExcelWriter('Report.xlsx')
dataframe.to_excel(writer,'Sheet1',index=False)
writer.save()
