//
//  ViewController.m
//  Notetastic
//
//  Created by Daniel Garzon on 10/4/14.
//  Copyright (c) 2014 Daniel Garzon. All rights reserved.
//

#import "ViewController.h"
#import "NoteTableViewCell.h"
#import "Note.h"
#import "Data.h"
#import "NewNoteViewController.h"
#import "NoteDetailViewController.h"
#import "UIColor+BrandColors.h"

static NSString *const kTableViewCellReuseIdentifier = @"noteTableViewCellReuseIdentifier";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *notes;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNotes];
    
    self.navigationItem.title = @"All Notes";
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor emeraldColor];
    self.navigationController.navigationBar.tintColor = [UIColor darkerColorForColor:[UIColor nephritisColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor cloudsColor],
                                                                      NSFontAttributeName: [UIFont fontWithName:@"Montserrat-Bold" size:18.0]}];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.view.backgroundColor = [UIColor cloudsColor];
    
    [self makeNotes];
    [self.tableView reloadData];
}

- (void)makeNotes {
    self.notes = [NSMutableArray arrayWithArray:[[Data getAllNotes] allKeys]];
    
    [self.notes sortUsingComparator:^NSComparisonResult(NSDate *obj1, NSDate *obj2) {
        return [obj2 compare:obj1];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoteTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier forIndexPath:indexPath];
    Note *note = [[Data getAllNotes] objectForKey:[self.notes objectAtIndex:indexPath.row]];
    [self configureCell:cell ForItem:note];
    return cell;
}

- (void)configureCell:(NoteTableViewCell *)cell ForItem:(Note *)note {
    [self setTitleForCell:cell item:note];
    [self setBodyForCell:cell item:note];
    [self setImageForCell:cell item:note];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.notes count];
}

- (void)setTitleForCell:(NoteTableViewCell *)cell item:(Note *)item {
    NSString *title = item.title;
    
    if (title.length > 25) {
        title = [NSString stringWithFormat:@"%@...", [title substringToIndex:25]];
    }
    
    [cell.noteTitleLabel setText:title];
}

- (void)setBodyForCell:(NoteTableViewCell *)cell item:(Note *)item {
    NSString *body = item.body;

    if (body.length > 30) {
        body = [NSString stringWithFormat:@"%@...", [body substringToIndex:30]];
    }
    
    [cell.noteDescriptionLabel setText:body];
}

- (void)setImageForCell:(NoteTableViewCell *)cell item:(Note *)item {
    UIImage *image = item.picture ? item.picture : [UIImage imageNamed:@"defaultImage"];
    [cell.noteImageView setImage:image];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [Data removeNoteForKey:[self.notes objectAtIndex:indexPath.row]];
        [self.notes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [Data saveNotesToLocalStorage];
    }
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kNoteDetailView]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *key = self.notes[indexPath.row];
        [[segue destinationViewController] setDetailItem:key];
    }
}

#pragma mark - New Note Modal Segue Methods

- (IBAction)cancelUnwindSegueCallback:(UIStoryboardSegue *)segue {

}

- (IBAction)saveUnwindSegueCallback:(UIStoryboardSegue *)segue {
    NewNoteViewController *newNoteController = segue.sourceViewController;
    
    NSString *key = [[NSDate date] description];
    
    Note *note = [[Note alloc] init];
    note.title = newNoteController.titleTextField.text;
    note.body = newNoteController.descriptionTextView.text;
    
    [Data setNote:note forKey:key];
    [Data setCurrentKey:key];
    
    [self.notes insertObject:key atIndex:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [Data saveNotesToLocalStorage];
}



@end
