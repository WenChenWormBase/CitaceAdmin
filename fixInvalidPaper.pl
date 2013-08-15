#!/usr/bin/perl

use strict;

#------------------ Move data under invalid papers -------------
print "This program check invalid papers in CitaceMinus and move them to the vaid objects.\n";
print "Do this query in CitaceMinus: find paper Status = valid & Refers_to = *\n";
print "Input file: CitaceInvalidPaper.ace\n";
print "Output file: FixCitacePaperGene.ace\n";

open (IN1, "CitaceInvalidPaper.ace") || die "can't open $!";
open (OUT, ">FixCitacePaperGene.ace") || die "can't open $!";
open (EXPR, ">DataType/FixExprPaperGene.ace") || die "can't open $!";
open (ITR, ">DataType/FixInteractionPaperGene.ace") || die "can't open $!";
open (GR, ">DataType/FixGeneRegulationPaperGene.ace") || die "can't open $!";
open (AB, ">DataType/FixAntibodyPaperGene.txt") || die "can't open $!";
open (TG, ">DataType/FixTransgenePaperGene.txt") || die "can't open $!";


my ($line, $oldPaperID, $newPaperID);
my @tmp;
my $i = 0;
while ($line=<IN1>) {
    chomp($line);
    if ($line =~ /^Paper/) {
	@tmp = split '"', $line;
	$oldPaperID = $tmp[1];
	$i++;
	$newPaperID = "";
    } elsif ($line =~ /^Merged_into/)	{
	@tmp = split '"', $line;
	$newPaperID = $tmp[1];
    } elsif (($line =~ /^Interaction/)||($line =~ /^Gene_regulation/)||($line =~ /^Expr_pattern/)||($line =~ /^Cell_group/)||($line =~ /^Seq/)||($line =~ /^Life_stage/)||($line =~ /^Transgene/)||($line =~ /^Antibody/)){	
	if (($oldPaperID ne "") && ($newPaperID ne "")) {
	    print OUT "Paper : \"$oldPaperID\"\n";
	    print OUT "-D $line\n\n";
	    print OUT "Paper : \"$newPaperID\"\n";
	    print OUT "$line\n\n";

	    if ($line =~ /^Interaction/) {
		print ITR "Paper : \"$oldPaperID\"\n-D $line\n\nPaper : \"$newPaperID\"\n$line\n\n";
	    } elsif ($line =~ /^Gene_regulation/) {
		print GR "Paper : \"$oldPaperID\"\n-D $line\n\nPaper : \"$newPaperID\"\n$line\n\n";
	    } elsif ($line =~ /^Expr_pattern/) {
		print EXPR "Paper : \"$oldPaperID\"\n-D $line\n\nPaper : \"$newPaperID\"\n$line\n\n";
	    } elsif ($line =~ /^Antibody/) {
		print AB "$line\t$oldPaperID => $newPaperID\n";
	    } elsif ($line =~ /^Transgene/) {
		print TG "$line\t$oldPaperID => $newPaperID\n";
	    } 
	}       
    }
}
print "$i invalid papers parsed.\n"; 
close (IN);
#close (OUT);
#---------------------Invalid Papers done.--------------------------



#-------------------Obtain Gene ID merge info ----------------------
print "Do this query in current WS: QUERY Find Gene Status = Dead & Merged_into = *\n";
print "Input file: WSDeadGene.ace\n";

open (IN2, "WSDeadGene.ace") || die "can't open $!";
my ($oldGeneID, $newGeneID);
my %GeneMerge;
#my @tmp;
#my $line;
#my $i = 0;

$i = 0;
while ($line=<IN2>) {
    chomp($line);
    if ($line =~ /^Gene/) {
	@tmp = split '"', $line;
	$oldGeneID = $tmp[1];
	$i++;
	$newGeneID = "";
    } elsif ($line =~ /^Merged_into/)	{
	@tmp = split '"', $line;
	$newGeneID = $tmp[1];
	$GeneMerge{$oldGeneID} = $newGeneID;
	#print "New Paper: $newPaperID\n";
    }
}
print "$i genes objects merged.\n"; 
close (IN2);
#-----------------Gene ID merge info recorded.-----------------------



#-----------------Check all Gene objects in citace-------------------
print "Do this query in citace: QUERY Find Gene Experimental_info = *\n";
print "Input file: CitaceGene.ace\n";
open (IN3, "CitaceGene.ace") || die "can't open $!";

my $continue = 0;
$i = 0;
while ($line=<IN3>) {
    chomp($line);
    if ($line =~ /^Gene/) {
	@tmp = split '"', $line;
	$oldGeneID = $tmp[1];
	if ($GeneMerge{$oldGeneID}) {
	    #This is a invalid gene, move the objects.
	    $continue = 1;
	    $i++;
	    $newGeneID = $GeneMerge{$oldGeneID};
	    while ($continue == 1) {
		$line=<IN3>;
		chomp($line);		
		if ($line eq "") {
		    #this gene objects ends already.
		    $continue = 0;
		} elsif (($line =~ /^Interaction/)||($line =~ /^Reference/)||($line =~ /^Expr_pattern/)||($line =~ /^Drives_Transgene/)||($line =~ /^Transgene_product/)||($line =~ /^Antibody/)||($line =~ /^Trans_regulator/)||($line =~ /^Trans_target/)||($line =~ /^Expression_cluster/)){
		    print OUT "Gene : \"$oldGeneID\"\n";
		    print OUT "-D $line\n\n";
		    print OUT "Gene : \"$newGeneID\"\n";
		    print OUT "$line\n\n";
		    
		    if ($line =~ /^Interaction/) {
			print ITR "Gene : \"$oldGeneID\"\n-D $line\n\nGene : \"$newGeneID\"\n$line\n\n";
		    } elsif (($line =~ /^Trans_regulator/)||($line =~ /^Trans_target/)) {
			print GR "Gene : \"$oldGeneID\"\n-D $line\n\nGene : \"$newGeneID\"\n$line\n\n";
		    } elsif ($line =~ /^Expr_pattern/) {
		 	print EXPR "Gene : \"$oldGeneID\"\n-D $line\n\nGene : \"$newGeneID\"\n$line\n\n";
		    } elsif ($line =~ /^Antibody/) {
		        print AB "$line\t$oldGeneID => $newGeneID\n";
		    } elsif (($line =~ /^Drives_Transgene/)||($line =~ /^Transgene_product/)) {
			print TG "$line\t$oldGeneID => $newGeneID\n";
		    }

		}
	    } 
        } 
    }
}

print "$i invalid genes from citace parsed.\n"; 
close (IN3);
close (OUT);
close (EXPR);
close (ITR);
close (GR);
close (AB);
close (TG);

