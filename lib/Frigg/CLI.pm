package Frigg::CLI;

use strict;
use warnings;


sub new {

    my $class = shift;

    my $self = {
        _commands => {},
        _type     => 'command'
    };

    return bless $self, $class;

}


sub set_type_command {

    my ( $self, $type_command ) = @_;

    $self->{_type} = $type_command;

}


sub add_command {

    my ( $self, $name, $action ) = @_;

    $self->{_commands}{$name} = $action;

}


sub run {

    my ( $self, $command ) = @_;
    my $type = $self->{_type};

    die "\n[x] You must define a $type. Usage the $type 'help'.\n"
        unless $command;
    die "\n[x] '$command' $type does not exist. Usage the $type 'help'.\n" 
        unless exists $self->{_commands}{$command};

    $self->{_commands}{$command}->();

}


1;
