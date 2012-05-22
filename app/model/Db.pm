# Author:   mark.ibbotson@manheim.co.uk (ibbo) 
# Purpose:  DB access
# 
package app::model::Db;

sub new {
	my ($classname, $platform) = @_;
	my $self = bless {},$classname;
    
    return $self;
}

sub getInstance {
	my ($self, $db) = @_;
	
	my $instance = MongoDB::Connection->new;
	return $instance->$db;
}

1;