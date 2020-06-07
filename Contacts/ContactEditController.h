//
//  ContactEdit.h
//  Contacts
//
//  Created by Yuriy on 07.06.2020.
//  Copyright © 2020 Yuriy Chizh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ContactEditControllerDelegate;

@interface ContactEditController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) Person *person;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *surname;
@property (copy, nonatomic) NSString *email;
@property (strong, nonatomic) UIImage *photo;
@property (weak, nonatomic) id <ContactEditControllerDelegate> delegate;

@end

@protocol ContactEditControllerDelegate <NSObject>

@required
- (void)didChangeContact:(Person *)person withIndexPath:(NSIndexPath *)indexPath;
- (void)didDeleteContact:(Person *)person;

@end

NS_ASSUME_NONNULL_END
