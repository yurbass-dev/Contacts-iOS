//
//  ContactCell.h
//  Contacts
//
//  Created by Yuriy on 07.06.2020.
//  Copyright © 2020 Yuriy Chizh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

NS_ASSUME_NONNULL_END
