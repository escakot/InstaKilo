//
//  NameSectionSort.h
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-12.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoManager.h"

@interface NameSectionSort : NSObject <PhotoManagerDelegate>

@property (strong, nonatomic) NSArray<NSString*>* alphabets;

@end
