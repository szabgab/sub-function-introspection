use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use Test::More;
use Sub::Function::Introspection qw(get_signature);


sub no_sig {}
sub empty() {}
sub one_scalar($name) {}

is get_signature(\&no_sig), undef;
is_deeply get_signature(\&empty), [];
is_deeply get_signature(\&one_scalar), ['$name'];



done_testing;
