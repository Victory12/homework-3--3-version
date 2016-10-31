#!/usr/bin/env perl

use strict;
use warnings;
use lib '../lib';
use Local::MusicLibrary;
use Local::Parser;
use Getopt::Long;

my $parameters = {};
GetOptions ($parameters, 'band=s','year=i','album=s','track=s','format=s','columns:s','sort=s'); 
my $struct;

while (<STDIN>)
{
	$struct = parse($_);
}

PrintTableFormat($struct,$parameters);