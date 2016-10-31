package Local::Parser;

use strict;
use warnings;
use feature 'state';;
use DDP;
use Exporter 'import';
our @EXPORT = qw/parse/;
sub parse{						
	my $str = shift;
	chomp($str);				
	$str =~ m!^\.\/(.[^\/]*)\/\s*([\d]*)\s-\s(.[^\/]*)\/(.[^\/]*)\.(.[^\/\.]*)!;		
	our $ref;
	return undef if !defined $1 ;
	push  @$ref,{ band => $1, year => $2, album => $3, track => $4, format => $5};			
	return $ref ;			
}