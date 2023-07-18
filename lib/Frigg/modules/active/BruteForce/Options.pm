package Frigg::modules::active::BruteForce::Options;

use strict;
use warnings;

use Getopt::Long;

use Frigg::modules::active::BruteForce::Engine;


sub main {

    Getopt::Long::Configure 'pass_through', 'noauto_abbrev';

    my %args;

    GetOptions(
        \%args,
        'domain|d:s',
        'wordlist|w:s',
        #'output|o:s',
        'help|h'
    );

    die Frigg::helpers::Help::get_brute_force_usage if !%args || $args{help};

    my $domain_is_defined = defined $args{domain} && $args{domain};
    die "[x] Domain not defined.\n" unless $domain_is_defined;

    run_brute_force(
        $args{domain},
        $args{wordlist},
        #$args{output}
    );

    return;

}


sub run_brute_force {

    my ( $domain, $wordlist ) = @_;

    my $bf = Frigg::modules::active::BruteForce::Engine->new;
    $bf->set_domain( $domain );
    $bf->set_wordlist( $wordlist ) if defined $wordlist;
    #$bf->set_output( $output ) if defined $output;
    $bf->run();

    return;

}


1;
