package Frigg::Passive;

use strict;
use warnings;

use Frigg::Globals;
use Frigg::helpers::Common;


sub run {

    my $command = shift @ARGV;

    my $cli = Frigg::CLI->new;
    $cli->set_type_command( 'subcommand' );
    $cli->add_command( 'module', sub { process_module_command() } );
    $cli->add_command( 'list', sub { Frigg::helpers::Common::list_available_modules( 'passive' ) } );
    $cli->add_command( 'help', sub { Frigg::helpers::Help::display_command_usage( 'passive' ) } );
    $cli->run($command);

    return;

}


sub process_module_command {

    my $module = shift @ARGV;

    my $cli = Frigg::CLI->new;
    $cli->set_type_command( 'module' );
    $cli->add_command( 'CertificateTransparency', sub { launch_certificate_transparency_module() } );
    $cli->add_command( 'DNSAggregators', sub { launch_dns_aggregators_module() } );
    $cli->add_command( 'GoogleDorking', sub { launch_google_dorking_module() } );
    $cli->add_command( 'OSINT', sub { launch_osint_module() } );
    $cli->run($module);

    return;

}


sub launch_certificate_transparency_module {
    
    my $module = $MODULES_DIRECTORY . '/passive/CertificateTransparency/Options.pm';
    require $module;
    Frigg::modules::passive::CertificateTransparency::Options::main();

    return;

}


sub launch_dns_aggregators_module {

    my $module = $MODULES_DIRECTORY . '/passive/DNSAggregators/Options.pm';
    require $module;
    Frigg::modules::passive::DNSAggregators::Options::main();

    return;

}


sub launch_google_dorking_module {

    my $module = $MODULES_DIRECTORY . '/passive/GoogleDorking/Options.pm';
    require $module;
    Frigg::modules::passive::GoogleDorking::Options::main();

    return;

}


sub launch_osint_module {

    my $module = $MODULES_DIRECTORY . '/passive/OSINT/Options.pm';
    require $module;
    Frigg::modules::passive::OSINT::Options::main();

    return;

}


1;
