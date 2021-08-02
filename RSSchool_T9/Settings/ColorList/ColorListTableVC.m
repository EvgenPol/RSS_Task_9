//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 31.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "ColorListTableVC.h"

@interface ColorListTableVC ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ColorListTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [self fillingData];
    _selectedColor = @"#f3af22";
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Color"];
}

-(NSArray *)fillingData {
    return @[
        @"#be2813",
        @"#3802da",
        @"#467c24",
        @"#808080",
        @"#8e5af7",
        @"#f07f5a",
        @"#f3af22",
        @"#3dacf7",
        @"#e87aa4",
        @"#0f2e3f",
        @"#213711",
        @"#511307",
        @"#92003b"
    ];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Color" forIndexPath:indexPath];
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.textLabel.textColor = [UIColor colorNamed: _dataSource[indexPath.row]];
    cell.tintColor = UIColor.redColor;

    if ([cell.textLabel.text  isEqualToString:_selectedColor]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedColor = _dataSource[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [tableView reloadData];
        [timer invalidate];
    }];
    timer.tolerance = 0.1;
}

@end
