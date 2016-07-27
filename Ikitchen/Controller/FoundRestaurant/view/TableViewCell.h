//
//  TableViewCell.h
//  Ikitchen
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
/*
 cell.uidLabel.text = model.uid;
 cell.nameLabel.text = model.name;
 cell.typeLabel.text = model.type;
 cell.latitudeLabel.text = model.latitude;
 cell.longtituLabel.text = model.longtitude;
 cell.addressLabel.text = model.address;*/


@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;


@property (weak, nonatomic) IBOutlet UILabel *longtituLabel;



@property (weak, nonatomic) IBOutlet UILabel *uidLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
