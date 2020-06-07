//
//  Data.m
//  Contacts
//
//  Created by Yuriy on 07.06.2020.
//  Copyright © 2020 Yuriy Chizh. All rights reserved.
//

#import "Data.h"

@implementation Data

- (NSString *)randomName {
    
    NSArray *firstNames = @[
        @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
        @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
        @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
        @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
        @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
        @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
        @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
        @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
        @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
        @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
    ];
    
    NSString *name = firstNames[arc4random_uniform((uint32_t)firstNames.count)];
    
    return name;
}


- (NSString *)randomSurname {
    
    NSArray *lastNames = @[
       @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
       @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
       @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
       @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
       @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
       @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
       @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
       @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
       @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
       @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
    ];
    
    NSString *lastName = lastNames[arc4random_uniform((uint32_t)lastNames.count)];
    
    return lastName;
}

- (NSString *)email {
    
    return @"test@mail.com";
}

- (UIImage *)photo {
    
    UIImage *image = [UIImage imageNamed:@"image.png"];
    
    return image;
}


@end
