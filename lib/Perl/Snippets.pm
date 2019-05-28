package Perl::Snippets;

# DATE
# VERSION

1;
# ABSTRACT: A collection of Perl idioms or short pieces of Perl code

=head1 DESCRIPTION

This distribution catalogs (in its POD pages) various idioms or short pieces of
code that a Perl programmer usually uses. You can also copy-paste them to your
code.

The pieces of code are often too small to refactor into modules, or sometimes
they have been refactored as modules but you still want to "inline" them to
avoid adding a dependency. The pieces of code are often Perl idioms (patterns of
code that are specific to Perl programming), but not always.


=head1 THE IDIOMS

=head2 Arrays (ARY)


=head2 Arrays / Sorting arrays (ARY/SORT)

=item * snippet ARY/SORT/1

 my @sorted = map  { $_->[0] }
              sort { $a->[1] <=> $b->[1] }
              map  { [$_, gen_key_for($_)] }
              @ary;

This is the infamous Schwartzian transform named after Randal Schwartz who
popularized it during the early days of Perl 5 in 1994. Basically, it's a
one-statement way to sort an array using a key. Examples of functions to
generate a key: C<length($_)> (to sort by string length), C<lc($_)> (to do
case-insensitive sorting).

Related documentation: L<https://en.wikipedia.org/wiki/Schwartzian_transform>


=head2 Hashes (HASH)


=head2 I/O (IO)


=head2 I/O / File I/O (IO/FILE)

=over

=item * snippet IO/FILE/1

 my $content = do { local $/; <$fh> };

The above snippet slurps the whole file (which has been opened with filehandle
C<$fh>) into memory (scalar variable). The C<do {}> block localizes the effect
of C<$/>. If you start from a filename and want to open it first:

=item * snippet IO/FILE/2

 my $content = do { local $/; open my $fh, "<", $filename; <$fh> };

=item * snippet IO/FILE/3

 my @lines = do { local $/; open my $fh, "<", $filename; <$fh> };

Like the previous snippet but you get the content as an array of lines. Each
line still has their terminating newlines. If you want to trim those:

=item * snippet IO/FILE/4

 chomp(my @lines = do { local $/; open my $fh, "<", $filename; <$fh> });

Related modules: L<File::Slurper>.

Related documentation: C<$/> in L<perlvar>.

=back


=head2 Modules (MOD)

=over

=item * snippet MOD/LOAD/1

 { (my $mod_pm = "$mod.pm") =~ s!::!/!g; require $mod_pm }

You have a module name in C<$mod> (e.g. C<"Foo::Bar">) and want to
load/C<require> it. You cannot just use C<require $mod> because require expects
its non-bareware argument to be in the form of C<"Foo/Bar.pm">. So the above
snippet converts C<$mod> to that form.

This is safer than C<eval "use $mod"> or C<eval "require $mod"> which work but
necessitates you to check that $mod does not contain arbitrary and dangerous
code.

Related modules: L<Module::Load>

Related documentation: C<require> in L<perlfunc>.

=item * snippet MOD/LOAD/2

 require Foo::Bar; Foo::Bar->import("baz", "qux");

The above snippet loads C<Foo::Bar> module and imports things from the module.
It is the run-time equivalent of C<< use Foo::Bar "baz", "qux"; >>. C<< require
Foo::Bar; >> itself is the run-time equivalent of C<< use Foo::Bar (); >>, i.e.
loading a module without importing anything from it.

=back


=head2 Process / Child process (PROC/CHLD)

Some bit-fiddling and logic is needed to extract exit code from C<$?>
(C<$CHILD_ERROR>). L<Process::Status> makes things easier by presenting you with
an object that you can query, but if you just want an exit code:

=item * snippet PROC/CHLD/1

 my ($exit_code, $signal, $core_dump) = ($? < 0 ? $? : $? >> 8, $? & 127, $? & 128);

This snippet extracts all the information contained in C<$?>: exit code (which
can be -1 to mean there is no child process being created due to an execution
error, e.g. C<system "non-existent-command">), what signal the child process
dies from, and whether the child process dumps core.

=item * snippet PROC/CHLD/2

 my $exit_code = $? < 0 ? $? : $? >> 8.

This snippets just extracts the exit code of child process (which can be -1 to
mean that there is no child process being created due to an execution error,
e.g. C<system "non-existent-command">).

Related modules: L<Process::Status>, L<Proc::ChildError>.

Related documentation: C<$?> in L<perlvar>.

=back


=head2 Objects (OBJ)


=head2 References (REF)


=head2 Subroutines (SUB)


=head2 Subroutines / subroutine arguments (SUB/ARG)


=head1 SEE ALSO

L<Common Perl idioms (2004)|https://www.perlmonks.org/?node_id=376948>

The Idioms subchapter in the Modern Perl book. L<http://modernperlbooks.com/>
