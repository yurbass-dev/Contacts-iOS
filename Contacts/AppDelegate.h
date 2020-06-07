//
//  AppDelegate.h
//  Contacts
//
//  Created by Yuriy on 06.06.2020.
//  Copyright © 2020 Yuriy Chizh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

