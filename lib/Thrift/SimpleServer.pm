package Thrift::SimpleServer;
use strict;
use warnings;
use base qw/Class::Accessor::Fast/;

use Thrift;
use Thrift::BinaryProtocolFactory;
use Thrift::TransportFactory;

__PACKAGE__->mk_accessors(qw/processor serverTransport transportFactory protocolFactory/);

sub new {
    my ($class, @args) = @_;
    my $self  = $class->SUPER::new;

    $self->processor       ( $args[0] );
    $self->serverTransport ( $args[1] );
    $self->transportFactory( $args[2] || Thrift::TransportFactory->new );
    $self->protocolFactory ( $args[3] || Thrift::BinaryProtocolFactory->new );

    bless $self, $class;
}

sub serve {
    my $self = shift;
    $self->serverTransport->listen;
    while (1) {
        my $client = $self->serverTransport->accept or die Thrift::TException->new($!);
        my $trans = $self->transportFactory->getTransport($client);
        my $prot  = $self->protocolFactory->getProtocol($trans);

        eval {
            while (1) { $self->processor->process( $prot, $prot ) }
        };
        if (my $e = $@) {
            ## NOTE: These exceptions are not implemented yet.
            if ($e->isa('Thrift::TTransportException') or $e->isa('Thrift::TProtocolException')) {
                warn $e->{message};
            } else {
                $trans->close;
            }
        }
    }
    $self->serverTransport->close;
}

1;
