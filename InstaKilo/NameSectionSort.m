//
//  NameSectionSort.m
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-12.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "NameSectionSort.h"
#import "Photo.h"

@implementation NameSectionSort


- (instancetype)init
{
    self = [super init];
    if (self) {
        _alphabets = @[@"A",@"B",@"C",@"D",@"E",@"F"
                       ,@"G",@"H",@"I",@"J",@"K",@"L"
                       ,@"M",@"N",@"O",@"P",@"Q",@"R"
                       ,@"S",@"T",@"U",@"V",@"W",@"X"
                       ,@"Y",@"Z"];
    }
    return self;
}

-(NSMutableDictionary *)sortPhotosIntoSections:(NSArray *)photoNames
{
    NSMutableDictionary *photoList = [[NSMutableDictionary alloc] init];
    NSMutableArray *uncategorized = [[NSMutableArray alloc] init];
    NSArray *sortedPhotoNames = [photoNames sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    BOOL isCategorized = NO;
    for (NSString* photo in sortedPhotoNames)
    {
        NSString* photoLocation = [NSString stringWithFormat:@"%@%@", @"Images/", photo];
        NSString* photoName = [self checkForCategory:photo];
        for (NSString* key in self.alphabets)
        {
            if ([[[photoName substringToIndex:1] uppercaseString] isEqualToString:key])
            {
                //Check if section already exists
                if([photoList objectForKey:key])
                {
                    NSMutableArray *addToSection = photoList[key];
                    Photo *newPhoto = [[Photo alloc] init];
                    newPhoto.name = photoName;
                    newPhoto.image = [UIImage imageNamed:photoLocation];
                    [addToSection addObject:newPhoto];
                    
                //Create new NSArray with key
                } else {
                    NSMutableArray *newSection = [[NSMutableArray alloc] init];
                    Photo *newPhoto = [[Photo alloc] init];
                    newPhoto.name = photoName;
                    newPhoto.image = [UIImage imageNamed:photoLocation];
                    [newSection addObject:newPhoto];
                    [photoList setObject:newSection forKey:key];
                }
                isCategorized = YES;
                
            }
        }
        if (!isCategorized){
            Photo *newPhoto = [[Photo alloc] init];
            newPhoto.name = photoName;
            newPhoto.image = [UIImage imageNamed:photoLocation];
            [uncategorized addObject:newPhoto];
        }
        isCategorized = NO;
    }
    [photoList setObject:uncategorized forKey:@"#"];
    NSLog(@"%@",photoList);
    return photoList;
}

-(NSString*)checkForCategory:(NSString*)string{
    NSArray *sectionWords = [string componentsSeparatedByString:@"-"];
    if (sectionWords.count >= 2){
        return sectionWords[1];
    } else {
        return string;
    }
}

@end
