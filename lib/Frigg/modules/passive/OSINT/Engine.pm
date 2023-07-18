package Frigg::modules::passive::OSINT::Engine;

use strict;
use warnings;
use HTTP::Tiny;
use JSON qw(decode_json);

use Frigg::utils::Validators;


sub new {

    my $class = shift;

    my $self = { 
        _domain => undef,
        _pages  => 2
    };
    $self->{_engines} = { yahoo => sub { $self->_extract_from_yahoo } };

    return bless $self, $class;

}


sub set_domain {

    my ( $self, $domain ) = @_;
    die "[x] Domains is not valid\n" unless Frigg::utils::Validators::domain_is_valid( $domain );
    $self->{_domain} = $domain;
    return;

}


sub set_pages {

    my ( $self, $pages ) = @_;
    die "[x] The number of pages is invalid \n" unless Frigg::utils::Validators::number_pages_is_valid( $pages );
    $self->{_pages} = $pages; 
    return;

}


sub run {

    my ( $self, $engine ) = @_;

    my $engine_exists = exists $self->{_engines}{$engine};
    die "[x] Engine does not exists.\n" unless $engine_exists;

    print "\n[*] Searching subdomains in $engine...\n\n";

    my $results = 0;
    my @subdomains = @{ $self->{_engines}{$engine}->() };

    if ( @subdomains ) {

        foreach my $subdomain (@subdomains) {
            print "$subdomain\n";
            $results += 1;
        }

        print "\n[+] Total subdomains found in $engine: $results\n";

    } else { 
        print "[x] No results.\n"; 
    }

    return;

}


sub _extract_from_yahoo {

    my $self = shift;
    
    my $domain = $self->{_domain};
    my $dork = "site:$domain";
    my $pages = $self->{_pages};

    my %subdomains;

    for my $page (1..$pages) {
        
        my $url = "https://search.yahoo.com/search?p=$dork&b=$page";
        my $response = HTTP::Tiny->new->get($url);
        
        if ($response->{success}) {
            my $content = $response->{content};
            my @items = $content =~ m/([a-z0-9]+\.$domain)/g;

            foreach my $subdomain (@items) {
                $subdomains{$subdomain} = 1;
            }

        }

    }

    return [ keys %subdomains ];

}


1;
