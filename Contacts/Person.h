//
//  Person.h
//  Contacts
//
//  Created by Yuriy on 07.06.2020.
//  Copyright © 2020 Yuriy Chizh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *surname;
@property (copy, nonatomic) NSString *email;
@property (strong, nonatomic) UIImage *photo;

@end

NS_ASSUME_NONNULL_END
