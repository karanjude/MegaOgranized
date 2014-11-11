//
//  myChooseTaskScheduleController.m
//  MegaOrganised
//
//  Created by karan singh on 10/12/14.
//  Copyright (c) 2014 karan singh. All rights reserved.
//

#import "myChooseTaskScheduleController.h"

#import "myCalendarDateController.h"

@interface myChooseTaskScheduleController (){
    NSArray * scheduleSections;
    NSArray * scheduleData;
    NSArray * scheduleCategories;
    NSString * scheduleValue;
}

@end

@implementation myChooseTaskScheduleController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    return [scheduleCategories count];
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [scheduleCategories objectAtIndex:row];
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    scheduleValue = scheduleCategories[row];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(scheduleSections == nil){
        scheduleSections = [NSArray arrayWithObjects:@"Occurs", @"Occurs At",  nil];
    }
    
    if(scheduleData == nil){
        scheduleData = [NSArray arrayWithObjects:@"7 PM", @"11 PM",  nil];
    }
    
    if (scheduleCategories == nil) {
        scheduleCategories = [NSArray arrayWithObjects: @"Daily", @"Weekly", @"Monthly", @"Yearly", nil];
    }

    scheduleValue = scheduleCategories[0];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [scheduleSections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;

        case 1:
            return [scheduleData count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) { // this is my picker cell
            return 219;
    } else {
        return self.tableView.rowHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"SelectScheduleCell" forIndexPath:indexPath];
        UIPickerView* pickerView = (UIPickerView*)[cell viewWithTag:1];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        [pickerView reloadAllComponents];
        
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"ScheduleCell" forIndexPath:indexPath];
        UILabel* scheduleLabel = (UILabel*)[cell viewWithTag:2];
        scheduleLabel.text = scheduleData[indexPath.row];
    }
    
    return cell;

}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return scheduleSections[section];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Set the text color of our header/footer text.
    //UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    //[header.textLabel setTextColor:[UIColor whiteColor]];
    
    // Set the background color of our header/footer.
    //header.contentView.backgroundColor = [UIColor blueColor];
    
    // You can also do this to set the background color of our header/footer,
    //    but the gradients/other effects will be retained.
    // view.tintColor = [UIColor blackColor];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"chooseCalendarDateSegue"]){
        myCalendarDateController* calendarDateController = segue.destinationViewController;
        calendarDateController.schedule = scheduleValue;
    }
}




@end
