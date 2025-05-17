#!perl -w 
use strict;

##
## Подключение модуля такое:
##
BEGIN { unshift @INC, "." }
use Win32::Chm::Search;


$| = 1;

my $default = "change";
my $file = "test_chm.chm";

print "Using test file $file\n";
print "Keyword to find [\"$default\" by default - press Enter]: ";
my $kw = <STDIN>; chomp($kw);
$kw = $default if !$kw;

my @result = Win32::Chm::Search($kw, $file);
use Data::Dumper; print "Search results: ".Dumper(\@result);

foreach ($result[0]) {
	next if !$_;
	print "Running CHM browser for first match...\n";
	Win32::Chm::OpenKw($_->[0]);
}