//
//  ViewController.m
//  FlyRefreshDemo
//
//  Created by ddaajing on 8/31/15.
//  Copyright (c) 2015 ddaajing. All rights reserved.
//

#import "ViewController.h"
#import "FlyHeaderView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) FlyHeaderView *flyHeaderView;

@end

@implementation ViewController

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    FlyHeaderView *flyHeaderView = [[FlyHeaderView alloc] initWithTableViewAndHeaderHeight:300];
    flyHeaderView.tableView.delegate = self;
    flyHeaderView.tableView.dataSource = self;
    [self.view addSubview:flyHeaderView];
    self.flyHeaderView = flyHeaderView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [self.flyHeaderView scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
}
@end
