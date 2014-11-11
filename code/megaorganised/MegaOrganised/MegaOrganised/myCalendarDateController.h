//
//  myCalendarDateController.h
//  MegaOrganised
//
//  Created by karan singh on 10/20/14.
//  Copyright (c) 2014 karan singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myCalendarDateController :  UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) IBOutlet UILabel *scheduleLabel;
@property (nonatomic, strong) NSString *schedule;

@end
