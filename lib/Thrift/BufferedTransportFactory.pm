package Thrift::BufferedTransportFactory;
use strict;
use warnings;
use base qw/Thrift::TransportFactory/;

use Thrift::BufferedTransport;

sub getTransport {
    my ($self, $trans) = @_;
    return Thrift::BufferedTransport->new($trans);
}

1;
