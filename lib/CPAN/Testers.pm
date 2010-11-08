# CPAN::Testers - QA of CPAN distributions via cross-platform testing
# Copyright (c) 2007-2010 Adam J. Foxson and the CPAN Testers. All rights 
# reserved.

# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

package CPAN::Testers;

use strict;
use vars qw($VERSION);

$VERSION = '0.03';

local $^W = 1;

=head1 NAME

CPAN::Testers - QA of CPAN distributions via cross-platform testing

=head1 SYNOPSIS

With the explosive growth and increased interest in the CPAN Testers over the 
last 5 years, it was felt useful to create this namespace placeholder to house
the re-architected next-generation CPAN Testers stack.

This namespace also provides for the consolidation of related work under one
unified and easily identifiable umbrella. Co-maintainer permissions in this
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


                                  [POE-Component-CPANPLUS-YACSmoke]
                                                  |
                [CPAN-Reporter]         [CPANPLUS-YACSmoke]
                   (CPAN)                   (CPANPLUS)
                       \                    /
                        \                  /
                         \                /
                          \              /
                           [Test-Reporter]
                                  |        
                                  |   CT2.0
                           ................
                           .   [HTTP]     .
                           .      |       .
                           .  [Metabase]  .
                           . (Data Store) .
                           ................
                                  |       
                                  |       
                     [CPAN-Testers-Data-Generator]
                                  |       
                             [cpanstats] 
                            (Data Store)
                            /          \
                           /            \
                          /              \
                         /                \
     [CPAN-Testers-WWW-Reports]    [CPAN-Testers-WWW-Statistics]    
               |                              |
 [http://wwww.cpantesters.org/]    [http://stats.cpantesters.org/]


This a rather simplistic view, but covers the basic flow of test reports into
the system, and how the 'cpanstats' database and the core websites are derived.

=head2 Smoke Clients

There are additional smokebot applications that sit beyond CPAN-Reporter and
CPANPLUS-YACSmoke, though all use the APIs provided by these hooks into the two
primary distribution installers, CPAN and CPANPLUS.

Previously there were standalone scripts, such as 'cpantest' included with 
CPANPLUS prior to v0.50, which used dedicated test capture code, specifically
for the purpose of CPAN Testers. As of CPANPLUS-0.50, this code was removed.
In its place a new distribution, CPAN-YACSmoke, was released incorporating
new test capture code utilising the new CPANPLUS API. 

In 2006 CPAN::Reporter was released, providing smoke testing support for 
CPAN.pm.

In 2008, with little work being done to bring CPAN-YACSmoke up to date with
the current CPANPLUS API, CPANPLUS-YACSmoke was release, building on the work
of CPAN-YACSmoke.

The current standard client interfaces for CPAN Testers smoke testing are now
CPAN-Reporter and CPANPLUS-YACSmoke.

In order to submit reports, the clients need to supply test results in a 
consistent form, so that the data store can parse them and store the relevant 
parts as necessary. The means to provide a consistent API and transport are 
provided by Test-Reporter, which includes the transport methods to submit to 
the appropriate data stores.

=head2 CPAN Testers 1.0

CPAN Testers report submissions began on a mailing list. In the early days 
reports were crafted by hand and sent via a mail client. With the design of
CPANPLUS, an automated tool was written to provide test reports that could then
be edited before sending. The transport mechanism was SMTP, as provided by 
Test-Reporter.

For many years this was adequate, with the SMTP transport layer sending reports
to the cpan-testers mailing list. The perl.org server which received the mails,
then provided a read only NNTP service to view the test reports.

In 2008 the number of testers was increasing, and the submission of reports
were increasing beyond initial expectations, with over 450,000 reports 
submitted in November 2009. The storage mechanism provided by NNTP on the 
perl.org servers, had long reached its limit and was no longer scaling with the 
level of reports being submitted. It was time for a change.

=head2 CPAN Testers 2.0

In 2008 the idea for an alternative storage mechanism for CPAN Testers reports
was mooted at the Olso QA Hackathon. Out of that came an idea now known as the
Metabase. It was the germ of the plan to move CPAN Testers to a HTTP report 
submission system. At the Birmingham QA Hackathon in 2009, work on the Metabase
and a HTTP gateway continued. In December 2009, the perl.org admins gave a 
deadline of 1st March 2010 to switch off SMTP submissions.

Test-Reporter, now provides a delivery mechanism for sending the test report 
data via a HTTP request, using Test::Reporter::Transport::Metabase, into the 
Metabase.

The Metabase is now the CPAN Testers 2.0 centralised data store. The Metabase
currently sits on an Amazon S3 server, and can cope with many more times the 
level of throughput than was previously seen with the SMTP delivery mechanism.

As over 1st September 2010, the old SMTP gateway to the old cpan-testers 
mailing list is now closed. 

=head2 The 'cpanstats' Database

The original 'cpantest' Database began life with a parser reading the NNTP 
feed once a day and storing metadata in an SQLite database, freely available
for all to use. 

In 2007 the CPAN Testers Statistics websites extended the parser and created 
the 'cpanstats' database, which contain more information necessary to drive the
statistical analysis. Also initially a SQLite database.

With the overhaul of the CPAN Testers websites in 2008, the 'cpanstats' 
database became the master database. While the SQLite database was still 
updated and provided for use by all, the master database was ported into a
MySQL database, with tables for uploads and further statistical analysis being
added.

The MySQL 'cpanstats' database now provides the following SQLite databases:

=over 4

=item * cpanstats.db

=item * uploads.db

=item * release.db

=back

=head2 The Websites

Prior to 2002 the CPAN Testers reports were available in their raw form via the
NNTP server. In 2002 a new site grouped together the list of reports for each
distribution uploaded to CPAN and each CPAN author. 

In 2007 the CPAN Testers Statistics site was launched to provide analysis of 
data regarding reports and to highlight trends in testing.

In 2008, the CPAN Testers websites started receiving an overhaul, with a 
complete facelift being unveiled in May 2009. The two primary websites, the
Reports and Statistics websites are now complimented by the Wiki, Blog, 
Development, Metabase, Dependencies, Matrix and Analysis websites, with the 
'cpanstats' database being used by many other sites for their own data 
analysis.

In 2010 with the launch of CT2.0 the NNTP feed is now depreciated. All reports
are now held on the cpantesters server, and can be viewed using their id or
guid in styled or raw formats.

Improvements to the CPAN Testers architecture are always in progress.

For more information on the CPAN Testers please visit the links below:

=head1 RESOURCES & LINKS

=head2 Websites

=over 4

=item * L<http://www.cpantesters.org/>

CPAN Testers Reports

=item * L<http://stats.cpantesters.org/>

CPAN Testers Statistics

=item * L<http://wiki.cpantesters.org/>

The CPAN Testers Wiki

=item * L<http://analysis.cpantesters.org/>

The CPAN Testers Analysis Site

=item * L<http://matrix.cpantesters.org/>

The CPAN Testers Matrix

=item * L<http://deps.cpantesters.org/>

The CPAN Testers Dependencies Site

=item * L<http://blog.cpantesters.org/>

The CPAN Testers Blog

=item * L<http://devel.cpantesters.org/>

The CPAN Testers Development Site

=item * L<http://metabase.cpantesters.org/>

The CPAN Testers Metabase Site

=back

=head2 Mailing Lists

=over 4

=item * L<http://lists.cpan.org/showlist.cgi?name=cpan-testers-discuss>

The cpan-testers-discuss mailing list.

=item * L<http://lists.cpan.org/showlist.cgi?name=cpan-uploads>

The cpan-uploads mailing list (read only).

=back

=head2 Articles & Presentations

=over 4

=item * L<http://wiki.cpantesters.org/cpantester/>

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

This is the third draft of this document. Undoubtedly, there may be various
bits that need some adjustments. Feedback is most welcome.

=head1 COPYRIGHT

Copyright (c) 2007-2010 Adam J. Foxson and the CPAN Testers. All rights 
reserved.

=head1 LICENSE

This program is free software; you may redistribute it and/or modify it under
the same terms as Perl itself.

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

=item * L<http://search.cpan.org/dist/CPAN-Testers-Data-Generator/>

=item * L<http://search.cpan.org/dist/CPAN-Testers-Data-Uploads/>

=item * L<http://search.cpan.org/dist/CPAN-Testers-WWW-Reports/>

=item * L<http://search.cpan.org/dist/CPAN-Testers-WWW-Statistics/>

=item * L<http://search.cpan.org/dist/CPANPLUS-YACSmoke/>

=item * L<http://search.cpan.org/dist/Metabase/>

=item * L<http://search.cpan.org/dist/POE-Component-CPANPLUS-YACSmoke/>

=item * L<http://search.cpan.org/dist/Test-Reporter/>

=item * L<http://devel.cpantesters.org/cpanstats-latest.tar.gz>

=back

=head1 AUTHORS

Adam J. Foxson E<lt>F<afoxson@pobox.com>E<gt>, having been involved with the
CPAN Testers for over half a decade, is the principal author of Test::Reporter.

Thank you to David Golden and Barbie for their advice and suggestions on
improving this documentation.

=cut

1;
