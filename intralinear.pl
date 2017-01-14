# intralinear.pl -- convert intralinear text to tables.

use strict;

my $inputFile = $ARGV[0];

open(INPUTFILE, $inputFile) || die("Could not open $inputFile");

print STDERR "Processing $inputFile\n";

my $topLang = "tl";
my $bottomLang = "de";

my $mode = 0;

print "\n\n<!-- DO NOT EDIT: DERIVED FILE!!! -->\n\n\n";

while (<INPUTFILE>)
{
    my $line = $_;

    if ($line =~ m/<INTRA>/)
    {
        $line = "";
        $mode = 1;
    }

    if ($line =~ m/<\/INTRA>/)
    {
        $line = "";
        $mode = 0;
    }

    if ($mode == 1)
    {
        $line =~ s/\[(.*?)\|(.*?)\]/\n<table rend=\"class(intralinear)\"><row><cell lang=\"$topLang\">\1<\/cell><\/row><row><cell><hi>\2<\/hi><\/cell><\/row><\/table>\n/g;
    }

    print $line;
}