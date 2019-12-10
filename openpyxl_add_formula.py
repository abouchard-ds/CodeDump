# open an excel file, add formulas at the last column, save the excel file.

def addExcelFormulas(excelFile):

    wb = openpyxl.load_workbook(excelFile)
    ws_data = wb['data']

    ws_data.sheet_properties.tabColor = "1072BA"

    dateFormulas = {
                    'reported_YEAR':'=YEAR(J2)',
                    'reported_MONTH':'=MONTH(J2)', 
                    'reported_WEEKNUM':'=WEEKNUM(J2)' ,
                    'reported_WEEKDAY':'=WEEKDAY(J2)',
                    'reported_DAY':'=DAY(J2)',
                    'reported_HOUR':'=HOUR(J2)',
                    'finished_YEAR':'=YEAR(M2)',
                    'finished_MONTH':'=MONTH(M2)', 
                    'finished_WEEKNUM':'=WEEKNUM(M2)' ,
                    'finished_WEEKDAY':'=WEEKDAY(M2)',
                    'finished_DAY':'=DAY(M2)',
                    'finished_HOUR':'=HOUR(M2)',
                    'is_CLOSEDONTIME':'=IF(OR(M2<=N2, ISBLANK(N2), M2<=O2), TRUE, FALSE)'
                    }

    # la loop ajoute toutes les formules du dict sequentiellement en ajoutant une colonne pour chaque.
    for key,formula in dateFormulas.items():
        # select last col second row from ws_data
        mycol = ws_data.max_column + 1
        # insert formula
        ws_data.cell(row=1, column = mycol).value = key
        ws_data.cell(row=2, column = mycol).value = formula
        # apply to column

    wb.save(excelFile)
