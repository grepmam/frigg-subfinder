package Frigg::helpers::Version;

use strict;
use warnings;

use Frigg::Globals;


sub display_version {

    print sprintf "%s version %s-%s %s\n", SOFTWARE_NAME, VERSION, VERSION_STATUS, VERSION_NAME;
    return;

}


1;
