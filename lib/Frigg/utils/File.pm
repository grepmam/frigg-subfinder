package Frigg::utils::File;

use strict;
use warnings;

use File::Spec;


sub get_lines {

    my $file = shift;
    my @lines;

    open(my $fh, '<', $file) or die 'File error';

    while (my $line = <$fh>)  {
        chomp $line;
        push @lines, $line;
    }

    close $fh;

    return \@lines;

}


sub exists {

    my $file = shift;

    return -e $file;

}


sub get_entries_from_a_directory {

    my $directory = shift;

    opendir(my $dh, $directory) or die "Could not open directory: $!";
    my @entries = readdir($dh);
    closedir($dh);

    return \@entries;

} 


sub get_directories_from_entries {

    my $entries = shift;
    my @directories = ();

    foreach my $entry ( @$entries ) {
        next if $entry eq '.' or $entry eq '..';
        push @directories, $entry;
    }

    return \@directories;

}


1;
