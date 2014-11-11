//
//  myMasterViewController.m
//  MegaOrganised
//
//  Created by karan singh on 10/10/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "myMasterViewController.h"

#import "myDetailViewController.h"

#import "Task.h"
#import "Tasks.h"

@interface myMasterViewController () <UITextFieldDelegate, NSFetchedResultsControllerDelegate> {
    NSMutableArray *_objects;
    NSArray * taskSections;
    NSArray * subTasks;
    NSArray * taskTags;
    NSArray * taskSchedule;
}

@property (nonatomic, strong) Tasks* tasks;

@end

@implementation myMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (IBAction)addSubTaskAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UINavigationController * vc = [storyboard instantiateViewControllerWithIdentifier:@"AddTask"];
    vc.title = @"Add Sub Task";
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;

    if(taskSections == nil){
        taskSections = [NSArray arrayWithObjects:@"Description", @"Subtasks", @"Categories", @"Occurs",  nil];
    }
    
    if(subTasks == nil){
        subTasks = [NSArray arrayWithObjects:@"Wakeup",@"Shower",@"Start Work",@"Check Mail",@"Have Meeting", @"Have Lunch", nil];
    }
    
    if(taskTags == nil)
    {
        taskTags = [NSArray arrayWithObjects:@"Work",@"Activity", nil];
    }
    
    if(taskSchedule == nil)
    {
        taskSchedule = [NSArray arrayWithObjects:@"Daily", nil];
    }
    
    if(self.tasks == nil){
        self.tasks = [[Tasks alloc] initTasks];
    }
    
    if(self.task == nil){
        self.task = [self.tasks rootItem:self.parent];
    }
    
    if(self.fetchedResultsController == nil){
        self.fetchedResultsController = [self.task childrenFetchedResultsController:self.parent];
        self.fetchedResultsController.delegate = self;
    }
    
    if(self.parent == nil){
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    }
    
    [self.fetchedResultsController performFetch:NULL];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    NSError *error = nil;
    NSManagedObjectContext *context = nil;
    
    if(self.parent != nil){
        context = self.parent.managedObjectContext;
    }else{
        context = self.task.managedObjectContext;
    }
    

    if (! [context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }

    
    if(self.parentTaskViewController != nil){
        [self.tableView reloadData];
        if(self.parentTaskViewController != nil){
            [self.parentTaskViewController.tableView reloadData];
        }
        [self.navigationController popToViewController:self.parentTaskViewController animated:YES];
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSString* title = textField.text;
    [self.task setTaskDescription:title];
    [textField resignFirstResponder];
    
    /*
    NSManagedObjectContext* objectContext;
    if(self.parent == nil){
        objectContext = self.tasks.managedObjectContext;
    }else{
        objectContext = self.parent.managedObjectContext;
    }
        
    NSError *error = nil;
    if (! [objectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
     */
    return NO;
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@" numberOfSectionsInTableView: %@, %@", taskSections, @([taskSections count]));

    //return self.fetchedResultsController.sections.count;
    return [taskSections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{

    switch (sectionIndex) {
        case 1:
            NSLog(@"Children count: %@", @(self.task.children.count));
            return self.task.children.count;
            //return [subTasks count];
            
        case 2:
            return [taskTags count];

        case 3:
            return [taskSchedule count];
            
        
    }
     
     return 1;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"willDisplayCell: %@", @(indexPath.section));

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    
    Task* subTask = nil;
    if(indexPath.section == 1){
        NSArray * subtasks =  [self.task.children allObjects];
        subTask = subtasks[indexPath.row];
    }
    
    switch (indexPath.section) {
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            cell.textLabel.text = subTask.taskDescription;

            /*
            cell.indentationLevel = indexPath.row;
            cell.indentationWidth = 10.0f;
            */
             break;
            
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            cell.textLabel.text = taskTags[indexPath.row];
            //cell.textLabel.text = task.taskDescription;

            break;
            
        case 3:
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            cell.textLabel.text = taskSchedule[indexPath.row];
            //cell.textLabel.text = task.taskDescription;

            break;
            
        default:

            cell = [tableView dequeueReusableCellWithIdentifier:@"DescriptionCell" forIndexPath:indexPath];
            UITextField* descriptionField = (UITextField*)[cell viewWithTag:11];
            descriptionField.delegate = self;
            descriptionField.text = self.task.taskDescription;
            
            /*
            if(_task != nil){
                descriptionField.text = _task.taskDescription;
            }
            descriptionField.layer.cornerRadius=8.0f;
            descriptionField.layer.masksToBounds=YES;
            descriptionField.layer.borderColor = [[UIColor blueColor] CGColor];
            descriptionField.layer.borderWidth = 1.0f;
            descriptionField.text = @"boo";
             */
             
            break;
    }
    
    
    //NSDate *object = _objects[indexPath.row];
    return cell;
}

/*
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
*/

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == 1) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if(indexPath.section == 1){
            [self.tableView beginUpdates];

            NSArray * subtasks =  [self.task.children allObjects];
            Task* subTask = subtasks[indexPath.row];
            [self.task.managedObjectContext deleteObject:subTask];
            
            NSError *error = nil;
            if (! [self.task.managedObjectContext save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            }
            
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
            
            [self.tableView endUpdates];

        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        if(self.parentTaskViewController != nil){
            [self.parentTaskViewController.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }

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
}he
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString* identifier = [segue identifier];
    if ([identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
    if([segue.identifier isEqualToString:@"AddSubTaskSegue"]){
        myMasterViewController* controller = segue.destinationViewController;
        controller.title = @"Add Sub Task";
        controller.tasks = self.tasks;
        controller.parent = self.task;
        controller.parentTaskViewController = self;
        //controller.fetchedResultsController = self.fetchedResultsController;
        //controller.fetchedResultsController.delegate = controller;
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSLog(@" titleForHeaderInSection: %@, %@, %@", taskSections, @(section), taskSections[section]);

    if(self.parentTaskViewController != nil && section == 1){
        return nil;
    }

    
    return taskSections[section];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    

    NSLog(@" viewForHeaderInSection: %@, %@, %@", taskSections, @(section), taskSections[section]);

    if(self.parentTaskViewController != nil && section == 1){
        return nil;
    }

    
    NSString* headerCellIdentifier;
    switch (section) {
        case 0:
            headerCellIdentifier = @"TaskDescriptionHeaderCell";
            break;
        case 1:
            headerCellIdentifier = @"TaskSubtaskHeaderCell";
            break;
        case 2:
            headerCellIdentifier = @"TaskCategoryHeaderCell";
            break;
        case 3:
            headerCellIdentifier = @"TaskScheduleHeaderCell";
            break;
            
    }

    
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:headerCellIdentifier];
    UILabel* headerLabel = (UILabel*)[headerView viewWithTag:1];
    headerLabel.text = taskSections[section];
    

    //TODO: for description section remove the + button
    /*
    if( section == 0){
        UIButton addButton = (UIButton*) [headerView viewWithTag:2];

    }*/
    
    return headerView;
}


- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller
{
   // [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController*)controller
{
    //[self.tableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    NSLog(@" %@ %@ %@ ", sectionInfo, @(sectionIndex), @(type));
}


- (void)controller:(NSFetchedResultsController*)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath*)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath*)newIndexPath
{
    NSLog(@" %@ %@ %@ %@", anObject, @(indexPath.section), @(type), @(newIndexPath.section));
    
    if (type == NSFetchedResultsChangeInsert) {
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeMove) {
        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
    } else if (type == NSFetchedResultsChangeDelete) {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeUpdate){
        
        NSLog(@" %@ %@ %@ %@", anObject, @(indexPath.section), @(type), @(newIndexPath.section));
        /*
            Task* parentTask = anObject;
            
            NSError *error = nil;
            if (! [parentTask.managedObjectContext save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            }
            
         
            [self.parentTaskViewController.tableView reloadData];
         */

    }
    
    
}

@end
