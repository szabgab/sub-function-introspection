use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use Test::More;
use Sub::Function::Introspection qw(get_signature);


sub no_sig {}
sub empty() {}
sub one_scalar($name) {}
sub three_scalars($name, $age, $address) {}

sub one_array(@names) {}

is get_signature(\&no_sig), undef;
is_deeply get_signature(\&empty), [];
is_deeply get_signature(\&one_scalar), ['$name'];
is_deeply get_signature(\&three_scalars), ['$name', '$age', '$address'];
#is_deeply get_signature(\&one_array), ['@names'];



done_testing;
