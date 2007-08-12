# CPAN::Testers - QA of CPAN distributions via cross-platform testing
# Copyright (c) 2007 Adam J. Foxson and the CPAN Testers. All rights reserved.

# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

package CPAN::Testers;

use strict;
use vars qw($VERSION);

$VERSION = '0.02';

local $^W = 1;

=head1 NAME

CPAN::Testers - QA of CPAN distributions via cross-platform testing

=head1 SYNOPSIS

With the explosive growth and increased interest in the CPAN Testers, it was
felt useful to create this namespace placeholder to house the newly
architected next-generation CPAN Testers stack, which is now in development.
This namespace also provides for the consolidation of related work under one
unified and easily identifiable umbrella. Co-maint permissions in this
namespace are freely granted to anyone working on any area of the CPAN Testers
infrastructure.

=head1 DESCRIPTION

Started in 1998 by Graham Barr and Chris Nandor, the CPAN Testers exist to
provide quality assurance of CPAN distributions via cross-platform testing with
many versions of perl. Some of our goals include the increase of portability of
CPAN distributions and to provide authors with helpful feedback.

Nowadays, it's quite effortless to get involved--even casually--with mature
support for CPAN Testing with both CPAN and CPANPLUS. Testing methods ranging
from manual to automatic are available.

There are many distributions that comprise the CPAN Testers stack (please
forgive my poor artwork). The current architecture is as follows:

                  [POE-Component-CPAN-YACSmoke]
[cpantest]                     |
     \                  [CPAN-YACSmoke]
      \                   (CPANPLUS)
       \                     /
        \  [CPAN-Reporter]  /
         \     (CPAN)      /
          \      |        /
           [Test-Reporter]
                 |
              [SMTP]
                 |
       [cpan-testers@perl.org] 
            (Data Store)
                 |
[nntp://nntp.perl.org/perl.cpan.testers]
          |                       \  
  [CPAN-WWW-Testers-Generator]  [cpanstats]
          |                        |
     [CPAN-WWW-Testers]    [http://perl.grango.org/]
          |
 [http://cpantesters.perl.org/]

Test::Reporter is the delivery mechanism for the test report data, as
provided by one of its upstream constituents. A transport is then invoked to
submit the test report to the cpan-testers@perl.org mailing list. The mailing
list is the current de facto data store for the test reports. From there,
web-based presentation of the reports are provided courtesy of the
CPAN-WWW-Testers and CPAN-WWW-Testers-Generator distributions, and web-based
statistics are provided courtesy of cpanstats.

Improvements to this architecture are currently in discussion. Plans for
abstracting discrete functionality (parsing, grading, transports, etc.) into
separate distributions within this namespace are in progress. Additionally, we
are working on an HTTP transport for the submission of test reports at the
request of the perl.org folks, Adam Kennedy, and others.

For more information on the CPAN Testers please visit the links below:

=over 4

=item * L<http://cpantesters.perl.org/>

CPAN Testers reports

=item * L<http://perl.grango.org/>

CPAN Testers statistics

=item * L<http://cpantest.grango.org/>

The CPAN Testers Wiki

=item * L<http://lists.cpan.org/showlist.cgi?name=cpan-testers>

The cpan-testers mailing list

=item * L<http://cpantest.grango.org/cpantester/>

A presentation entitled "How to be a CPAN Tester" created by Barbie and David
Golden

=item * L<http://use.perl.org/articles/06/11/08/1256207.shtml>

A short tutorial entitled "Become a CPAN Tester with CPAN::Reporter" created
by David Golden

=item * L<http://www.perl.com/pub/a/2002/04/30/cpants.html>

An article entitled "Becoming a CPAN Tester with CPANPLUS" created by Audrey
Tang

=back

=head1 CAVEATS

This is the second draft of this document. Undoubtedly, there may be various
bits that need some adjustments. Feedback is most welcome.

=head1 COPYRIGHT

Copyright (c) 2007 Adam J. Foxson and the CPAN Testers. All rights reserved.

=head1 LICENSE

This program is free software; you may redistribute it
and/or modify it under the same terms as Perl itself.

=head1 SEE ALSO

=over 4

=item * L<http://cpants.perl.org/>

CPANTS: The CPAN Testing Service. A related, yet distinct, project aimed at
providing some sort of quality measure (called "Kwalitee") and lots of metadata
for all distributions on CPAN

=item * L<http://lists.cpan.org/showlist.cgi?name=perl-qa>

Special thanks to the members of the perl-qa mailing list for providing
valuable insights and suggestions over the years

=item * L<http://search.cpan.org/dist/CPAN-Reporter/>

=item * L<http://search.cpan.org/dist/CPAN-YACSmoke/>

=item * L<http://search.cpan.org/dist/CPAN-WWW-Testers/>

=item * L<http://search.cpan.org/dist/CPAN-WWW-Testers-Generator/>

=item * L<http://search.cpan.org/dist/POE-Component-CPAN-YACSmoke/>

=item * L<http://search.cpan.org/dist/Test-Reporter/>

=item * L<http://perl.grango.org/cpanstats-latest.tar.gz>

=back

=head1 AUTHORS

Adam J. Foxson E<lt>F<afoxson@pobox.com>E<gt>, having been involved with the
CPAN Testers for over half a decade, is the principal author of Test::Reporter.

Thank you to David Golden and Barbie for their advice and suggestions on
improving this documentation.

=cut

1;
