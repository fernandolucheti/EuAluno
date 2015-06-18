//
//  HKAppDelegate.m
//  SlideMenu3D
//
//  Created by CocoaPods on 04/06/2015.
//  Copyright (c) 2014 @hunk. All rights reserved.
//

#import "HKAppDelegate.h"

#import "HKMenuView.h"
#import "CollegeManager-Swift.h"

@interface HKAppDelegate () <HKSlideMenu3DControllerDelegate, UISplitViewControllerDelegate> {

    HKMenuView *menuVC;
    HKRotationNavigationController *navMain;
    DetailViewController *altVC;
}

@end

@implementation HKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Override point for customization after application launch.
   // self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    

        //        //Override point for customization after application launch.
    _isFirstAccess = true;
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    splitViewController.presentsWithGesture = NO;
    splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryOverlay;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    
    splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;

    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    
    splitViewController.delegate = self;
    
    //return YES;
    
    
    self.slideMenuVC = [[HKSlideMenu3DController alloc] init];
    self.slideMenuVC.view.frame =  [[UIScreen mainScreen] bounds];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    menuVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"HKMenuView"];
    menuVC.view.backgroundColor = [UIColor clearColor];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        navMain = (HKRotationNavigationController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"split"];
    }else{
        navMain = (HKRotationNavigationController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"navMain"];
    }
    navMain = (HKRotationNavigationController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"split"];
    self.slideMenuVC.menuViewController = menuVC;
    
    self.slideMenuVC.mainViewController = navMain;
    UIImage *img = [UIImage imageNamed:@"cloud6.jpg"];
    self.slideMenuVC.backgroundImage = img;


    self.slideMenuVC.backgroundImageContentMode = UIViewContentModeScaleAspectFill;
    self.slideMenuVC.enablePan = YES;
    
    //Set delegate methods in currect controller or another class, for example Menu
    //self.slideMenuVC.delegate = navMain.self;
    self.slideMenuVC.delegate = menuVC.self;
    
    //NSLog(NSStringFromClass(self.window.rootViewController));
    
    [self.window setRootViewController:self.slideMenuVC];

    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (HKAppDelegate *)mainDelegate {
    return (HKAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)setFirstView{
    
    if (!navMain) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        navMain = (HKRotationNavigationController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"navMain"];
    }
    
    self.slideMenuVC.mainViewController = navMain;
    
//    if ([UIViewController class]) {
//        
//        if ( !UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)  ) {
//            [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
//        }
//    }
    
}

- (void)setSecondView{
    
    if (!altVC) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
        altVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"HKAlternativeView"];
    }
    self.slideMenuVC.mainViewController = altVC;
    // iOS8 has this class only
    if ([UIViewController class]) {
        
        if ( !UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)  ) {
            [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
        }
    }
}

#pragma mark HKSlideMenu3DControllerDelegate methods
-(void)willOpenMenu{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void)didOpenMenu{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void)willCloseMenu{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void)didCloseMenu{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "Jhpg.TesteCoreDataObj_C" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CollegeManager" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CollegeManager.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}




@end
