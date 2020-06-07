//
//  ContactEdit.m
//  Contacts
//
//  Created by Yuriy on 07.06.2020.
//  Copyright © 2020 Yuriy Chizh. All rights reserved.
//

#import "ContactEditController.h"

@interface ContactEditController ()

- (IBAction)actionDelete:(UIBarButtonItem *)sender;
- (IBAction)actionEdit:(UIBarButtonItem *)sender;

@property (strong, nonatomic) UIBarButtonItem *doneBarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteBarButton;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *surnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (assign, nonatomic, getter=isEditing) BOOL editing;
@property (weak, nonatomic) UITextField *activeTextField;
@property (strong, nonatomic) NSDictionary *textFieldsByKeys;

@end

@implementation ContactEditController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.toolbarHidden = NO;
 
    self.deleteBarButton.enabled = NO;
    self.deleteBarButton.tintColor = UIColor.clearColor;
    
    self.doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                       target:self
                                                                       action:@selector(actionDone:)];
    self.editing = NO;
    
    self.textFieldsByKeys = @{@"name" : self.nameTextField, @"surname" : self.surnameTextField, @"email" : self.emailTextField};
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.nameTextField.text = self.person.name;
    self.surnameTextField.text = self.person.surname;
    self.emailTextField.text = self.person.email;
    self.photoImageView.image = self.person.photo;
    
    self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.width / 2.0f;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    self.navigationController.toolbarHidden = YES;
}


#pragma mark - Actions

- (IBAction)actionEdit:(UIBarButtonItem *)sender {
    
    self.editing = YES;
    self.navigationItem.rightBarButtonItem = self.doneBarButton;
    self.deleteBarButton.enabled = YES;
    self.deleteBarButton.tintColor = UIColor.redColor;
    
}

- (IBAction)actionDelete:(UIBarButtonItem *)sender {
    
    [self.delegate didDeleteContact:self.person];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)actionDone:(UIBarButtonItem *)sender {
    
    self.editing = NO;
    [self.activeTextField resignFirstResponder];
    self.navigationItem.rightBarButtonItem = self.editBarButton;
    self.deleteBarButton.enabled = NO;
    self.deleteBarButton.tintColor = UIColor.clearColor;
    
    [self.delegate didChangeContact:self.person withIndexPath:self.indexPath];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (self.isEditing) {
        self.activeTextField = textField;
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSArray *keys = [self.textFieldsByKeys allKeysForObject:textField];
    NSString *key = [keys firstObject];
    
    if ([key isEqualToString:@"name"]) {
        self.person.name = textField.text;
    }
    else if ([key isEqualToString:@"surname"]) {
        self.person.surname = textField.text;
    }
    else if ([key isEqualToString:@"email"]) {
        self.person.email = textField.text;
    }
    
    [self.delegate didChangeContact:self.person withIndexPath:self.indexPath];
}

@end
