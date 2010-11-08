use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME' => 'CPAN::Testers',
    'PM' => {
        'lib/CPAN/Testers.pm' => '$(INST_LIBDIR)/Testers.pm',
    },
    'PREREQ_PM' => {},
    'VERSION_FROM' => 'lib/CPAN/Testers.pm',
    'dist' => {
        'COMPRESS' => 'gzip --best',
        'SUFFIX' => '.gz',
    },
    EXE_FILES => [],
    (   
        $] >= 5.005 ?  (   
            ABSTRACT_FROM => 'lib/CPAN/Testers.pm',
            AUTHOR => 'Adam J. Foxson <afoxson@pobox.com>, Barbie <barbie@missbarbell.co.uk>, David Golden <dagolden@cpan.org>',
        ) : ()
    ),
    'clean' => {
        'FILES' => '',
    },
    LICENSE => 'perl',
);
