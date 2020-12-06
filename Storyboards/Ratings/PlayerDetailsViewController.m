
#import "PlayerDetailsViewController.h"
#import "Player.h"

@implementation PlayerDetailsViewController
{
	NSString* game;
}

@synthesize delegate;
@synthesize nameTextField;
@synthesize detailLabel;

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		NSLog(@"init PlayerDetailsViewController");
		game = @"Chess";
	}
	return self;
}

- (void)dealloc
{
	NSLog(@"dealloc PlayerDetailsViewController");
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.detailLabel.text = game;
}

- (void)viewDidUnload
{
	[self setNameTextField:nil];
	[self setDetailLabel:nil];
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"PickGame"])
	{
		GamePickerViewController *gamePickerViewController = segue.destinationViewController;
		gamePickerViewController.delegate = self;
		gamePickerViewController.game = game;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0)
		[self.nameTextField becomeFirstResponder];
}

- (IBAction)cancel:(id)sender
{
	[self.delegate playerDetailsViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender
{
	Player *player = [[Player alloc] init];
	player.name = self.nameTextField.text;
	player.game = game;
	player.rating = 1;

	[self.delegate playerDetailsViewController:self didAddPlayer:player];
}

#pragma mark - GamePickerViewControllerDelegate

- (void)gamePickerViewController:(GamePickerViewController *)controller didSelectGame:(NSString *)theGame
{
	game = theGame;
	self.detailLabel.text = game;

	[self.navigationController popViewControllerAnimated:YES];
}

@end
