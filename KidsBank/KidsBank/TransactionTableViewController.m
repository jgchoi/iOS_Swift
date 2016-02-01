//
//  TransactionTableViewController.m
//  KidsBank
//
//  Created by Jung Geon Choi on 2016-01-31.
//  Copyright © 2016 Jung Geon Choi. All rights reserved.
//

#import "TransactionTableViewController.h"
#import "Transaction.h"
#import "TransactionTableViewCell.h"
#define kStoryboardCellIdentifier @"gasTableCell"

@interface TransactionTableViewController ()
@property (strong,nonatomic)NSMutableArray * transactions;
@end

@implementation TransactionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Nib Register
    [self.tableView registerClass:[TransactionTableViewCell class] forCellReuseIdentifier:kStoryboardCellIdentifier];
    
    UINib *cellNib = [UINib nibWithNibName:@"TransactionTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:kStoryboardCellIdentifier];

    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];

    NSSortDescriptor *sdSortDate = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];

    fetchRequest.sortDescriptors = @[sdSortDate];
    
   
    
    NSError *error;
    NSArray *result = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    self.transactions = [NSMutableArray arrayWithArray:result];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.transactions.count;
}



-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        //Delete Record
        [context deleteObject:[self.transactions objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.transactions removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TransactionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kStoryboardCellIdentifier];
    
    //Mileage
    Transaction * record = [self.transactions objectAtIndex:indexPath.row];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *string = [dateFormatter stringFromDate:record.date];
    

    cell.dateLabel.text = string;
    cell.reason.text = record.reason;
    cell.amountLabel.text = [NSString stringWithFormat:@"$ %.2f",[record.amount doubleValue] ];
    if([record.amount doubleValue] < 0 )
        cell.imageView.image = [UIImage imageNamed:@"tdown"];

    else
cell.imageView.image = [UIImage imageNamed:@"tup"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
