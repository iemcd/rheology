#!/usr/bin/perl

use strict;
use warnings;
use 5.010; # For the \R generalized newline
use Getopt::Std;
use Pod::Usage;

local $Getopt::Std::STANDARD_HELP_VERSION = 1;
my %Opts;
getopts('HLhmv', \%Opts);
$Opts{h} and &HELP_MESSAGE;
$Opts{m} and pod2usage(VERBOSE=>2);
$Opts{v} and &VERSION_MESSAGE;

my $pntsfile = pop;
my $specfile = pop;

if ($Opts{H} and $Opts{L}) { die "You can't have it both ways--pick H or L. "};
unless ($Opts{H} or $Opts{L}) { die "You must pick either H or L. "};
open(my $specin, $specfile)	|| die "Couldn't read $specfile: $!";
open(my $ptsin, $pntsfile)	|| die "Couldn't read $pntsfile: $!";

my @spec;
while (<$specin>)
{	push @spec, [split];
}

my @pts;
while (<$ptsin>)
{	s/\R//;
	push @pts, (split)[0];
}


if ($Opts{H})
{	foreach my $point (@pts)
	{	my ($Gp,$Gpp) = 0;
		for my $i (0..$#spec)
		{	my $Gi = $spec[$i][1];
			my $li = $spec[$i][0];
			$Gp += $Gi*($point*$li)**2/(1+($point*$li)**2);
			$Gpp += $Gi*($point*$li)/(1+($point*$li)**2);
		}
		print "$point\t$Gp\t$Gpp\n"
	}
}

if ($Opts{L})
{	foreach my $point (@pts)
	{	my $J = 0;
		for my $i (0..$#spec)
		{	my $Ji = $spec[$i][1];
			my $ti = $spec[$i][0];
			$J += $Ji*(1-exp(-$point/$ti));
		}
		print "$point\t$J\n"
	}
}

sub HELP_MESSAGE { pod2usage(VERBOSE=>1) };
sub VERSION_MESSAGE { say "spectrumcalc.pl 0.1\nWritten Summer 2012, by Ian McDougall." };

__END__

=head1 NAME

spectrumcalc.pl - calculates rheological functions at arbitrary points from a discrete rheological spectrum.

=head1 SYNOPSIS

B<spectrumcalc.pl> I<-H> I<-L> I<-h> I<-m> I<-v> F<spectrum> F<points>

=head1 DESCRIPTION

B<spectrumcalc.pl> takes a discrete spectrum and a list of points, calculates associated material functions at those points, and prints them to STDOUT. It assumes that all input files are tab- or whitespace-separated and that the first column is the independent variable. Either one of the I<-H> (relaxation) or I<-L> (retardation) options is required to specify what kind of spectrum is given.

=head1 OPTIONS

=over 4

=item I<-H>

The input is a relaxation spectrum. The points will be interpreted as frequencies, and dynamic moduli will be calculated.

item I<-L>

The input is a retardation spectrum. The points will be interpreted as times, and creep compliances will be calculated.

=item I<-h>, I<--help>

Show this help message.

=item I<-m>

Show the manpage (full documentation).

=item I<-v>, I<--version>

Show version information.

=back

=head1 DIAGNOSTICS

=over 4

=item Couldn't read F<filename>!

(F) The given F<filename> was invalid for some reason.

=item You can't have it both ways--pick H or L.

(F) Either option I<-H> or I<-L> is required, but you can't use both.

=item You must pick either H ot L.

(F) Unless you specify the type of spectrum given with the I<-H> or I<-L> option, B<spectrumcalc.pl> won't know what to do with it.

=back

=TODO

I need to find the papers I got the formulas from, check them one last time, and reference them in the documentation.

=head1 REQUIRES

Perl 5.010, Getopt::Std, Pod::Usage

=head1 SEE ALSO

perl(1)

=head1 AUTHOR

Ian McDougall, Ian_McDougall@student.uml.edu
