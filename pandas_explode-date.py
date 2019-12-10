# take date variables and split into different time indicators

def addDateColumns(dataframe):
    
    dataframe['reported_Year'] = dataframe['INC_REPORTDATE'].dt.year
    dataframe['reported_Month'] = dataframe['INC_REPORTDATE'].dt.month
    dataframe['reported_Week'] = dataframe['INC_REPORTDATE'].dt.week  
    dataframe['reported_Weekday'] = dataframe['INC_REPORTDATE'].dt.dayofweek + 1  #default = The day of the week with Monday=0, Sunday=6
    dataframe['reported_WeekdayName'] = dataframe['INC_REPORTDATE'].dt.weekday_name
    dataframe['reported_DayMonth'] = dataframe['INC_REPORTDATE'].dt.day
    dataframe['reported_DayYear'] = dataframe['INC_REPORTDATE'].dt.dayofyear
    dataframe['reported_Hour'] = dataframe['INC_REPORTDATE'].dt.hour
    
    dataframe['finished_Year'] = dataframe['INC_ACTUALFINISH'].dt.year
    dataframe['finished_Month'] = dataframe['INC_ACTUALFINISH'].dt.month
    dataframe['finished_Week'] = dataframe['INC_ACTUALFINISH'].dt.week  
    dataframe['finished_Weekday'] = dataframe['INC_ACTUALFINISH'].dt.dayofweek + 1  #default = The day of the week with Monday=0, Sunday=6
    dataframe['finished_WeekdayName'] = dataframe['INC_ACTUALFINISH'].dt.weekday_name
    dataframe['finished_DayMonth'] = dataframe['INC_ACTUALFINISH'].dt.day
    dataframe['finished_DayYear'] = dataframe['INC_ACTUALFINISH'].dt.dayofyear
    dataframe['finished_Hour'] = dataframe['INC_ACTUALFINISH'].dt.hour

    return dataframe
