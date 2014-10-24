//
//  NoteDetailViewController.m
//  Notetastic
//
//  Created by Daniel Garzon on 10/4/14.
//  Copyright (c) 2014 Daniel Garzon. All rights reserved.
//

#import "NoteDetailViewController.h"
#import "UIColor+BrandColors.h"
#import "Note.h"
#import "Data.h"

@interface NoteDetailViewController ()

- (void)configureView;

@end

@implementation NoteDetailViewController

- (void)viewDidAppear:(BOOL)animated {
    [self configureDescription];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cloudsColor];
    
    self.titleTextField.delegate = self;
    self.titleTextField.returnKeyType = UIReturnKeyDone;
    self.titleTextField.backgroundColor = [UIColor clearColor];
    [self.titleTextField setTextColor:[UIColor darkGrayColor]];
    [self.titleTextField setFont:[UIFont fontWithName:@"Lato-Bold" size:18]];
    self.titleTextField.layer.borderColor = [UIColor clearColor].CGColor;
    self.titleTextField.layer.borderWidth = 0;
    
    self.descriptionTextView.delegate = self;
    self.descriptionTextView.returnKeyType = UIReturnKeyDone;
    self.descriptionTextView.scrollEnabled = NO;
    self.descriptionTextView.backgroundColor = [UIColor clearColor];
    [self.descriptionTextView setTextColor:[UIColor darkGrayColor]];
    [self.descriptionTextView setFont:[UIFont fontWithName:@"Lato-Regular" size:16]];
    
    
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
   
    UIBarButtonItem *cameraButton = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                    target:self
                                    action:@selector(cameraAction:)];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                    target:self
                                    action:@selector(shareAction:)];
    
    [buttons addObject:shareButton];
    [buttons addObject:cameraButton];
    
    self.navigationItem.rightBarButtonItems = buttons;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(handleSingleTap:)];
    
    [self.view addGestureRecognizer:tapGesture];
    
    [self configureView];
}


- (IBAction)shareAction:(id)sender {
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self showEmail:mc];
    });
}

- (IBAction)cameraAction:(id)sender {
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:@"Add Image"
                                                                                   message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"Add Image"];
    [title addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"Lato-Bold" size:20]
                  range:NSMakeRange(0, 9)];
    
    [title addAttribute:NSForegroundColorAttributeName
                  value:[UIColor darkGrayColor]
                  range:NSMakeRange(0, 9)];
    
    [actionSheetController setValue:title forKey:@"attributedTitle"];
    
    UIAlertAction *fromCamera = [UIAlertAction actionWithTitle:@"Camera"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [self performSelector:@selector(presentCameraImagePicker:) withObject:nil];
                                                   }];
    
    UIAlertAction *fromLibrary = [UIAlertAction actionWithTitle:@"Library"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            [self performSelector:@selector(presentLibraryImagePicker:) withObject:nil];
                                                        }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                             {
                                 [actionSheetController dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    [actionSheetController addAction:fromCamera];
    [actionSheetController addAction:fromLibrary];
    [actionSheetController addAction:cancel];
    
    actionSheetController.view.tintColor = [UIColor nephritisColor];
    
    [self presentViewController:actionSheetController animated:YES completion:nil];
}

- (IBAction)presentCameraImagePicker:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:NULL];
    }
    
}

- (IBAction)presentLibraryImagePicker:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:NULL];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDetailItem:(id)detailItem {
    if (_detailItem != detailItem) {
        _detailItem = detailItem;
    }
    [Data setCurrentKey:detailItem];
    [self configureView];
}

- (void)configureDescription {
    
    CGSize sizeThatShouldFitTheContent = [self.descriptionTextView sizeThatFits:self.descriptionTextView.frame.size];
    self.textViewHeightConstraint.constant = sizeThatShouldFitTheContent.height;
    
}

- (void)configureView {
    Note *current = [[Data getAllNotes] objectForKey:[Data getCurrentKey]];
    
    self.titleTextField.text = current.title;
    self.descriptionTextView.text = current.body;
    
    CGSize sizeThatShouldFitTheContent = [self.descriptionTextView sizeThatFits:self.descriptionTextView.frame.size];
    self.textViewHeightConstraint.constant = sizeThatShouldFitTheContent.height;

    
    if (current.picture != nil) {
        self.imageView.image = current.picture;
    }
    
    if ([self.descriptionTextView.text isEqual:@""])
        [self.descriptionTextView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    Note *updatedNote = [[Note alloc] init];
    updatedNote.title =  self.titleTextField.text;
    updatedNote.body =  self.descriptionTextView.text;
    updatedNote.picture =  self.imageView.image;
    
    [Data setNoteForCurrentKey:updatedNote];
    
    [Data saveNotesToLocalStorage];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate Methods

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -
#pragma mark UITextViewDelegate Methods

- (void)textViewDidChange:(UITextView *)textView {
    self.textViewHeightConstraint.constant = self.descriptionTextView.contentSize.height;
}


#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate Methods

- (void)showEmail:(MFMailComposeViewController *)mc {
    
    NSString *prepend = @"[Notastic]: ";
    NSString *subject = [prepend stringByAppendingString:[NSString stringWithFormat:@"%@", self.titleTextField.text]];
    
    Note *current = [[Note alloc] init];
    current.title = self.titleTextField.text;
    current.body = self.descriptionTextView.text;
    
    if (self.imageView.image != nil) {
        current.picture = self.imageView.image;
    }
    
    NSString *emailTitle = subject;
    NSString *messageBody = current.body;
    
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    
    NSData *imageData = UIImagePNGRepresentation(current.picture);
    
    NSString *mimeType  = [self contentTypeForImageData:imageData];
    
    NSString *imageName = [NSString stringWithFormat: @"[Notactic Image]: %@", current.title];
    
    [mc addAttachmentData:imageData mimeType:mimeType fileName:imageName];
    
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
            break;
        case 0x42:
            return @"image/bmp";
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

@end
