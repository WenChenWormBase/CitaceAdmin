#!/usr/bin/perl
use strict;
use Ace;

#-------------------Type out the purpose of the script-------------
print "Creat ace file to populate Paper-GO_term ...";
open (OUT, ">citacePostProcess.ace") || die "can't open citacePostProcess.ace!";

my $db = Ace->connect(-path => '/home/citace/citace/',  -program => '/usr/local/bin/tace') || die print "Connection failure: ", Ace->error;

my @WBP;
my @GO;
my @Paper;
my ($wbp, $go, $paper);

my $query="QUERY FIND WBProcess";
my @WBP=$db->find($query);

print scalar @WBP, " WBProcess found in citace ...";

#-------------------------------------------------------------
foreach $wbp (@WBP) {
  
    #get topic information
    @GO = ();
    @Paper = ();
    if ($wbp->GO_term){
	@GO = $wbp->GO_term;
    }
    if ($wbp->Reference){
	@Paper = $wbp->Reference;
    }

    foreach $paper (@Paper) {
	print OUT "\nPaper : \"$paper\"\n";
	foreach $go (@GO) {
	    print OUT "GO_term \"$go\" -O \"citacePostProcess_inferred_from_WBProcess_wen\"\n";
	}
    }
}
#-----------------------------------------------------------

close (OUT);
$db->close();
print "Done.\n";

