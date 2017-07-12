//
//  InstaKiloViewController.m
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-12.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "InstaKiloViewController.h"
#import "IKCollectionViewCell.h"
#import "Photos.h"

@interface InstaKiloViewController () <UICollectionViewDataSource>

@property (strong, nonatomic) NSArray<NSString*>* photos;

@end

@implementation InstaKiloViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.photos = @[@"pet-corgi",@"pet-golden",@"pet-husky",@"pet-spitz",@"pet-maltese",@"other-home",@"meme-cry",@"meme-derpina",@"meme-derpinamad",@"meme-omg",@"meme-pleaseguy",@"meme-ruserious",];
    Photos *photos = [[Photos alloc] init];
    [photos getListOfPhotoNames];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UICollectionView Data Source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ikCell" forIndexPath:indexPath];
    UIImage *image = [UIImage imageNamed:self.photos[indexPath.row]];
    cell.image = image;
    [cell updateDisplay];

    return cell;
}

@end
