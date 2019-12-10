#PERSON     GRADES
#    A          70
#    A          23
#    A          67
#    B          08
#    B          06
#    B          88
#    B          09
#    C          40
#    D          87
#    D          11

df.groupby('PERSON').GRADES.apply(list).to_dict()

# you get 
# {'A':[70,23,67], 
#  'B':[08,06,88,09], 
#  'C':[40],
#  'D':[87,11]
# }
