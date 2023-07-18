package Frigg::helpers::Help;

use strict;
use warnings;


sub display_main_usage {

    print qq|

    Usage: frigg [command]


    Available Commands
    ------------------

    active [subcommand]     Use Active mode modules
    passive [subcommand]    Use Passive mode modules
    version                 Display version
    help                    Display this help
\n|;

    return;

}


sub display_command_usage {

    my $command = shift;

    print qq|

    Usage: frigg $command [subcommand]


    Available Commands
    ------------------

    module [module_name]  Execute module.
    list                  List available execution modules
    help                  Display this help


    Examples
    --------

    frigg active list

    \n|;

    return;

}


sub get_brute_force_usage {

    return qq|

    Options
    -------

    --domain/-d DOMAIN          Domain name
    --wordlist/-w WORDLIST      Wordlist file
    --output/-o OUTPUT_FILE     Output file
    --help/-h                   Displat this help


    Examples
    --------

    frigg active module BruteForce -d google.com

    \n|;

} 


sub get_certificate_transparency_usage {

    return qq|

    Options
    -------

    --domain/-d DOMAIN   Domain name
    --help/-h            Displat this help


    Examples
    --------

    frigg passive module CertificateTransparency -d google.com

    \n|;

}


sub get_dns_aggregators_usage {

    return qq|

    Options
    -------
    
    --domain/-d DOMAIN    Domain name
    --service/-s SERVICE  Service name
    --help/-h             Display this help

    Examples
    --------

    frigg passive module DNSAggregators -d google.com -s osint

    Warning
    -------

    This module depends on online services so it can fail.

    \n|;

}


sub get_google_dorking_usage {

    return qq|

    Options
    -------
    
    --domain/-d DOMAIN    Domain name
    --apikey/-a API_KEY   Google Service API Key
    --sengid/-s SENGID    Search Engine ID
    --help/-h             Display this help

    Examples
    --------

    frigg passive module GoogleDorking -d google.com -a 51ffSyC0po23kn-tV_MMKsZcxjZlVCFGh0bAjkl -s 99071zf53b5d990cf

    Warning
    -------

    This module is limited to a certain number of requests per day in an Google free account.

    \n|;

}


sub get_osint_usage {

    return qq|

    Options
    -------
    
    --domain/-d DOMAIN    Domain name
    --engine/-e ENGINE    Search Engine
    --help/-h             Display this help

    Examples
    --------

    frigg passive module GoogleDorking -d google.com -e yahoo

    \n|;

}


1;
