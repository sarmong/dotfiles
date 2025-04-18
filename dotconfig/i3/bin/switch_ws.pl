#!/usr/bin/env perl

use strict;
use warnings;
use JSON;
use IPC::Open3;
use IO::Handle;

sub extract_number {
    my ($ws_name) = @_;
    if ($ws_name =~ /^(\d+)/) {
        return $1;
    }
    return 0;
}

sub main {
    my $direction = lc $ARGV[0];

    my $workspace_data_json = `i3-msg -t get_workspaces`;
    my $workspace_data = decode_json($workspace_data_json);

    my ($current_ws, $active_output);
    for my $workspace (@$workspace_data) {
        if ($workspace->{focused}) {
            $current_ws = $workspace->{name};
            $active_output = $workspace->{output};
            last;
        }
    }

    my @workspaces_on_output = grep { $_->{output} eq $active_output } @$workspace_data;
    my @sorted_workspaces = sort { extract_number($a->{name}) <=> extract_number($b->{name}) } @workspaces_on_output;

    my $current_num = extract_number($current_ws);
    my $target_ws;

    if ($direction eq 'next') {
        for my $ws (@sorted_workspaces) {
            if (extract_number($ws->{name}) > $current_num) {
                $target_ws = $ws->{name};
                last;
            }
        }

        if (!$target_ws) {
            $target_ws = $sorted_workspaces[0]->{name};
        }
    }
    else {
        my @prev_workspaces = grep { extract_number($_->{name}) < $current_num } @sorted_workspaces;
        if (@prev_workspaces) {
            $target_ws = $prev_workspaces[-1]->{name};
        }
        else {
            $target_ws = $sorted_workspaces[-1]->{name};
        }
    }

    system("i3-msg", "workspace", $target_ws);
}

main() if @ARGV;
