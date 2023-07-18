package Frigg::modules::passive::OSINT::Options;

use strict;
use warnings;

use Getopt::Long;

use Frigg::modules::passive::OSINT::Engine;


sub main {

    Getopt::Long::Configure 'pass_through', 'noauto_abbrev';

    my %args;

    GetOptions(
        \%args,
        'domain|d:s',
        'engine|e:s',
        'pages|p:s',
        'help|h'
    );

    die Frigg::helpers::Help::get_osint_usage if !%args || $args{help};
 
    my $domain_is_defined = defined $args{domain} && $args{domain};
    die "[x] Domain not defined.\n" unless $domain_is_defined;
    
    my $engine_is_defined = defined $args{engine} && $args{engine};
    die "[x] Search Engine not defined.\n" unless $engine_is_defined;

    run_osint(
        $args{domain},
        $args{engine},
        $args{pages}
    );

    return;

}


sub run_osint {

    my ( $domain, $engine, $pages ) = @_;

    my $os = Frigg::modules::passive::OSINT::Engine->new;
    $os->set_domain( $domain );
    $os->set_pages( $pages ) if defined $pages;
    $os->run( $engine );

    return;

}


1;
