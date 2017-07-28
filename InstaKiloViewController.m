//
//  InstaKiloViewController.m
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-12.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "InstaKiloViewController.h"
#import "IKCollectionViewCell.h"
#import "CustomCollectionViewCell.h"
#import "PhotoManager.h"
#import "CategorySectionSort.h"
#import "NameSectionSort.h"
#import "IKCollectionViewFlowLayout.h"

@interface InstaKiloViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) PhotoManager *photoManager;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) CategorySectionSort *categorySort;
@property (strong, nonatomic) NameSectionSort *nameSort;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *defaultFlowLayout;
@property (strong, nonatomic) UICollectionViewFlowLayout *customFlowLayout;

@property (strong, nonatomic) CustomCollectionViewCell *customCell;
@property (strong, nonatomic) IKCollectionViewCell *defaultCell;
@property (strong, nonatomic) NSIndexPath *selectedCellIndexPath;

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
    
//    self.customFlowLayout = [[IKCollectionViewFlowLayout alloc] init];
    self.customFlowLayout = [[IKCollectionViewFlowLayout alloc] init];
    self.customFlowLayout.itemSize = CGSizeMake(75, 100);
    self.customFlowLayout.minimumInteritemSpacing = 15;
    self.customFlowLayout.minimumLineSpacing = 20;
    self.customFlowLayout.sectionInset = UIEdgeInsetsMake(20, 30, 20, 30);
    
    //Sorting Objects
    self.photoManager = [[PhotoManager alloc] init];
    self.categorySort = [[CategorySectionSort alloc] init];
    self.nameSort = [[NameSectionSort alloc] init];
    self.photoManager.delegate = self.categorySort;
    [self.photoManager getSectionData];
    
    //Long Press Gesture
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveTargetItem:)];
    longPressGesture.minimumPressDuration = 0.2;
    [self.collectionView addGestureRecognizer:longPressGesture];
    
    [self.collectionView reloadData];
    
    //Tap Gesture
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapDelete:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [self.collectionView addGestureRecognizer:doubleTapGesture];
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
- (IBAction)sortSegmentedControl:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex] == 0){
        self.photoManager.delegate = self.categorySort;
    } else {
        self.photoManager.delegate = self.nameSort;
    }
    [self.photoManager getSectionData];
    [self.collectionView reloadData];
}

- (IBAction)switchFlowLayout:(UISegmentedControl *)sender{
    if (self.collectionView.collectionViewLayout == self.defaultFlowLayout){
        self.collectionView.collectionViewLayout = self.customFlowLayout;
//        self.collectionView.collectionViewLayout = self.defaultFlowLayout;
    } else {
        self.collectionView.collectionViewLayout = self.defaultFlowLayout;
    }
    
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
    if (self.collectionView.collectionViewLayout == self.defaultFlowLayout){
        self.defaultCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ikCell" forIndexPath:indexPath];
        self.defaultCell.photo = [self.photoManager getPhotoAtIndexPath:indexPath];
        [self.defaultCell updateDisplay];
        return self.defaultCell;
    } else {
        self.customCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCell" forIndexPath:indexPath];
        self.customCell.photo = [self.photoManager getPhotoAtIndexPath:indexPath];
        [self.customCell updateDisplay];
        return self.customCell;
    }

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

-(void)doubleTapDelete:(UITapGestureRecognizer*)sender
{
    NSLog(@"Double Tap");
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self.collectionView performBatchUpdates:^{
            
//            NSArray *selectedItemsIndexPaths = [self.collectionView indexPathsForSelectedItems];
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[sender locationInView:self.collectionView]];
            
            if (indexPath){
//                 Delete the items from the data source.
                [self.photoManager deletePhotoFromIndexPath:indexPath];
                
                // Now delete the items from the collection view.
                [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
                
            }
            
        } completion:nil];
    }
}

-(void)moveTargetItem:(UILongPressGestureRecognizer*)sender
{
    NSLog(@"Long Press");
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.selectedCellIndexPath = [self.collectionView indexPathForItemAtPoint:[sender locationInView:self.collectionView]];
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:self.selectedCellIndexPath];
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:self.selectedCellIndexPath];
            [UIView animateWithDuration:0.5 animations:^{
                cell.alpha = 0.3;
                cell.transform = CGAffineTransformScale(sender.view.transform, 1.2, 1.2);
            }];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            if (self.selectedCellIndexPath != [self.collectionView indexPathForItemAtPoint:[sender locationInView:self.collectionView]] && [self.collectionView indexPathForItemAtPoint:[sender locationInView:self.collectionView]])
            {
                self.selectedCellIndexPath = [self.collectionView indexPathForItemAtPoint:[sender locationInView:self.collectionView]];
            }
            [self.collectionView updateInteractiveMovementTargetPosition:[sender locationInView:sender.view]];
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:self.selectedCellIndexPath];
            cell.alpha = 0.3;
            cell.transform = CGAffineTransformScale(sender.view.transform, 1.2, 1.2);
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            [self.collectionView endInteractiveMovement];
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:self.selectedCellIndexPath];
            [UIView animateWithDuration:0.7 animations:^{
                cell.transform = CGAffineTransformScale(sender.view.transform, 1, 1);
                cell.alpha = 1;
            }];
            
            
            break;
        }
        default:
        {
            [self.collectionView cancelInteractiveMovement];
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:self.selectedCellIndexPath];
            cell.alpha = 1;
            cell.transform = CGAffineTransformScale(sender.view.transform, 1, 1);
            break;
        }
    }
}


-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.photoManager movePhotoFromIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



@end
