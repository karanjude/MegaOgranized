//
//  Tasks.m
//  
//
//  Created by karan singh on 10/31/14.
//
//

#import <CoreData/CoreData.h>
#import "Task.h"
#import "Tasks.h"

@implementation Tasks

- (Task*)rootItem:(Task*)taskParent
{
    // todo: use a cache?
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
    request.predicate = [NSPredicate predicateWithFormat:@"parent = %@", taskParent];

    NSManagedObjectContext* objectContext = self.managedObjectContext;
    if(taskParent != nil){
        objectContext = taskParent.managedObjectContext;
    }
    
    Task* rootItem;
    
    if (taskParent == nil) {
        NSArray* objects = [objectContext executeFetchRequest:request error:NULL];
        rootItem = [objects lastObject];
        
        if (rootItem == nil) {
            rootItem = [Task insertItemWithTitle:@"Task Description" parent:taskParent inManagedObjectContext:objectContext];
        }
    }else{
        rootItem = [Task insertItemWithTitle:@"Sub Task Description" parent:taskParent inManagedObjectContext:objectContext];
    }
    
    return rootItem;
}

- (id)initTasks
{
    self = [super init];
    if (self) {
        [self setupManagedObjectContext];
    }
    return self;
}

- (void)setupManagedObjectContext
{
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSError* error;
    [self.managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.storeURL options:nil error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    }
    self.managedObjectContext.undoManager = [[NSUndoManager alloc] init];
}

- (NSManagedObjectModel*)managedObjectModel
{
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
}

- (NSURL*)storeURL
{
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    return [documentsDirectory URLByAppendingPathComponent:@"db.sqlite"];
}

- (NSURL*)modelURL
{
    return [[NSBundle mainBundle] URLForResource:@"TaskModel" withExtension:@"momd"];
}


@end
