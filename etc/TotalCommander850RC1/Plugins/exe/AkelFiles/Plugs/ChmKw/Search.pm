##
## Simple CHM parse wrapper by Dmitry Koteroff.
## Freeware (C) since Jan 2004, http://dklab.ru
##
package Win32::Chm;
use strict;

my $strings = "#STRINGS";
my $kw      = "ChmKw.exe";
my $view    = "chmview.exe";

sub ExtractStrings {
	my ($file) = @_;
	my $exe = dirname(__FILE__)."\\".$view;
	system("$exe e $file /$strings");
	  open(local *F, $strings) or return;
	  local $/; read(F, my $buf, -s $strings);
	  close(F);
	unlink($strings);
	my %seen = ();
	return grep { !$seen{$_} } split /\x00+/, $buf;
}


sub Search {
	my ($keyword, @pathes) = @_;
	my @result = ();
	foreach my $file (@pathes) {
		my @strings = ExtractStrings($file) or next;
		foreach (@strings) {
			next if !/\Q$keyword\E.*/i;
			push @result, [ "chm://$file\@$&", $& ];
		}
	}
	return @result;
}

sub OpenKw {
	my ($file, $keyword) = @_;
	my $exe = dirname(__FILE__)."\\".$kw;
	
	$file =~ s{^chm://}{}is;
	if ($file =~ s{@(.*)}{}) {
		$keyword = $1 if !defined $keyword;
	}
	
	system("start $exe $file\@$keyword");
}

sub dirname {
	my ($dir) = @_;
	$dir =~ s{([\\/]|^)[^\\/]*$}{}sg;
	$dir =~ s{/}{\\}sg;
	return $dir eq ""? "." : $dir;
}

return 1;