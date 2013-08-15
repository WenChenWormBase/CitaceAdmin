#!/bin/csh
cd /home/citace/citaceAdmin/InvalidPaperGene/
setenv ACEDB /home/citace/citace/
/home/citace/bin/tace <<END_TACE
QUERY FIND paper Status = invalid & Refers_to = *
show -a -f CitaceInvalidPaper.ace
QUERY Find Gene Experimental_info = *
show -a -t Experimental_info -f CitaceGene.ace
quit
END_TACE
setenv ACEDB /home/citace/ws
/home/citace/bin/tace <<END_TACE
QUERY Find Gene Status = Dead & Merged_into = *
show -a -t Merged_into -f WSDeadGene.ace
quit
END_TACE
