package Frigg::utils::Validators;

use strict;
use warnings;


sub domain_is_valid { 

    my $domain = shift;
    return $domain =~ m/^(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)+(?:[a-zA-Z]{2,63}|(?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.[a-zA-Z]{2,63})$/; 

}


sub number_pages_is_valid {

    my $pages = shift;
    return $pages =~ m/^[0-9]+$/;

}


1;
