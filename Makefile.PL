use strict;
use warnings;
require 5.008001;
use ExtUtils::MakeMaker;

my $developer = -f '.gitignore';
ExtUtils::MakeMaker->VERSION(6.98) if $developer;

my %WriteMakefileArgs = (
    NAME                => 'Sub::Function::Introspection',
    VERSION_FROM        => 'lib/Sub/Function/Introspection.pm',
    ABSTRACT_FROM       => 'lib/Sub/Function/Introspection.pm',
    AUTHOR              => 'Gabor Szabo <gabor@szabgab.com>',
    LICENSE             => 'perl_5',

    META_MERGE => {
        'meta-spec' => { version => 2 },
        dynamic_config => 1,
        resources => {
            repository => {
                url => 'https://github.com/szabgab/sub-function-introspection.git',
                web => 'https://github.com/szabgab/sub-function-introspection',
                type => 'git',
            },
            bugtracker => {
                web => 'https://github.com/szabgab/sub-function-introspection/issues',
            },
        },
        x_contributors => [
            'Gabor Szabo <gabor@szabgab.com>',
        ],
    },

    META_ADD => {
        'meta-spec' => { version => 2 },
        prereqs => {
            configure => {
                requires => {
                    'ExtUtils::MakeMaker' => '0',
                },
            },
            runtime => {
                requires => {
                    'perl'                  => '5.008001',
                },
            },
            test => {
                requires => {
                    'Test::More'            => '0.78',
                },
            },
        },
    },
);

my $eumm_version  = eval $ExtUtils::MakeMaker::VERSION;

for (qw(configure build test runtime)) {
    my $key = $_ eq 'runtime' ? 'PREREQ_PM' : uc $_.'_REQUIRES';
    next unless exists $WriteMakefileArgs{META_ADD}{prereqs}{$_}
             or exists $WriteMakefileArgs{$key};
    my $r = $WriteMakefileArgs{$key} = {
        %{$WriteMakefileArgs{META_ADD}{prereqs}{$_}{requires} || {}},
        %{delete $WriteMakefileArgs{$key} || {}},
    };
    defined $r->{$_} or delete $r->{$_} for keys %$r;
}



WriteMakefile(%WriteMakefileArgs);
