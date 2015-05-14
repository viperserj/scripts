#!/usr/bin/perl
#Crap - simple last command sudoer
#Version 0.1 - you need to manually set up your history address
#To-Do: make it work, make it work with multiple shells
$tmp = `tail -n2 ~/.zsh_history | head -n1 | cut -d ';' -f2`;
system "sudo $tmp";
exit 0;
