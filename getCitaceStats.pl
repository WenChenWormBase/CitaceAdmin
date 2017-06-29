#!/usr/bin/perl

use strict;
use Ace;

if ($#ARGV !=0) {
    die "usage: $0 series_file ace\n";
}

print "Get citace statistics ...\n";

my $tace='/usr/local/bin/tace';

my ($s, $query, $TotalObj, $gene, $paper, $tmp_length, $var);
my $PaperGeneLink = 0;
my $PaperAbLink = 0;
my $PaperTgLink = 0;
my $GeneGOLink = 0;
my $VarPhenoLink = 0;

my @SimpleQueryList = ( 
    "find Antibody",
    "find Anatomy_term",
    "find Anatomy_function",
    "find DO_term",
    "find Disease_model_annotation",    
    "find Expr_pattern",
    "find Picture",    
    "find Microarray_experiment",
    "find Expression_cluster",
    "QUERY FIND Analysis MassSpec*",
    "find RNAi",
    "find Interaction",
    "QUERY FIND Interaction Physical",
    "QUERY FIND Interaction Predicted",
    "QUERY FIND Interaction Regulatory",
    "QUERY FIND Interaction Genetic",
    "find Paper",
    "find Person",
    "find Transgene",  
    "find WBProcess",  
    "QUERY FIND Variation Phenotype",
    "QUERY FIND Variation Phenotype_not_observed",
    "QUERY FIND RNAi Phenotype",
    "QUERY FIND RNAi Phenotype_not_observed",
    "QUERY FIND Transgene Phenotype",  
    "QUERY FIND Strain Phenotype",  
    "QUERY FIND Molecule RNAi",
    "QUERY FIND Molecule Variation",
    "QUERY FIND Molecule Interaction",
    "QUERY FIND Molecule WBProcess",
    "QUERY FIND Gene Expr_pattern",
    "QUERY FIND Gene GO_annotation",
    "QUERY FIND Gene Concise_description",
    "QUERY FIND Gene Automated_description",
    "QUERY FIND Gene Experimental_model",
    "QUERY FIND Gene Disease_relevance",
    "QUERY FIND Paper Antibody",
    "QUERY FIND Paper Expr_pattern",
    "QUERY FIND Paper Expression_cluster",
    "QUERY FIND Paper Microarray_experiment",
    "QUERY FIND Analysis MassSpec*; follow Reference",
    "QUERY FIND Paper Interaction",
    "QUERY FIND Paper RNAi",
    "QUERY FIND Paper Transgene"
);


my %SimpleQueryName = ( 
    "find Antibody" => "Antibody",
    "find Anatomy_term" => "Anatomy Term",
    "find Anatomy_function" => "Anatomy Function",
    "find DO_term" => "Disease Ontology Term",
    "find Disease_model_annotation" => "Disease Models",
    "find Expr_pattern" => "Expression Pattern",
    "find Picture" => "Picture",
    "find Microarray_experiment" => "Microarray Experiment",
    "find Expression_cluster" => "Expression Cluster",
    "QUERY FIND Analysis MassSpec*" => "Proteomic Analysis",
    "find RNAi" => "RNAi",
    "find Interaction" => "Interaction (total)",
    "QUERY FIND Interaction Physical" => "Physical Interaction",
    "QUERY FIND Interaction Predicted" => "Predicted Interaction",
    "QUERY FIND Interaction Regulatory" => "Gene Regulation",
    "QUERY FIND Interaction Genetic" => "Genetic Interaction",
    "find Paper" => "Paper",
    "find Person" => "Person",
    "find Transgene" => "Transgene",  
    "find WBProcess" => "Topic (total)",  
    "QUERY FIND Variation Phenotype" => "Variation with Phenotype",
    "QUERY FIND Variation Phenotype_not_observed" => "Variation with Phenotype Not Obbserved",
    "QUERY FIND RNAi Phenotype" => "RNAi with Phenotype",
    "QUERY FIND RNAi Phenotype_not_observed" => "RNAi with Phenotype Not Observed",
    "QUERY FIND Transgene Phenotype" => "Transgene with Phenotype",  
    "QUERY FIND Strain Phenotype" => "Strain with Phenotype",  
    "QUERY FIND Molecule RNAi" => "Chemicals Related to RNAi",
    "QUERY FIND Molecule Variation" => "Chemicals Related to Variation",
    "QUERY FIND Molecule Interaction" => "Chemicals Related to Interaction",
    "QUERY FIND Molecule WBProcess" => "Chemicals Mentioned in Topic",
    "QUERY FIND Gene Expr_pattern" => "Gene with Expression Pattern",
    "QUERY FIND Gene GO_annotation" => "Gene with GO annotation",
    "QUERY FIND Gene Concise_description" => "Gene with Hand-written Concise Description",
    "QUERY FIND Gene Automated_description" => "Gene with Automatically Generated Description",
    "QUERY FIND Gene Experimental_model" => "Gene with Experimental Model",
    "QUERY FIND Gene Disease_relevance" => "Gene with Disease Relevance",
    "QUERY FIND Paper Antibody" => "Paper with Antibody",
    "QUERY FIND Paper Expr_pattern" => "Paper with Expression Pattern",
    "QUERY FIND Paper Expression_cluster" => "Paper with Expression Cluster",
    "QUERY FIND Paper Microarray_experiment" => "Paper with Microarray Experiment",
    "QUERY FIND Analysis MassSpec*; follow Reference" => "Paper with Proteomic Analysis",
    "QUERY FIND Paper Interaction" => "Paper with Interaction",
    "QUERY FIND Paper RNAi" => "Paper with RNAi",
    "QUERY FIND Paper Transgene" => "Paper with Transgene"
);


my @Obj;
my @tmp;

#---------- Start Parsing Paper Class ----------------------
print "connecting to citace ...";
my $acedbpath='/home/citace/citace';
my $db = Ace->connect(-path => $acedbpath,  -program => $tace) || die print
"Connection failure: ", Ace->error;

#open (OUT, ">CitaceStats.txt") || die "can't open dataset_list.txt!";
open (OUT, ">$ARGV[0]") || die "cannot open $ARGV[0]: $!\n";

foreach $s (@SimpleQueryList) {
    $query = $s;
    @Obj = $db->find($query);
    $TotalObj = @Obj;

   #if ($s =~ /^find/) {	
	#print OUT "$s: $TotalObj\n";
    #} elsif ($s =~ /^QUERY/) {
	#@tmp = split /\s/, $s;
	#$tmp_length = @tmp;
	#if ($tmp_length == 4) {
	   #print OUT "$tmp[2] with $tmp[3]: $TotalObj\n";
	#} else {
	   #print "QUERY ERROR: $s\n";
	#}  
   # } else {
        #print "QUERY ERROR: $s\n";
    #}
 
    if ($SimpleQueryName{$s}) {
	print OUT "$SimpleQueryName{$s}: $TotalObj\n";
    } else {
        print "QUERY ERROR: $s\n";
    }


    @Obj = ();
}

$query = "QUERY FIND Gene GO_annotation";
@Obj = $db->find($query);
foreach  $gene (@Obj) {
    @tmp = $gene->GO_annotation;
    $tmp_length = @tmp;
    $GeneGOLink = $GeneGOLink + $tmp_length;
    #print "$GeneGOLink\n";
    @tmp = ();
}
print OUT "Total Gene--GO_annotation links: $GeneGOLink\n";
@Obj = ();

$query = "QUERY Find Paper Gene";
@Obj = $db->find($query);
foreach  $paper (@Obj) {
    @tmp = $paper->Gene;
    $tmp_length = @tmp;
    $PaperGeneLink = $PaperGeneLink + $tmp_length;
    @tmp = ();
}
print OUT "Total Paper--Gene links: $PaperGeneLink\n";

$query = "QUERY Find Paper Antibody";
@Obj = $db->find($query);
foreach  $paper (@Obj) {
     @tmp = $paper->Antibody;
     $tmp_length = @tmp;
     $PaperAbLink = $PaperAbLink + $tmp_length;
     @tmp = ();
}
print OUT "Total Paper--Antibody links: $PaperAbLink\n";


$query = "QUERY Find Paper Transgene";
@Obj = $db->find($query);
foreach  $paper (@Obj) {
     @tmp = $paper->Transgene;
     $tmp_length = @tmp;
     $PaperTgLink = $PaperTgLink + $tmp_length;
     @tmp = ();
}
print OUT "Total Paper--Transgene links: $PaperTgLink\n";


$query = "find Construct",
@Obj = $db->find($query);
$tmp_length = @Obj;
print OUT "Total construct: $tmp_length\n";

$query = "find Construct; follow Reference",
@Obj = $db->find($query);
$tmp_length = @Obj;
print OUT "Total Papers with Construct: $tmp_length\n";


$query = "QUERY Find Variation Phenotype";
@Obj = $db->find($query);
foreach  $var (@Obj) {
     @tmp = $var->Phenotype;
     $tmp_length = @tmp;
     $VarPhenoLink = $VarPhenoLink + $tmp_length;
     @tmp = ();
}
print OUT "Total Variation--Phenotype links: $VarPhenoLink\n";

my $PaperVarPhenoLink;
$query = "QUERY FIND Variation Phenotype; follow Reference",    
@Obj = $db->find($query);
$PaperVarPhenoLink = @Obj;
print OUT "Papers with Variation--Phenotype links: $PaperVarPhenoLink\n";

my $topic;
my $TopicGeneLink = 0;
my $TopicPaperLink = 0;
my $TopicPathwayLink = 0;

$query = "find WBProcess";
@Obj = $db->find($query);
foreach  $topic (@Obj) {
     @tmp = $topic->Gene;
     $tmp_length = @tmp;
     $TopicGeneLink = $TopicGeneLink + $tmp_length;
     @tmp = ();
}
print OUT "Total Topic--Gene links: $TopicGeneLink\n";
foreach  $topic (@Obj) {
    @tmp = $topic->Reference;
     $tmp_length = @tmp;
     $TopicPaperLink = $TopicPaperLink + $tmp_length;
     @tmp = ();
}
print OUT "Total Paper--Topic links: $TopicPaperLink\n";
foreach  $topic (@Obj) {
    @tmp = $topic->Pathway;
     $tmp_length = @tmp;
     $TopicPathwayLink = $TopicPathwayLink + $tmp_length;
     @tmp = ();
}
print OUT "Total Topic WikiPathway links: $TopicPathwayLink\n";


close (OUT);
$db->close();
print "Done.\n";
