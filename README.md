
1. CitaceMinusDumpRead.sh
This script dump out all data in CitaceMinus and fit them into the new model.

2. VirtualCitaceRunner.sh
This the master shell script that does citace data upload. The following scripts are used by  VirtualCitaceRunner.sh to complete the task.

3. add_attribute_index.pl
Written by Raymond, this script would get descendent Anatomy ontology terms into Expr_pattern objects. 

4. prepBogusPaperGene.sh
This script identify dead paper or gene objects in citace and dump them out, also get the dead gene mapping info from the current WormBase release. Output files are: CitaceGene.ace
WSDeadGene.ace
CitaceInvalidPaper.ace

5. fixInvalidPaper.pl 
This script take results from prepBogusPaperGene.sh, then 
create ace files to fix bogus paper and gene objects in citace. 

Input file: 
CitaceGene.ace
WSDeadGene.ace
CitaceInvalidPaper.ace

Output file: 
FixCitacePaperGene.ace

6. getCitaceStats.pl
This script count the total number of objects or links in each class in citace

7. getStatsDiff.pl
This script compare the current results of getCitaceStats.pl with the previous version of citace and get the difference. 

