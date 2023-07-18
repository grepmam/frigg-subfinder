package Frigg::Globals;

use strict;
use warnings;

use FindBin;
use Exporter qw(import);


our @EXPORT = qw(

    SOFTWARE_NAME
    VERSION VERSION_NAME VERSION_STATUS 
    CREATOR CONTACT
    $APP_DIRECTORY $LIB_DIRECTORY
    $MODULES_DIRECTORY $EXTRAS_DIRECTORY

);


use constant {

    SOFTWARE_NAME     => 'Frigg Enumeration',

    VERSION           => 'v1.0.0',
    VERSION_NAME      => 'Guardian',
    VERSION_STATUS    => 'stable',

    CREATOR           => 'Grepmam',
    CONTACT           => 'https://github.com/grepmam'

};

our $APP_DIRECTORY = $FindBin::Bin;
our $LIB_DIRECTORY = $APP_DIRECTORY . '/lib/Frigg';
our $MODULES_DIRECTORY = $LIB_DIRECTORY . '/modules';
our $EXTRAS_DIRECTORY = $APP_DIRECTORY . '/extras';

1;
