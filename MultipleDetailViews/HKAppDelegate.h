//
//  HKAppDelegate.h
//  SlideMenu3D
//
//  Created by CocoaPods on 04/06/2015.
//  Copyright (c) 2014 @hunk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "HKSlideMenu3DController.h"
#import "HKRotationNavigationController.h"

@interface HKAppDelegate : UIResponder <UIApplicationDelegate> 

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)  HKSlideMenu3DController *slideMenuVC;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (HKAppDelegate *)mainDelegate;
- (void)setFirstView;
- (void)setSecondView;

@end
