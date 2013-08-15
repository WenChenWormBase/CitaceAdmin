#!/bin/csh
cd /home/citace/CitaceMinus/
setenv ACEDB /home/citace/CitaceMinus/
#Do mid build modifications.
#Dump out the database
/home/citace/bin/tace -tsuser 'wen' <<END_TACE
Dump -T
quit
END_TACE
#End dumping out the database. The files will be called dump_2006-01-27_A.1.ace
#Now you update wspec/
cp /home/citace/Data_for_WS239/models.wrm.1.394 wspec/models.wrm
#The following command remove ACEDB.wrm which will cause database reinitiation.
rm database/ACEDB.wrm
#Now reinitiate the database and read all the dumped out data in.
#Now Read in citace data
/home/citace/bin/tace -tsuser 'wen' <<END_TACE
y
dumpread dump_2013-07-13_A.1.ace
save
quit
END_TACE
#New database created.
##Read new ace files for the new models.
##Finshied reading ace files for midbuild. 
tar -zcvf /home/citace/NewArchive/CM239midbuild20130713.tgz database/ wspec/
#rm dump_*.ace

