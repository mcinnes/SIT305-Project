//
//  RequestedRidesViewController.m
//  University Car Pooling
//
//  Created by Matt McInnes on 26/04/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import "RequestedRidesViewController.h"
#import "RideInfoViewController.h"
#import "SimpleTableCell.h"
@interface RequestedRidesViewController ()

@end

@implementation RequestedRidesViewController {
    PFObject *ride;

}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        self.parseClassName = @"currentlyLooking";
        self.textKey = @"destination";

        // The title for this table in the Navigation Controller.
        self.title = @"Requested Rides";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 10;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:@"currentlyLooking"];
    
    // If Pull To Refresh is enabled, query against the network by default.
    if (self.pullToRefreshEnabled) {
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }
    
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyNetworkElseCache;
    }
    
    // Order by date created
    [query orderByAscending:@"createdAt"];
    
    return query;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    ride = [self.objects objectAtIndex:indexPath.row];
    
    //Call de second view with the selected Category on iniWithCategory:obj.objectId
    [self performSegueWithIdentifier:@"RideInfo" sender:self];
   
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.textLabel.text = [object objectForKey:@"location"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Priority: %@", [object objectForKey:@"destinationDescription"]];
    
    return cell;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[RideInfoViewController class]]) {
        RideInfoViewController *rideInfoVC = (RideInfoViewController *) segue.destinationViewController;
        rideInfoVC.ride = ride;
    }
    
}

@end
