package Math::FresnalZone;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(fresnal fresnalMi fresnalKm);

our $VERSION = '0.01';
sub VERSION { $VERSION; }

our $KILOMETERS_IN_A_MILE = 1.609344;
our $FEET_IN_A_METER      = 3.280839;

sub fresnal { 
   my $d = shift || 1;
   my $f = shift || 2.4;
   my $m = shift || 0;
   $d = $d * $KILOMETERS_IN_A_MILE if $m; # convert miles into kilometers
   my $fz = 72.6*sqrt($d/(4*$f));
   $fz = $fz * $FEET_IN_A_METER  if $m;   # convert meters back into feet
   return $fz;
}

sub fresnalMi { fresnal(shift,shift,1); }

sub fresnalKm { fresnal(shift,shift,0); }

1;
__END__

=head1 NAME

Math::FresnalZone - Perl extension for calculating the Fresnel Zone Radius of a given distance and frequency

=head1 SYNOPSIS

  use Math::FresnalZone;
  use Math::FresnalZone qw(fresnal fresnalMi fresnalKm);

=head1 DESCRIPTION

The arguments are:

   0 - distance in kilometers or miles (default is 1), 
   1 - frequency in GHz (defualt 2.4), 
   2 - set to true to specify inputting miles and getting results in feet (default is 0 - IE kilometers/meters)

=head2 fresnal()

   my $fresnal_zone_radius_in_meters = fresnal(); # fresnal zone radius in meters for 1 kilometer at 2.4 GHz
   my $fzr_in_meters = fresnal(5); # fresnal zone radius in meters for 5 kilometers at 2.4 GHz
   my $fzr_in_meters = fresnal(5,4.8); # fresnal zone radius in meters for 5 kilometers at 4.8 GHz
   my $fzr_in_feet = fresnal(3,9.6,1); # fresnal zone in feet for 3 miles at 9.6 GHz

If you are inputting Kilometers the result is in meters (these 3 calls have identical results):

   fresnal($Km,$GHz);
   fresnalKm($Km,$GHz); # see documentaion below for info about fresnalKm()
   fresnal($Km,$GHz,0);

If you are inputting Miles (by specifying a true value as the 3rd argument) the result is in feet (these 2 calls have identical results)

   fresnal($Mi,$GHz,1);
   fresnalMi($Mi,$GHz); # see documentaion below for info about fresnalMi()

=head2 fresnalKm()

You can use this to make it easier to avoid ambiguity if are working in kilometers/meters.
It takes the first two arguments only: distance in kilometers and frequency in GigaHertz

 my $fzr_in_meters = fresnalKm($Km,$GHz);

=head2 fresnalMi()

You can use this to make it easier to avoid ambiguity if are working in miles/feet.
It takes the first two arguments only: distance in miles and frequency in GigaHertz

 my $fzr_in_feet = fresnalMi($Mi,$GHz);

=head2 EXPORT

None by default. You can export any of the 3 functions as in the synopsis example.

=head2 VARIABLES

These variables are used when using miles/feet instead of kilometers/meters to modify the input for the formula and the output for the user:

   $Math::FresnalZone::KILOMETERS_IN_A_MILE  (Default is 1.609344)
   $Math::FresnalZone::FEET_IN_A_METER (Defualt is 3.280839)

Feel free to change them if you need more or less than six decimal places and/or want really inaccurate results :)

=head1 SEE ALSO

To find out more about the fresnal zone (pronounced fray-NELL) you can google the man who this formula/zone is named after to learn more: Augustin Jean Fresnel.

Mr. Fresnel was a French physicist who supported the wave theory of light, investigated polarized light, 
and developed a compound lens for use in lighthouses (IE the "Fresnel lens") (1788-1827).

Also googling the phrase "Fresnal Zone" turns up some interesting glossary refernces to what the fresnal zone is.

Here is a link to an image illustrating what a fresnal zone is and the formula:
L<http://drmuey.com/images/fresnalzone.jpg>

=head1 AUTHOR

Daniel Muey, L<http://drmuey.com/cpan_contact.pl> 

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Daniel Muey

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
