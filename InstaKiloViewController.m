//
//  InstaKiloViewController.m
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-12.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "InstaKiloViewController.h"
#import "IKCollectionViewCell.h"
#import "PhotoManager.h"
#import "CategorySectionSort.h"
#import "NameSectionSort.h"

@interface InstaKiloViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) PhotoManager *photoManager;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) CategorySectionSort *categorySort;
@property (strong, nonatomic) NameSectionSort *nameSort;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sortBarButton;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *defaultFlowLayout;

@end

@implementation InstaKiloViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //Flow Layout
    self.defaultFlowLayout.itemSize = CGSizeMake(75, 100);
    self.defaultFlowLayout.minimumInteritemSpacing = 15;
    self.defaultFlowLayout.minimumLineSpacing = 20;
    self.defaultFlowLayout.sectionInset = UIEdgeInsetsMake(20, 30, 20, 30);
    
    //Sorting Objects
    self.photoManager = [[PhotoManager alloc] init];
    self.categorySort = [[CategorySectionSort alloc] init];
    self.nameSort = [[NameSectionSort alloc] init];
    self.photoManager.delegate = self.categorySort;
    [self.photoManager getSectionData];
    
    //Long Press Gesture
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveTargetItem:)];
    [self.collectionView addGestureRecognizer:longPressGesture];
    
    [self.collectionView reloadData];
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
- (IBAction)changeSortMethod:(UIBarButtonItem *)sender {
    if ([self.photoManager.delegate isMemberOfClass:[CategorySectionSort class]])
    {
//        [self.collectionView performBatchUpdates:^{
//        } completion:^(BOOL finished) {
//        }];
        self.photoManager.delegate = self.nameSort;
        self.sortBarButton.title = @"Sort: Alphabetical";
        
    } else {
        self.photoManager.delegate = self.categorySort;
        self.sortBarButton.title = @"Sort: Category";
    }
    [self.photoManager getSectionData];
    [self.collectionView reloadData];
}


#pragma mark - UICollectionView Data Source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.photoManager.photoList.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *allSectionKeys = [self.photoManager.photoList allKeys];
    NSArray *sortedSectionKeys = [allSectionKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *sectionKey = sortedSectionKeys[section];
    return self.photoManager.photoList[sectionKey].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ikCell" forIndexPath:indexPath];
    cell.photo = [self.photoManager getPhotoAtIndexPath:indexPath];
    [cell updateDisplay];

    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"IKHeader" forIndexPath:indexPath];
        
        UILabel *headerLabel = [header viewWithTag:1];
        NSArray *allSectionKeys = [self.photoManager.photoList allKeys];
        NSArray *sortedSectionKeys = [allSectionKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSString *sectionKey = sortedSectionKeys[indexPath.section];
        NSString *uppercaseSection = [NSString stringWithFormat:@"%@%@", [[sectionKey substringToIndex:1]  uppercaseString], [sectionKey substringFromIndex:1]];
        headerLabel.text = [NSString stringWithFormat:@"%@", uppercaseSection];
        
        
        return header;
    }
    return nil;
}

# pragma mark - Editting Collection View

-(void)moveTargetItem:(UILongPressGestureRecognizer*)sender{
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[sender locationInView:self.collectionView]];
    [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
}


-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
    
}

@end
