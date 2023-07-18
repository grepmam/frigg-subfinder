package Frigg::modules::passive::GoogleDorking::Engine;

use strict;
use warnings;
use HTTP::Tiny;
use JSON qw(decode_json);

use Frigg::utils::Validators;


sub new {

    my $class = shift;

    return bless {

        _domain => undef,
        _apikey => undef,
        _sengid => undef,
        _pages  => 2

    }, $class;

}


sub set_domain {

    my ($self, $domain) = @_;
    die "[x] Domains is not valid\n" unless Frigg::utils::Validators::domain_is_valid( $domain );
    $self->{_domain} = $domain;
    return;

}


sub set_apikey {

    my ($self, $apikey) = @_;
    $self->{_apikey} = $apikey;
    return;

}


sub set_search_engine_id {

    my ($self, $sengid) = @_;
    $self->{_sengid} = $sengid;
    return;

}


sub set_pages {

    my ( $self, $pages ) = @_;
    die "[x] The number of pages is invalid \n" unless Frigg::utils::Validators::number_pages_is_valid( $pages );
    $self->{_pages} = $pages; 
    return;

}


sub run {

    my $self = shift;
    my $domain = $self->{_domain};

    print "[*] Searching subdomains in: $domain\n\n";

    my @subdomains = @{ $self->_get_subdomains() };

    if (@subdomains) {
        print "$_\n" foreach @subdomains;
    } else {
        print "No results\n\n";
    }

    return;

}


sub _get_subdomains {

    my $self = shift;
    
    my $domain = $self->{_domain};
    my $apikey = $self->{_apikey};
    my $sengid = $self->{_sengid};
    my $pages = $self->{_pages};
    my $dork = "site:*.$domain";

    my %subdomains;

    for my $page (1..$pages) {

        my $url = "https://www.googleapis.com/customsearch/v1?key=$apikey&cx=$sengid&q=$dork&start=$pages";
        my $response = HTTP::Tiny->new->get($url);

        if ($response->{success}) {

            my $content = $response->{content};
            my $searches_json = decode_json($content);
            my @items = @{ $searches_json->{items} };

            foreach my $search (@items) {
                my $subdomain = $search->{displayLink};
                $subdomains{$subdomain} = 1;
            }

        }

    }

    return [keys %subdomains];

}


1;
