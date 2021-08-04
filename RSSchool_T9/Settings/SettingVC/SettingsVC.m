//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 31.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "SettingsVC.h"

//MARK: private TableCell for Stroke color
//with subtitle
@interface  TableCellForColor : UITableViewCell
@end

@implementation TableCellForColor

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    return self;
}

@end

//actually a Settings
@interface SettingsVC ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.whiteColor];
    _turnedTimer = YES;
    
    self.dataSource = @[
        @"Draw stories",
        @"Stroke color"
    ];
    
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    [table setScrollEnabled:NO];
    table.translatesAutoresizingMaskIntoConstraints = NO;
    [table setDataSource: (id<UITableViewDataSource>) self];
    [table setDelegate: (id<UITableViewDelegate>) self];
    [table registerClass:UITableViewCell.class forCellReuseIdentifier:@"Draw stories"];
    [table registerClass:TableCellForColor.class forCellReuseIdentifier:@"Stroke color"];
    [self.view addSubview:table];
    self.tableView = table;
    
    [NSLayoutConstraint activateConstraints:@[
       [table.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
       [table.topAnchor constraintEqualToAnchor:self.view.topAnchor],
       [table.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
       [table.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ]];
}

-(UISwitch *) returnSwitchForTimer {
    UISwitch *swc = [[UISwitch alloc] init];
    [swc addTarget:self action:@selector(touchTimer) forControlEvents:UIControlEventTouchUpInside];
    [swc setOn: _turnedTimer];
    return swc;
}

//selector
-(void) touchTimer {
    (_turnedTimer == YES) ? (_turnedTimer = NO) : (_turnedTimer = YES);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

@end



//MARK: subscribe on delegate and datasource for TableView
@interface SettingsVC (ForTableView) <UITableViewDataSource, UITableViewDelegate>
@end


@implementation SettingsVC (ForTableView)

//DataSource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell;

    if ([_dataSource[indexPath.row] isEqualToString:@"Draw stories"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Draw stories"];
        cell.accessoryView = [self returnSwitchForTimer];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Stroke color"];
        
        NSString *color = _listOfColor.selectedColor;
        (color == nil) ? (cell.detailTextLabel.text = @"#f3af22") : (cell.detailTextLabel.text = color);
       
        cell.detailTextLabel.textColor = [UIColor colorNamed: cell.detailTextLabel.text];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


//Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_dataSource[indexPath.row] isEqualToString:@"Stroke color"]) {
        ColorListTableVC *vc;
        if (_listOfColor == nil) {
           vc = [[ColorListTableVC alloc] initWithStyle:UITableViewStyleInsetGrouped];
            _listOfColor = vc;
        }
        [self.navigationController pushViewController:_listOfColor animated:YES];
    }
}

@end




