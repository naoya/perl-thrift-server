#!/usr/bin/env perl
use strict;
use warnings;
use lib 'gen-perl';

use Thrift;
use Thrift::BinaryProtocol;
use Thrift::Socket;

use Hello;

my $transport = Thrift::Socket->new('localhost', 9090);
my $client = HelloClient->new( Thrift::BinaryProtocol->new($transport) );

eval {
    $transport->open();
    printf "%s\n", $client->hello("naoya");
    $transport->close();
};

if (my $e = $@) {
    warn $e->{message};
}
