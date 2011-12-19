package Chat::ChatControl;
use Mojo::Base 'Mojolicious::Controller';

our $clients = {};

sub chatAction {
	my $self = shift;
	$self->render(
		message => 'Chatting Example'
	);
}

sub wsAction {
	my $self 	= shift;
	my $clntID  = sprintf "%s" , $self->tx;
	
	$clients->{$clntID} = $self->tx;

	foreach my $ids (keys %$clients){
		$clients->{$ids}->send_message("Client Connected!");
	}

	say "Client Connected!";

	$self->on(
		finish => sub {
			my $self = shift;
			my $id = sprintf "%s" , $self->tx;

			delete $clients->{$id};
			say "Client is Disconnected!";
		}
	);
	
	$self->on( 
		message => sub {
			my ($self,$message) = @_;
			foreach my $ids (keys %$clients){
				$clients->{$ids}->send_message($message);
			}
		}
	);
}

1;
