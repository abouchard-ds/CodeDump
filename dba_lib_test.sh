#!/bin/bash -

# Loader la librairie de fonctions
source /u01/app/oracle/admin/scripts/lib/dba.lib

echo ""
echo "------===------===------===------===------===------===------===------===------===------===------"
echo ""
echo "TESTING function is_ROOT() "
if is_ROOT; then
	echo "User is root"
else
	echo "User is not root"
fi
echo ""
echo "------===------===------===------===------===------===------===------===------===------===------"
echo ""
echo "SCENARIO 1 - User is oracle"
if is_USER "oracle"; then
		echo "User exists"
	else
		echo "User does not exists"
fi

echo "SCENARIO 2 - User is kualalumpur"
if is_USER "kualalumpur"; then
		echo "User exists"
	else
		echo "User does not exists"
fi
echo ""
echo "------===------===------===------===------===------===------===------===------===------===------"
echo ""
echo "SCENARIO 1 - Param is : 213"
if is_NUMBER 213; then
		echo "213 is not a number"
	else
		echo "213 is a number"
fi

echo "SCENARIO 2 - Param is : sadf73"
if is_NUMBER sadf73; then
		echo "sadf73 is not a number"
	else
		echo "sadf73 is a number"
fi
echo ""
echo "------===------===------===------===------===------===------===------===------===------===------"
echo ""
echo "SCENARIO 1 - Command is : bash"
if is_AVAIL "bash"; then
		echo "bash is available"
	else
		echo "bash is not available"
fi
echo "SCENARIO 2 - Command is : helmut"
if is_AVAIL "helmut"; then
		echo "helmut is available"
	else
		echo "helmut is not available"
fi
echo ""
echo "------===------===------===------===------===------===------===------===------===------===------"
echo ""
if is_RAC; then
	echo "This is a Single Instance"
else
	echo "This is a Real Application Cluster"
fi
echo ""
echo "------===------===------===------===------===------===------===------===------===------===------"
echo ""
echo "Contenu du retour de la fonction pure:"
echo $(list_INST_NAME)
echo "-------------------------------------------------------"
echo ""
echo "example utilisation dans une loop"
echo ""
for inst in $(list_INST_NAME); do
	echo "Instance " $inst " is on the server"
done
echo ""
echo "------===------===------===------===------===------===------===------===------===------===------"
echo ""
echo "Les Instances sur le serveur sont: " $(list_INST_NAME)
echo "Les Databases sur le serveur sont: " $(list_DB_NAME)
echo "L'instance de ASM sur le serveur est: " $(get_ASM_SID)
echo "Les ORACLE_HOME uniques sur le serveur sont: " $(list_ORA_HOME)
echo ""
echo "------===------===------===------===------===------===------===------===------===------===------"
echo ""
echo "L'instance type de ASM1 est: " $(get_INST_TYPE +ASM1)
echo "L'instance type de MYDB1 est: " $(get_INST_TYPE MYDB1)
echo ""
echo "------===------===------===------===------===------===------===------===------===------===------"
echo ""
echo "SCENARIO 1 - SID is : MYDB1"
if is_ORACLE_SID "MYDB1"; then
                echo "MYDB1 is a valid SID"
        else
                echo "MYDB1 is not a valid SID"
fi
echo "SCENARIO 2 - SID is : PAPALO1"
if is_ORACLE_SID "PAPALO1"; then
                echo "PAPALO1 is a valid SID"
        else
                echo "PAPALO1 is not a valid SID"
fi
echo ""
echo "------===------===------===------===------===------===------===------===------===------===------"
echo ""
