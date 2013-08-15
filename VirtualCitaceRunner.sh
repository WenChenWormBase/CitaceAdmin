#!/bin/csh
cd /home/citace/CitaceMinus
setenv ACEDB /home/citace/CitaceMinus
#Start reading files from CitaceMinus
## from Chris
/home/citace/bin/tace -tsuser 'chris' <<END_TACE
Parse /home/citace/Data_for_WS239/Data_for_CitaceMinus/Data_from_Chris/Bogus_RNAi_object_deletion.ace
Parse /home/citace/Data_for_WS239/Data_for_CitaceMinus/Data_from_Chris/Deletion_of_duplicate_PCR_Products_from_Citace_Minus_7-10-2013.ace
Parse /home/citace/Data_for_WS239/Data_for_CitaceMinus/Data_from_Chris/WBPaper00004402_RNAis_Movie_Deletion.ace
save
quit
END_TACE
## from Daniela
/home/citace/bin/tace -tsuser 'daniela' <<END_TACE
Parse /home/citace/Data_for_WS239/Data_for_CitaceMinus/Data_from_Daniela/patch
save
quit
END_TACE
## from Wen
/home/citace/bin/tace -tsuser 'wen' <<END_TACE
Parse /home/citace/Data_for_WS239/Data_for_CitaceMinus/Data_from_Wen/AddSpe_Aff1OS.ace
Parse /home/citace/Data_for_WS239/Data_for_CitaceMinus/Data_from_Wen/fixBogusObjects.ace
Parse /home/citace/Data_for_WS239/Data_for_CitaceMinus/Data_from_Wen/YanaiOSMrAllSpe.ace
save
quit
END_TACE
## from Xiaodong
/home/citace/bin/tace -tsuser 'xiaodong' <<END_TACE
Parse /home/citace/Data_for_WS239/Data_for_CitaceMinus/Data_from_Xiaodong/WBPaper00042266_pfm
save
quit
END_TACE
#End Reading files from CitaceMinus
#---------------No need to update --------------------
cd /home/citace/citace/
rm -rf /home/citace/citace/database
cp -r /home/citace/CitaceMinus/database .
rm -rf /home/citace/citace/wspec
cp -r /home/citace/CitaceMinus/wspec .
setenv ACEDB /home/citace/citace
#-----------------------------------------------------
#Start reading files from citace 
## from Cecilia
/home/citace/bin/tace -tsuser 'cecilia' <<END_TACE
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Cecilia/persons.ace
save
quit
END_TACE
## from Chris
/home/citace/bin/tace -tsuser 'chris' <<END_TACE
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Chris/gene_regulation.ace.20130712
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Chris/interaction.ace.20130712
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Chris/Large_scale_interactions_WS239.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Chris/rnai.ace.20130712
save
quit
END_TACE
## from Daniela
/home/citace/bin/tace -tsuser 'daniela' <<END_TACE
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Daniela/expr_pattern.ace.20130718
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Daniela/movie.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Daniela/pictures.ace
save
quit
END_TACE
## from Gary
/home/citace/bin/tace -tsuser 'gary' <<END_TACE
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Gary/phenotype_from_obo_WS239.ace
save
quit
END_TACE
## from Karen
/home/citace/bin/tace -tsuser 'karen' <<END_TACE
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Karen/alle_paper.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Karen/database.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Karen/Molecule.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Karen/mol_phene.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Karen/process.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Karen/process_curation.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Karen/transgene.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Karen/var_phen.ace
save
quit
END_TACE
## from Kimberly
/home/citace/bin/tace -tsuser 'kimberly' <<END_TACE
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Kimberly/concise_dump_new.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Kimberly/papers.ace
save
quit
END_TACE
## from Ranjana
/home/citace/bin/tace -tsuser 'ranjana' <<END_TACE
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Ranjana/071613_WS239_go_dump.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Ranjana/disease_WS239.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Ranjana/go_terms_WS239.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Ranjana/HumanDO_WS239.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Ranjana/phenotype2go_mappings_new.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Ranjana/variation2goterm_VarID.ace
save
quit
END_TACE
## from Raymond
/home/citace/bin/tace -tsuser 'raymond' <<END_TACE
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Raymond/add_neurobrowse_url.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Raymond/anatomy_function.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Raymond/glowormurl.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Raymond/link2wormatlas.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Raymond/links2wormweb.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Raymond/miller_cell_type_arrays.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Raymond/momcell_childcell.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Raymond/mwp.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Raymond/pharyngeal_neuroconn.ace
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Raymond/WBbt.ace
save
quit
END_TACE
## from Wen
/home/citace/bin/tace -tsuser 'wen' <<END_TACE
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Wen/WS239microarray.ace
save
quit
END_TACE
## from Xiaodong
/home/citace/bin/tace -tsuser 'xiaodong' <<END_TACE
Parse /home/citace/Data_for_WS239/Data_for_citace/Data_from_Xiaodong/antibody.ace.20130716
save
quit
END_TACE
#-------------No need to update ----------------------
#Working on Raymond's AO indexing scripts and read the .ace file.
add_attribute_index.pl
## from Raymond
/home/citace/bin/tace -tsuser 'raymond' <<END_TACE
Parse /home/citace/citace/anat_term_add_annotation_index.ace
save
quit
END_TACE
#End Reading files from citace
#Correct invalid papers and genes
cd /home/citace/citaceAdmin/InvalidPaperGene/
./prepBogusPaperGene.sh
./fixInvalidPaper.pl 
cd /home/citace/citace/
setenv ACEDB /home/citace/citace/
## from Wen
/home/citace/bin/tace -tsuser 'wen' <<END_TACE
Parse /home/citace/citaceAdmin/InvalidPaperGene/FixCitacePaperGene.ace
save
quit
END_TACE
#--------------------------------------------------
#Get citace statistics
cd /home/citace/citaceAdmin/GetStats/
./getCitaceStats.pl CitaceStats_WS239.txt
./getStatsDiff.pl CitaceStats_WS238.txt CitaceStats_WS239.txt citace238to239diff.txt
cd /home/citace/citace/
setenv ACEDB /home/citace/citace/
#Start dumping out files and back up current citace.
/home/citace/bin/tace -tsuser 'citace' <<END_TACE
Dump -T
quit
END_TACE
#package citace.
tar -zcvf /home/citace/NewArchive/citace_dump_2013-07-19.tar.gz dump_2013-07-19* README.txt /home/citace/Data_for_WS239/Data_for_Ontology/
tar -zcvf /home/citace/NewArchive/citace239final20130719.tgz database/ wspec/
cd /home/citace/CitaceMinus/
tar -zcvf /home/citace/NewArchive/CM239final20130719.tgz database/ wspec/
cp /home/citace/citace/anat_term_add_annotation_index.ace /home/citace/NewArchive/.
cp /home/citace/citaceAdmin/InvalidPaperGene/FixCitacePaperGene.ace /home/citace/NewArchive/.
#End dumping and backing up.

