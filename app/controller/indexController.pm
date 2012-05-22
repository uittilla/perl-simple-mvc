=head1 NAME 

app::controller::indexController - Index controller 

=head1 SYNOPSIS

  use app::controller::Controller;
  @ISA = qw(app::controller::Controller);
  index
  
=head1 DESCRIPTION

  Index controller 
=head2 Methods
=cut

package app::controller::indexController;

=over 4

=item * $object->index(template, route, vars)

   Abstract method called from Router.pm
   
   Params:
      template: template to parse
      route   : controller name  (see Router.pm)
      vars    : application vars (see Registry.pm)
             
=cut

use app::controller::Controller;
@ISA = qw(app::controller::Controller);

sub index {
	my ($self) = shift;
    my $csvars = {};
    # do something

    $self->process($self->{tpl}, $csvars);      	    
}

1;
=back

=head1 AUTHOR

(Ibbo)

=head1 COPYRIGHT

Copyright 2010.  All rights reserved.

Do as you will.

=head1 SEE ALSO

perl(1).
app::controller:Controller(1)
app::model::Router(1).
app::model::Registry(1).

=cut 
