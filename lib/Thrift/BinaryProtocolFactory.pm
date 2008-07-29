## TProtoclFactory seems buggy
package Thrift::BinaryProtocolFactory;
use strict;
use warnings;
use Thrift::Protocol;
use base qw/TProtocolFactory/;

use Thrift::BinaryProtocol;

sub getProtocol {
    my ($self, $trans) = @_;
    return Thrift::BinaryProtocol->new( $trans );
}

1;
