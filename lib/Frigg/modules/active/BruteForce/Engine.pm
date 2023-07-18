package Frigg::modules::active::BruteForce::Engine;

use strict;
use warnings;

use HTTP::Tiny;

use Frigg::utils::Validators;
use Frigg::Globals;


sub new {

    my $class = shift;
    
    return bless {

        _domain   => undef,
        _wordlist => $EXTRAS_DIRECTORY . '/wordlists/subdomains.txt',
        #_output   => $APP_DIRECTORY

    }, $class;

}


sub set_domain {

    my ( $self, $domain ) = @_;
    die "[x] Domain is not valid \n" unless Frigg::utils::Validators::domain_is_valid( $domain );
    $self->{_domain} = $domain;

    return;

}


sub set_wordlist {

    my ( $self, $wordlist ) = @_;
    die "[x] File not found \n" unless Frigg::utils::File::exists( $wordlist );
    $self->{_wordlist} = $wordlist;
    return;

}


#sub set_output {
#
#    my ( $self, $output ) = @_;
#    $self->{_output} = $output;
#    return;
#
#}


sub run {

    my $self = shift;
    my @subdomains = @{Frigg::utils::File::get_lines( $self->{_wordlist} )};
    my $results = 0;

    print "\n[*] Searching subdomains...\n\n";

    foreach my $subdomain ( @subdomains ){
        my $url = "http://$subdomain.$self->{_domain}";
        if ( $self->_subdomain_is_valid( $url ) ) {
            print "$url\n";
            $results += 1;
        }
    }

    print "\n[+] Total subdomains found: $results\n";

    return;

}


sub _subdomain_is_valid {
    
    my ( $self, $url ) = @_;
    my $response = HTTP::Tiny->new->get($url);

    return $response->{success};

}


1;
