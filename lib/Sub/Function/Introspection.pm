package Sub::Function::Introspection;
use strict;
use warnings;

use Exporter qw(import);

our @EXPORT_OK = qw(get_signature);


# Based on https://stackoverflow.com/questions/63836449/how-do-i-get-the-signature-of-a-subroutine-in-runtime
sub get_signature {
    my ($code) = @_;

    use B::Deparse;
    my $source = B::Deparse->new->coderef2text($code);
    #print $source;

    my @source = split /\n/, $source;
    #if ($source[2] =~ /use feature 'signatures'/ &&
    #        $source[3] =~ /Too many arguments/ &&
    #        $source[4] =~ /Too few arguments/) {
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

