=head1 NAME

app::model::Registry - Registry Model 

=head1 SYNOPSIS

  new
  set
  get
  
=head1 DESCRIPTION

  app::model::Registry class
  
  Variable registry class
   
   $resistry->set(name, value)
   $resistry->get(name)

=head2 Methods
=cut

package app::model::Register;

=over 4

=item * $object->new(class, param)

   Default instance for given class call   
=cut

sub new {
	my ($classname) = @_;
	my $self = bless {},$classname;

	return $self;
}

=item * $object->set(name, value)

   Internal storage mutator    
=cut

sub set {
	my ($self, $name, $value) = @_;
	$self->{$name} = $value;
}

=item * $object->get(name)

   Internal storage accessor    
=cut

sub get {
	my ($self, $name) = @_;
	return $self->{$name};  
}
1;

=back

=head1 AUTHOR

Mark Ibbotson (mark.ibbotson@manheim.co.uk)

=head1 COPYRIGHT

Copyright 2010 Manheim.  All rights reserved.

This library is owned by Manheim.

=head1 SEE ALSO

perl(1).

=cut 
=head1 SEE ALSO

perl(1).

=cut 