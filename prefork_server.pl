#!/usr/bin/env perl
use strict;
use warnings;
use lib 'gen-perl';
use lib 'lib';

package HelloHandler;
use Hello;
use base qw/HelloIf/;

sub new { bless {}, shift }

sub hello {
    my ($self, $name) = @_;
    return sprintf "Hello, %s", $name;
}

package main;

use Thrift::ServerSocket;
use Thrift::PreforkServer;

my $processor = HelloProcessor->new( HelloHandler->new );
my $transport = Thrift::ServerSocket->new(9090);

my $server = Thrift::PreforkServer->new( $processor, $transport );
$server->serve;
