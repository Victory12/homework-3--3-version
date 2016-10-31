package Local::MusicLibrary;

use Local::MusicLibraryParam;
use strict;
use warnings;
use feature 'state';
our $VERSION = '1.00';
use DDP;
use List::Util;
use Exporter 'import';
our @EXPORT = qw/PrintTableFormat/;


sub PrintTableFormat{
	my ($ref,$param) = @_;
	my $columns = columns ($ref,$param);
	onsort ($ref, $param->{sort}) if defined $param->{sort};
	my @field = grep {defined $param->{$_}} @$columns;
	$ref = filter ($ref,\@field,$param);
	PrintTable($ref,$columns);
}
sub PrintTable{ 
	my ($ref,$columns)=@_;
	if(($#$ref >= 0) && ($#$columns >= 0)){
		my $sizetable = size($ref,$columns);
		my $between = PrintTableBetween ($columns,@$sizetable);
		my $format = "| ".join(" | ", map { "%${_}s" } @$sizetable)." |";
		
		PrintTableOut($sizetable,1);
		for my $i (0 .. $#$ref) {
			printf $format, map {$ref->[$i]->{$_}} @$columns;			
			print $between  if $i  != ($#$ref);
		}
		PrintTableOut($sizetable,0);	
	}
}

sub PrintTableBetween{
	my ($columns) = shift;
	my @sizetable = @_;
	my $last_elem = "-" x (pop (@sizetable)+2);
	my $section = join ("",map {"-" x ($_+2)."+"} @sizetable );
	my $between = "\n|".$section.$last_elem."|\n";
	return $between;
}
sub PrintTableOut{
	my ($sizetable,$flag) = @_;
	my $max = 0;
	my $output;
	$max = (List::Util::reduce { $a + $b } @$sizetable) + 3*($#$sizetable+1) ;
	$output = "/"."-" x ($max-1)."\\\n" if $flag == 1;
	$output = "\n\\"."-" x ($max-1)."/\n" if $flag == 0;
	print $output;
}
sub size{
	my ($ref,$columns) = @_;
	my $sizetable;	
	for my $key (@$columns){
		my $size = 0;
		for my $elem (@$ref){
			$size = length $elem->{$key} if ( $size <= length $elem->{$key});
		}
		push @$sizetable,$size;
	}
	return $sizetable;
}

