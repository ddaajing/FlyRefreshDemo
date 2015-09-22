//
//  ViewController.m
//  FlyRefreshDemo
//
//  Created by ddaajing on 8/31/15.
//  Copyright (c) 2015 ddaajing. All rights reserved.
//

#import "ViewController.h"
#import "FlyHeaderView.h"
#import "CellDataEntity.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, FlyHeaderViewDelegate>

@property (nonatomic, strong) FlyHeaderView *flyHeaderView;

@property (nonatomic, strong) NSMutableArray *tableData;

@end

@implementation ViewController

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    
    FlyHeaderView *flyHeaderView = [[FlyHeaderView alloc] initWithTableViewAndHeaderHeight:300];
    flyHeaderView.delegate = self;
    flyHeaderView.tableView.delegate = self;
    flyHeaderView.tableView.dataSource = self;
    [self.view addSubview:flyHeaderView];
    self.flyHeaderView = flyHeaderView;
}

- (void)initData {
    CellDataEntity *cell0 = [[CellDataEntity alloc] initWithTitle:@"Photos" andIcon:@"icon1" andPublishDate:@"May 9, 2015"];
    CellDataEntity *cell1 = [[CellDataEntity alloc] initWithTitle:@"Magic Cube Show" andIcon:@"icon2" andPublishDate:@"OCT 11, 2015"];
    CellDataEntity *cell2 = [[CellDataEntity alloc] initWithTitle:@"Meeting Minutes" andIcon:@"icon3" andPublishDate:@"Jun 22, 2015"];
    CellDataEntity *cell3 = [[CellDataEntity alloc] initWithTitle:@"Meeting" andIcon:@"icon1" andPublishDate:@"May 9, 2015"];
    CellDataEntity *cell4 = [[CellDataEntity alloc] initWithTitle:@"Go Shopping" andIcon:@"icon1" andPublishDate:@"May 9, 2015"];
    
    self.tableData = [@[cell0, cell1, cell2, cell3, cell4,] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = ((CellDataEntity *)self.tableData[indexPath.row]).title;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [self.flyHeaderView scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
}

#pragma mark - FlyRefreshViewDelegate
- (void)requestDataWithFlyHeaderView:(FlyHeaderView *)flyHeaderView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)),
       dispatch_get_main_queue(), ^{
           [self didReceivedData];
       });
}

- (void)didReceivedData {
    [self.tableData insertObject:[[CellDataEntity alloc] initWithTitle:@"New Entity" andIcon:@"icon2" andPublishDate:@"Sep 25, 2015"] atIndex:0];
    [self.flyHeaderView sendFlightBack];
}

- (void)didFinishedRefreshWithFlyHeaderView:(FlyHeaderView *)flyHeaderView {
    [self.flyHeaderView.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.flyHeaderView showFeedbackHintWithStatus:FLIGHT_STATUS_SUCCESS];
}

@end
