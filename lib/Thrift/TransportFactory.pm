package Thrift::TransportFactory;
use strict;
use warnings;

sub new { bless {}, shift }

sub getTransport {
    my ($self, $trans) = @_;
    return $trans;
}

1;
