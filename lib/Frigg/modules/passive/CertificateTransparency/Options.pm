package Frigg::modules::passive::CertificateTransparency::Options;

use strict;
use warnings;

use Getopt::Long;

use Frigg::modules::passive::CertificateTransparency::Engine;


sub main {

    Getopt::Long::Configure 'pass_through', 'noauto_abbrev';

    my %args;

    GetOptions(
        \%args,
        'domain|d:s',
        'help|h'
    );

    die Frigg::helpers::Help::get_certificate_transparency_usage if !%args || $args{help};

    my $domain_is_defined = defined $args{domain} && $args{domain};
    die "[x] Domain not defined.\n" unless $domain_is_defined;

    run_certificate_transparency( $args{domain} );

    return;

}


sub run_certificate_transparency {

    my $domain = shift;

    my $ct = Frigg::modules::passive::CertificateTransparency::Engine->new;
    $ct->set_domain( $domain );
    $ct->run();

    return;

}


1;
