# -*- coding: utf-8 -*-
"""
@author: yes
"""

'''
Loop across a list of database and execute a list of queries.
Output can be displayed, sent to Excel or CSV or stored in another database.
eg.: you could create a configuration software for database with this ...
'''

# validation et importation des librairies en batch
named_libs = [('datetime', 'dt'),('logging', 'log'),('json', 'json'), ('cx_Oracle', 'cx_Oracle'), ('pandas', 'pd')]

for (name, short) in named_libs:
    try:
        lib = __import__(name)
    except:
        print(sys.exc_info())
    else:
        globals()[short] = lib

try: 
    from pandas import ExcelWriter
except ImportError:
    print('SubModule ExcelWriter is needed for this script to work.')
    exit()    


# methodes, fonctions
def importConfig(filename):
    with open(filename) as cfFile:
        json_data = json.loads(cfFile.read())
    return json_data

def getData(query, myconnection):
    dataframe = pd.read_sql(query, con=myconnection)
    return dataframe

def addSource(dataframe, dbsource):
    # ajouter instance name et date aux donnees
    dataframe['source'] = dbsource
    dataframe['timestamp'] = justnowfull
    return dataframe

def toExcel(dataframe, filename):
    writer = ExcelWriter(filename)
    dataframe.to_excel(writer,'Donnees', index=False)
    writer.save()

if __name__ == "__main__":
    # load les configs
    dbDict = importConfig('databases.json')
    queryDict = importConfig('queries.json')
    
    # pour chaque de databases.json
    for db, conf in dbDict.items():

        mydsn = cx_Oracle.makedsn(host=conf[0],port=conf[1],service_name=conf[2])
        try:
            myconnection = cx_Oracle.Connection(user=conf[3],password=conf[4],dsn=mydsn,mode=cx_Oracle.SYSDBA) 
        except cx_Oracle.DatabaseError as e:
            print(e)
            continue

        # roule tous les queries de queries.json
        for key, val in queryDict.items():
           df = getData(val, myconnection)
           dfS = addSource(df, conf[2])
           toExcel(dfS, str(conf[2] + '_' + justnowshort + '.xlsx'))
           print(dfS)
           
myconnection.close()
