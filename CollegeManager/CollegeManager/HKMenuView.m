//
//  HKMenuView.m
//  SlideMenu3D
//
//  Created by Edgar on 4/6/15.
//  Copyright (c) 2015 @hunk. All rights reserved.
//

#import "HKMenuView.h"
#import "HKAppDelegate.h"
#import "CollegeManager-Swift.h"




@interface HKMenuView (){
    
    NSArray *images;
    NSArray *titles;
}
@end

@implementation HKMenuView



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    images = @[@"mail-ico",@"call-ico",@"call-ico",@"call-ico"];
    titles = @[@"+ Disciplina",@"+ Trabalho",@"+ Prova",@"Agenda"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return images.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"CellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [titles objectAtIndex:indexPath.row];
    
    
    
    UIFont *correctFont = [UIFont boldSystemFontOfSize: 27];
    cell.textLabel.font = correctFont;
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {

        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CadastroDisciplina"];
//        UIViewController *vc = [[CadastroViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:vc animated:YES completion:nil];
        [[HKAppDelegate mainDelegate] setFirstView];
//        [self showViewController:[mainStoryboard instantiateViewControllerWithIdentifier:@"CadastroView"] sender:self];
    }else{
        if (indexPath.row == 3) {
//            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController *vc = [[CalendarViewController alloc] init];
            vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//            vc.view.backgroundColor = [UIColor clearColor];
//            [self addChildViewController:vc];
            vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//            [self showViewController:vc sender:nil];
            [self presentViewController:vc animated:YES completion:nil];
            [[HKAppDelegate mainDelegate] setFirstView];
        }else{
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CadastroAvaliacao"];
            //        UIViewController *vc = [[CadastroViewController alloc] init];
            
            vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:vc animated:YES completion:nil];
            [[HKAppDelegate mainDelegate] setFirstView];
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


@end
