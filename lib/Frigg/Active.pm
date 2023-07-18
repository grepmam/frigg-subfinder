package Frigg::Active;

use strict;
use warnings;

use Frigg::Globals;
use Frigg::helpers::Common;


sub run {

    my $command = shift @ARGV;

    my $cli = Frigg::CLI->new;
    $cli->set_type_command( 'subcommand' );
    $cli->add_command( 'module', sub { process_module_command() } );
    $cli->add_command( 'list', sub { Frigg::helpers::Common::list_available_modules( 'active' ) } );
    $cli->add_command( 'help', sub { Frigg::helpers::Help::display_command_usage( 'active' ) } );
    $cli->run($command);

    return;

}


sub process_module_command {

    my $module = shift @ARGV;

    my $cli = Frigg::CLI->new;
    $cli->set_type_command( 'module' );
    $cli->add_command( 'BruteForce', sub { launch_brute_force_module() } );
    $cli->run( $module );

    return;

}


sub launch_brute_force_module {
    
    my $module = $MODULES_DIRECTORY . '/active/BruteForce/Options.pm';
    require $module;
    Frigg::modules::active::BruteForce::Options::main();

    return;

}


1;
