package Frigg::helpers::Common;

use strict;
use warnings;

use Frigg::utils::File;
use Frigg::Globals;


sub list_available_modules {

    my $mode = shift;

    my $directory = $MODULES_DIRECTORY . "/$mode";
    my $entries = Frigg::utils::File::get_entries_from_a_directory( $directory );
    my @modules = @{ Frigg::utils::File::get_directories_from_entries( $entries ) };

    print qq|

    Available modules
    -----------------

|;

    foreach my $module (@modules) {
        print "    $module\n";
    }

    print "\n";

    return;

}


1;
