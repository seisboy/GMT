#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;

@ARGV==1 or die "Usage: perl $0 dirname\n";
my ($dir)=@ARGV;

chdir $dir;
mkdir 'ri_baz', 0755 or die "Cannot make ri_baz directory: $!";
system "cp *.SAC.Ri ri_baz";
chdir "ri_baz";

my @files_Ri=<*.SAC.Ri>;
my $length=$#files_Ri;
foreach (0..$length){
    my $temp1=`saclst baz f $files_Ri[$_]`;
    my (undef,$baz)=split(/\s+/,$temp1);
    system "mv $files_Ri[$_] ${baz}_$files_Ri[$_]";
}

chdir "..";
chdir "..";
system "cp plt_ri_baz.sh $dir/ri_baz";

chdir "$dir/ri_baz";
system "./plt_ri_baz.sh";

chdir "..";
chdir "..";
