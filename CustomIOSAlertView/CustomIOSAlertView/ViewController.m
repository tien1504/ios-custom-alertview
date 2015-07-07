//
//  ViewController.m
//  CustomIOSAlertView
//
//  Created by Richard on 20/09/2013.
//  Copyright (c) 2013-2015 Wimagguc.
//
//  Lincesed under The MIT License (MIT)
//  http://opensource.org/licenses/MIT
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Just a subtle background color
    [self.view setBackgroundColor:[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f]];

    // A simple button to launch the demo
    UIButton *launchDialog = [UIButton buttonWithType:UIButtonTypeCustom];
    [launchDialog setFrame:CGRectMake(10, 30, self.view.bounds.size.width-20, 50)];
    [launchDialog addTarget:self action:@selector(launchDialog:) forControlEvents:UIControlEventTouchDown];
    [launchDialog setTitle:@"Launch Dialog" forState:UIControlStateNormal];
    [launchDialog setBackgroundColor:[UIColor whiteColor]];
    [launchDialog setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [launchDialog.layer setBorderWidth:0];
    [launchDialog.layer setCornerRadius:5];
    [self.view addSubview:launchDialog];
}

- (IBAction)launchDialog:(id)sender
{
    // Here we need to pass a full frame
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];

    // Add some custom content to the alert view
    [alertView setContainerView:[self createShareDialogWithTitle: @"Share to Facebook"]];

    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", @"Share", nil]];
    //[alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];

    // And launch the dialog
    [alertView show];
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

- (UIView *)createShareDialogWithTitle: (NSString*) shareTitle
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 180)];
    
    UIFont* smallFont = [UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleFootnote] size:11];
    UIFont* normalFont = [UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody] size:13];
    
    //title
    UILabel* dialogTitle = [UILabel new];
    [dialogTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
    [demoView addSubview:dialogTitle];
    [dialogTitle setText:shareTitle];
    [dialogTitle setTextAlignment:NSTextAlignmentCenter];
    dialogTitle.font = [UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleHeadline] size:14];
    
    
    //video title
    UILabel* uploadTitle = [UILabel new];
    [uploadTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
    [demoView addSubview:uploadTitle];
    [uploadTitle setText:@"Title"];
    [uploadTitle setFont:smallFont];
    
    UITextField* titleField = [UITextField new];
    [titleField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [demoView addSubview:titleField];
    [titleField setBorderStyle:UITextBorderStyleRoundedRect];
    [titleField setFont:normalFont];
    
    
    //description
    UILabel* uploadDescription = [UILabel new];
    [uploadDescription setTranslatesAutoresizingMaskIntoConstraints:NO];
    [uploadDescription setText:@"Description"];
    [demoView addSubview:uploadDescription];
    [uploadDescription setFont:smallFont];
    
    
    UITextView* textView = [UITextView new];
    [textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [demoView addSubview:textView];
    [textView.layer setCornerRadius:8.0];
    [textView.layer setBorderColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0].CGColor];
    [textView.layer setBorderWidth:0.5];
    
    NSDictionary* dict = NSDictionaryOfVariableBindings(dialogTitle, uploadTitle, titleField, uploadDescription ,textView);
    [demoView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[dialogTitle]" options:0 metrics:nil views:dict]];
    [demoView addConstraint:[NSLayoutConstraint constraintWithItem:dialogTitle attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:demoView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    //constraint for titleField
    [demoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[dialogTitle]-20-[titleField]-10-[textView]-10-|" options:0 metrics:nil views:dict]];
    [demoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[uploadTitle(60)]-[titleField]-|" options:0 metrics:nil views:dict]];
    [demoView addConstraint:[NSLayoutConstraint constraintWithItem:uploadTitle attribute:NSLayoutAttributeBaseline relatedBy:NSLayoutRelationEqual toItem:titleField attribute:NSLayoutAttributeBaseline multiplier:1.0 constant:0.0]];
    
    //constraint for textView
    [demoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[uploadDescription(60)]-[textView]-|" options:0 metrics:nil views:dict]];
    [demoView addConstraint:[NSLayoutConstraint constraintWithItem:uploadDescription attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:textView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];

    return demoView;
}

@end
