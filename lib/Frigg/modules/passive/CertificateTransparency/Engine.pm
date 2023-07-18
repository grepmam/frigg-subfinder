package Frigg::modules::passive::CertificateTransparency::Engine;

use strict;
use warnings;
use HTTP::Tiny;
use JSON qw(decode_json);

use Frigg::utils::Validators;


sub new {

    my $class = shift;
    return bless { _domain => undef }, $class;

}


sub set_domain {

    my ($self, $domain) = @_;
    die "[x] Domain is not valid.\n" unless Frigg::utils::Validators::domain_is_valid( $domain );
    $self->{_domain} = $domain;
    return;

}


sub run {
    my $self = shift;
    my $domain = $self->{_domain};

    my $certificates = $self->_get_certificates();

    print "Subdomains in certificates: $domain\n\n";

    if (@$certificates) {
        foreach my $certificate (@$certificates) {
            print "issuer_ca_id: $certificate->{issuer_ca_id}\n";
            print "common_name: $certificate->{common_name}\n";
            print "name_value: $certificate->{name_value}\n\n\n";
        }
    } else {
        print "[x] No results\n\n";
    }

    return;

}


sub _get_certificates {

    my $self = shift;
    my $domain = $self->{_domain};
    my $url = "https://crt.sh/?q=$domain&output=json";
    my $response = HTTP::Tiny->new->get($url);

    my @certificates;

    if ($response->{success}) {
        my @certificates_json = @{ decode_json($response->{content}) };

        foreach my $cert (@certificates_json) {
            push @certificates, {
                issuer_ca_id => $cert->{issuer_ca_id},
                common_name => $cert->{common_name},
                name_value => $cert->{name_value}
            };
        }
    }

    return \@certificates;

}


1;
