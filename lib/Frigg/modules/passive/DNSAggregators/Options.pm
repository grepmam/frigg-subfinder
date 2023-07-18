package Frigg::modules::passive::DNSAggregators::Options;

use strict;
use warnings;

use Getopt::Long;

use Frigg::modules::passive::DNSAggregators::Engine;


sub main {

    Getopt::Long::Configure 'pass_through', 'noauto_abbrev';

    my %args;

    GetOptions(
        \%args,
        'domain|d:s',
        'service|s:s',
        'help|h'
    );

    die Frigg::helpers::Help::get_dns_aggregators_usage if !%args || $args{help};

    my $domain_is_defined = defined $args{domain} && $args{domain};
    die "[x] Domain not defined.\n" unless $domain_is_defined;

    my $service_is_defined = defined $args{service} && $args{service};
    die "[x] Service not defined.\n" unless $service_is_defined;

    run_dns_aggregators( $args{domain}, $args{service} );

    return;

}


sub run_dns_aggregators {

    my ( $domain, $service ) = @_;

    my $da = Frigg::modules::passive::DNSAggregators::Engine->new;
    $da->set_domain( $domain );
    $da->run( $service );

    return;

}


1;
