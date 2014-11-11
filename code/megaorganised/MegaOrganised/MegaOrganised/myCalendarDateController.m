//
//  myCalendarDateController.m
//  MegaOrganised
//
//  Created by karan singh on 10/20/14.
//  Copyright (c) 2014 karan singh. All rights reserved.
//

#import "myCalendarDateController.h"


@interface myCalendarDateController () {
     NSArray * data;
}

@end

@implementation myCalendarDateController

@synthesize scheduleLabel;
@synthesize schedule;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 7;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [data objectAtIndex:row];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    scheduleLabel.text = schedule;

    if([schedule isEqualToString:@"Daily"]){
        UIDatePicker* scheduleView = [[UIDatePicker alloc] init];
        scheduleView.datePickerMode = UIDatePickerModeTime;
        scheduleView.center = self.view.center;
        
        [self.view addSubview:scheduleView];
    } else if([schedule isEqualToString:@"Weekly"]){
        data = [NSArray arrayWithObjects:@"Mon", @"Tue", @"Wed", @"Thu" ,@"Fri", @"Sat", @"Sun",  nil];
        UIPickerView* dailyView = [[UIPickerView alloc] init];
        dailyView.delegate = self;
        dailyView.dataSource = self;
        dailyView.center = self.view.center;
        
        [self.view addSubview:dailyView];
    } else if ([schedule isEqualToString:@"Monthly"]) {
        UIDatePicker* scheduleView = [[UIDatePicker alloc] init];
        scheduleView.datePickerMode = UIDatePickerModeDateAndTime;
        scheduleView.center = self.view.center;
        
        [self.view addSubview:scheduleView];
    }
    else {
        UIDatePicker* scheduleView = [[UIDatePicker alloc] init];
        scheduleView.datePickerMode = UIDatePickerModeDate;
        scheduleView.center = self.view.center;
        
        [self.view addSubview:scheduleView];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
