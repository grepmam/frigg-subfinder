package Frigg::modules::passive::DNSAggregators::Engine;

use strict;
use warnings;

use HTTP::Tiny;
use HTML::TreeBuilder;

use Frigg::utils::Validators;


sub new {

    my $class = shift;

    my $self = { _domain => undef };
    $self->{_services} = {
        osint => sub { $self->_extract_from_osint },
        hackertarget => sub { $self->_extract_from_hackertarget }
    };

    return bless $self, $class;

}


sub set_domain {

    my ( $self, $domain ) = @_;
    die "[x] Domain is not valid.\n" unless Frigg::utils::Validators::domain_is_valid( $domain );
    $self->{_domain} = $domain;
    return;

}


sub run {
    
    my ( $self, $service ) = @_;

    my $service_exists = exists $self->{_services}{$service};
    die "[x] Service does not exists.\n" unless $service_exists;

    print "\n[*] Searching subdomains...\n\n";
    
    my $results = 0;
    my @subdomains = @{ $self->{_services}{$service}->() };

    if ( @subdomains ) {

        foreach my $subdomain (@subdomains) {
            print "$subdomain\n";
            $results += 1;
        }

        print "\n[+] Total subdomains found: $results\n";

    } else { print "[x] No results. The service may have stopped working.\n"; }

    return;

}


sub _extract_from_osint {

    my $self = shift;
    my $url = 'https://osint.sh/subdomain/';
    my @subdomains = ();

    my $response = HTTP::Tiny->new->post_form(
        $url, { domain => $self->{_domain} }
    );

    if ( $response->{success} ) {

        my $tree = HTML::TreeBuilder->new;
        my $content = $response->{content};
        $tree->parse( $content );

        foreach my $td_tag ($tree->look_down('data-th', 'Subdomain')){
            my $a_tag = $td_tag->look_down('target', '_blank');
            push @subdomains, $a_tag->as_text;
        }

    }

    return \@subdomains;

}


sub _extract_from_hackertarget {

    my $self = shift;
    my $domain = $self->{_domain};
    my $url = "https://api.hackertarget.com/hostsearch/?q=$domain";
    my @subdomains;

    my $response = HTTP::Tiny->new->get($url);

    if ( $response->{success} ) {
        @subdomains = ($response->{content}) ? split /,.*\n/, $response->{content} : ();
    }

    return \@subdomains;

}


1;
