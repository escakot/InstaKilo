//
//  Photos.m
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-12.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "Photos.h"

@implementation Photos

-(void)getListOfPhotoNames
{
//    self.photoNames = [[NSMutableArray alloc] init];
//    NSString *path = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] bundlePath], @"Images"];
//    NSFileManager *fileManager= [NSFileManager defaultManager];
//    NSArray *dirlist = [fileManager contentsOfDirectoryAtPath:path error:nil];
//    
//    NSString *directory = [NSString stringWithFormat:@"%@/%@", path, [dirlist objectAtIndex: index]];
//    NSLog(@"%@",directory);
//    self.photoNames = [fileManager contentsOfDirectoryAtPath:directory error:nil];
////    NSArray *dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"~/Images"
//    NSLog(@"%@", self.photoNames);
    self.photoNames = [[NSMutableArray alloc] init];
    __block NSString *imagesURLString = [[NSString alloc] init];
    [[[NSBundle mainBundle] pathsForResourcesOfType:nil inDirectory:nil] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        if ([obj hasSuffix:@"Images"])
        {
            imagesURLString = obj;
            NSLog(@"%@",obj);
        }
    }];
    NSFileManager *fileManager= [NSFileManager defaultManager];
    self.photoNames = [fileManager contentsOfDirectoryAtPath:imagesURLString error:nil];
    
}

@end
