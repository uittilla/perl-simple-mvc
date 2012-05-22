=head1 NAME

app::controller::errorController - Error controller 

=head1 SYNOPSIS

  use app::controller::Controller;
  @ISA = qw(app::controller::Controller);
  index


=head1 DESCRIPTION

  Error controller class (format error page) 

=head2 Methods
=cut
  
package app::controller::errorController;

use app::controller::Controller;
@ISA = qw(app::controller::Controller);


=over 4
  
=item * $object->index(template, route, vars)

   Abstract method called from Router.pm
   
   Params:
      template: template to parse
      route   : controller name  (see Router.pm)
      vars    : application vars (see Registry.pm)
             
=cut

sub index {
	
    my ($self) = shift;
    my $csvars = {};
    
    $csvars->{error} = $self->{error};
    
    $self->process( $self->{tpl}, $csvars );
}
1;
=back

=head1 AUTHOR

(Ibbo)

=head1 COPYRIGHT

Copyright 2010.  All rights reserved.

Do as you will

=head1 SEE ALSO

perl(1).
app::controller:Controller(1)
app::model::Router(1).
app::model::Registry(1).

=cut 
