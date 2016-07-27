//
//  TableViewController.m
//  Ikitchen
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TableViewController.h"
#import "FoundRestaurantModel.h"
#import "TableViewCell.h"
#import "DaTouZhenViewController.h"
#import "FoundRestaurantViewController.h"
@interface TableViewController ()
@property(nonatomic,strong)FoundRestaurantViewController * fr;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    FoundRestaurantModel * model = self.dataSource[indexPath.row];
    cell.uidLabel.text = model.uid;
    cell.nameLabel.text = model.name;
    cell.typeLabel.text = model.type;
    cell.latitudeLabel.text = model.latitude;
    cell.longtituLabel.text = model.longtitude;
    cell.addressLabel.text = model.address;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  DaTouZhenViewController * datouzhen = [[DaTouZhenViewController alloc]init];
    
   FoundRestaurantModel * model = self.dataSource[indexPath.row];
    
    datouzhen.jing = model.latitude;
    datouzhen.wei = model.longtitude;
    datouzhen.address = model.address;
    datouzhen.name = model.name;
    [self.navigationController pushViewController:datouzhen animated:NO];
  
   
}

@end
