package Local::MusicLibraryParam;

use strict;
use warnings;
use feature 'state';
our $VERSION = '1.00';
use DDP;
use Exporter 'import';
our @EXPORT = qw/columns onsort filter/;
our @columns = ("band","year","album","track","format");

sub columns{
	my ($ref,$param) = @_;
    for my $key (%$param){
    	return undef if (defined $key and $key eq "columns") && ( $param->{$key} eq "");
    	@columns = split(',',$param->{columns}) if defined $key and $key eq "columns";
    }
    return \@columns;
}

sub onsort{
	my ($ref,$param) = @_;
	if($param eq "year"){
		@$ref = sort { $a->{$param} <=> $b->{$param} } @$ref;
	}
	else{
		@$ref = sort { uc($a->{$param}) cmp uc($b->{$param}) } @$ref;
	}
}

sub filter{
	my ($ref,$field,$param) = @_;
	for my $elem (@$field){
		if ($elem eq "year"){
			@$ref = grep {$param->{$elem} == $_->{$elem}} @$ref if $elem eq "year";
		}
		else{
			@$ref = grep {$param->{$elem} eq $_->{$elem}} @$ref;
		}
	}
	return $ref;
}