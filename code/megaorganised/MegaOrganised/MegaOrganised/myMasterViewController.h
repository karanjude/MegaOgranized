//
//  myMasterViewController.h
//  MegaOrganised
//
//  Created by karan singh on 10/10/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class Task;
@class Tasks;

@interface myMasterViewController : UITableViewController

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic, strong) Task* task;
@property (nonatomic, strong) Task* parent;
@property (nonatomic, strong) myMasterViewController* parentTaskViewController;



@end
