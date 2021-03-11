use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use Test::More;
use Sub::Function::Introspection qw(get_signature);


sub empty() {}
sub one_scalar($name) {}

is_deeply get_signature(\&empty), [];
is_deeply get_signature(\&one_scalar), ['$name'];



done_testing;
