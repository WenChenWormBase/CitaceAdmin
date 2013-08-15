#!/usr/bin/perl

use strict;
use Ace;

if ($#ARGV !=0) {
    die "usage: $0 series_file ace\n";
}

print "Get citace statistics ...\n";

my $tace='/home/citace/bin/tace';

my ($s, $query, $TotalObj, $gene, $paper, $tmp_length);
my $PaperGeneLink = 0;
my $PaperAbLink = 0;
my $PaperTgLink = 0;
my $GeneGOLink = 0;
my @SimpleQueryList = ( 
    "find Antibody",
    "find Anatomy_term",
    "find Anatomy_function",
    "find DO_term",
    "find Expr_pattern",
    "find Picture",
    "find Microarray_experiment",
    "find Expression_cluster",
    "find RNAi",
    "find Interaction",
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
    "QUERY FIND Gene GO_term",
    "QUERY FIND Gene Concise_description",
    "QUERY FIND Gene Experimental_model",
    "QUERY FIND Gene Disease_relevance",
    "QUERY FIND Paper Antibody",
    "QUERY FIND Paper Expr_pattern",
    "QUERY FIND Paper Expression_cluster",
    "QUERY FIND Paper Microarray_experiment",
    "QUERY FIND Paper Interaction",
    "QUERY FIND Paper RNAi",
    "QUERY FIND Paper Transgene",
);
my @Obj;
my @tmp;

#---------- Start Parsing Paper Class ----------------------
print "connecting to citace ...";
my $acedbpath='/home/citace/citace/';
my $db = Ace->connect(-path => $acedbpath,  -program => $tace) || die print
"Connection failure: ", Ace->error;

#open (OUT, ">CitaceStats.txt") || die "can't open dataset_list.txt!";
open (OUT, ">$ARGV[0]") || die "cannot open $ARGV[1]: $!\n";

foreach $s (@SimpleQueryList) {
    $query = $s;
    @Obj = $db->find($query);
    $TotalObj = @Obj;
    if ($s =~ /^find/) {
	print OUT "$s: $TotalObj\n";
    } elsif ($s =~ /^QUERY/) {
	@tmp = split /\s/, $s;
	$tmp_length = @tmp;
	if ($tmp_length == 4) {
	   print OUT "$tmp[2] with $tmp[3]: $TotalObj\n";
	} else {
	   print "QUERY ERROR: $s\n";
	}  
    } else {
        print "QUERY ERROR: $s\n";
    }
    @Obj = ();
}

$query = "QUERY FIND Gene GO_term";
@Obj = $db->find($query);
foreach  $gene (@Obj) {
    @tmp = $gene->GO_term;
    $tmp_length = @tmp;
    $GeneGOLink = $GeneGOLink + $tmp_length;
    #print "$GeneGOLink\n";
    @tmp = ();
}
print OUT "Total Gene--GO_term links: $GeneGOLink\n";
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

close (OUT);
$db->close();
print "Done.\n";





