package Thrift::ServerSocket;
use strict;
use warnings;
use base qw/Thrift::ServerTransport Class::Accessor::Fast/;

__PACKAGE__->mk_accessors(qw/port handle/);

use IO::Socket;
use Thrift::Socket;

sub new {
    my $class = shift;
    my $self = $class->SUPER::new;
    $self->port( shift || 9090 );
    bless $self, $class;
}

sub listen {
    my $self = shift;
    $self->handle(
        IO::Socket::INET->new(
            LocalPort => $self->port,
            Listen    => SOMAXCONN,
            Proto     => 'tcp',
            Reuse     => 1,
        )
    );
}

sub accept {
    my $self = shift;
    if (defined $self->handle) {
        my $sock = $self->handle->accept;

        my $trans = Thrift::Socket->new;
        $trans->setHandle( $sock );

        return $trans;
    }
    return;
}

package Thrift::Socket;
use IO::Select;

sub setHandle {
    my ($self, $sock) = @_;
    $self->{handle} = IO::Select->new( $sock );
}

1;
