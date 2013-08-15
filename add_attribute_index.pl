#!/usr/bin/perl
# 
# 

# query a citace database, write out an ace file that populates annotation indices of anatomy terms.
# Raymond Lee, 20060928

use Ace;
use strict vars;

my $outfile = "/home/citace/citace/anat_term_add_annotation_index.ace";

open(OUT, ">$outfile") or die "Can't open output file\n";

print OUT "//", "\t", "annotations from indexed anatomy terms", "\n";

my $db = Ace->connect(-path=>'/home/citace/citace')    #local connect
         || die "Connection failure: ",Ace->error;

my @anatomyterms = $db->fetch('Anatomy_term');

foreach my $anatomyterm (@anatomyterms) {
    my @ancestors = $anatomyterm->Ancestor;
    my @descendents = $anatomyterm->Descendent;
    my @anexprindex = ();
    my @anGOindex = ();
    my @deexprindex = ();
    my @deGOindex = ();
    if (@ancestors) {
	foreach my $ancestor (@ancestors) {
	    my @anexprs = ($ancestor->Expr_pattern);
	    foreach my $anexpr (@anexprs) {
		push @anexprindex, $anexpr;
	    }
	    my @anGOs = ($ancestor->GO_term);
	    foreach my $anGO (@anGOs) {
		push @anGOindex, $anGO;
	    }
	}
    }
    if (@descendents) {
	foreach my $descendent (@descendents) {
	    my @deexprs = ($descendent->Expr_pattern);
	    foreach my $deexpr (@deexprs) {
		push @deexprindex, $deexpr;
	    }
	    my @deGOs = ($descendent->GO_term);
	    foreach my $deGO (@deGOs) {
		push @deGOindex, $deGO;
	    }
	}
    }
    if (($#anexprindex+$#anGOindex+$#deexprindex+$#deGOindex)>0) {
	print OUT "\n";
	print OUT "Anatomy_term : ", $anatomyterm, "\n";
	foreach my $anexpr (@anexprindex) {
	    print OUT "Expr_ancestor ","\"",$anexpr,"\"","\n";
	}
	foreach my $deexpr (@deexprindex) {
	    print OUT "Expr_descendent ","\"",$deexpr,"\"","\n";
	}
	foreach my $anGO (@anGOindex  ) {
	    print OUT "GO_ancestor ","\"",$anGO,"\"","\n";
	}
	foreach my $deGO (@deGOindex) {
	    print OUT "GO_descendent ","\"",$deGO,"\"","\n";
	}
    }
}


close OUT;
