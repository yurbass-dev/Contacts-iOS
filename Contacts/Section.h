//
//  Section.h
//  Contacts
//
//  Created by Yuriy on 07.06.2020.
//  Copyright © 2020 Yuriy Chizh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Section : NSObject

@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *persons;

@end

NS_ASSUME_NONNULL_END
