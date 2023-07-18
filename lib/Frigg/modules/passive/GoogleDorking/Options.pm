package Frigg::modules::passive::GoogleDorking::Options;

use strict;
use warnings;

use Getopt::Long;

use Frigg::modules::passive::GoogleDorking::Engine;


sub main {

    Getopt::Long::Configure 'pass_through', 'noauto_abbrev';

    my %args;

    GetOptions(
        \%args,
        'domain|d:s',
        'apikey|a:s',
        'sengid|s:s',
        'pages|p:s',
        'help|h'
    );

    die Frigg::helpers::Help::get_google_dorking_usage if !%args || $args{help};

    my $domain_is_defined = defined $args{domain} && $args{domain};
    die "[x] Domain is not defined\n" unless $domain_is_defined;

    my $api_key_is_defined = defined $args{apikey} && $args{apikey};
    die "[x] API Key is not defined\n" unless $api_key_is_defined;

    my $sengid_is_defined = defined $args{sengid} && $args{sengid};
    die "[x] Search Engine ID is not defined\n" unless $sengid_is_defined;

    run_google_dorking(
        $args{domain}, 
        $args{apikey},
        $args{sengid},
        $args{pages}
    );

    return;

}


sub run_google_dorking {

    my ( $domain, $apikey, $sengid, $pages ) = @_;

    my $gd = Frigg::modules::passive::GoogleDorking::Engine->new;
    $gd->set_domain( $domain );
    $gd->set_apikey( $apikey );
    $gd->set_search_engine_id( $sengid );
    $gd->set_pages( $pages ) if defined $pages;
    $gd->run();

    return;

}


1;
