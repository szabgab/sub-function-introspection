package Sub::Function::Introspection;
use strict;
use warnings;

use Data::Dumper qw(Dumper);
use Exporter qw(import);

our $VERSION = '0.01';

our @EXPORT_OK = qw(get_signature);


# Based on https://stackoverflow.com/questions/63836449/how-do-i-get-the-signature-of-a-subroutine-in-runtime
sub get_signature {
    my ($code) = @_;

    use B::Deparse;
    my $source = B::Deparse->new->coderef2text($code);
    #print $source;

    my @source = split /\n/, $source;
    #print Dumper \@source;
    #print "LOG: $source[3]\n";
    #return if $source[3] !~ /use feature/;
    #return if $source[3] !~ /signatures/;
    return if $source[4] !~ /Too many arguments/;
    #return $source[4] =~ /Too few arguments/) {
    my @signature = ();
    for my $row (@source) {
        my ($sig) = $row =~ /my (\W\w+) = /;
        push @signature, $sig if $sig;
    }
    #return "Signature is (", join(",",@signature), ")\n";
    return \@signature;
    die 'Could not get the signature';
}

1;

=head1 NAME

Sub::Function::Introspection - get the subroutine signature

=head1 SYNOPSIS

   use strict;
   use warnings;
   use Sub::Function::Introspection qw(get_signature)

   # somewhere there is a subroutione defined with signature
   use feature 'signatures';
   no warnings 'experimental::signatures';
   sub function($name, %address) { }

   my @sigs = get_signature(\&function); # ('$name', '%address')

=head1 LICENCE

Copyright 2021 Gabor Szabo, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl 5.20.0.

=cut

