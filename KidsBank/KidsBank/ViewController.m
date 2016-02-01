//
//  ViewController.m
//  KidsBank
//
//  Created by Jung Geon Choi on 2016-01-31.
//  Copyright © 2016 Jung Geon Choi. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "Transaction.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UITextField *commentField;
@property (strong, nonatomic) User * user;
@property (weak, nonatomic) IBOutlet UITextField *amountField;
@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation ViewController
- (IBAction)goodButton:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];

    Transaction * newRecord = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:context];

    
    newRecord.date = self.selectedDate;
    newRecord.reason = self.commentField.text;
    newRecord.amount = [NSNumber numberWithDouble:0.25];
    newRecord.user = self.user;
    
    NSError *error = nil;
    self.user.balance = [NSNumber numberWithDouble:[self.user.balance doubleValue] + [newRecord.amount doubleValue] ];
    
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self updateBalance];

}
- (IBAction)badButton:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    Transaction * newRecord = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:context];
    
    
    newRecord.date = self.selectedDate;
    newRecord.reason = self.commentField.text;
    newRecord.amount = [NSNumber numberWithDouble:-0.25];
    newRecord.user = self.user;
    
    NSError *error = nil;
      self.user.balance = [NSNumber numberWithDouble:[self.user.balance doubleValue] + [newRecord.amount doubleValue] ];
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self updateBalance];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateBalance];
    
}
- (IBAction)addButton:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
     if( [self.amountField.text doubleValue]<0 || self.amountField.text.length == 0){
         
         UIAlertController * view=   [UIAlertController
                                      alertControllerWithTitle:@"Invalid Amount"
                                      message:@"얼마를 넣을지 알려주셔야져"
                                      preferredStyle:UIAlertControllerStyleActionSheet];
         
         UIAlertAction* cancel = [UIAlertAction
                                  actionWithTitle:@"Ok"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      [view dismissViewControllerAnimated:YES completion:nil];
                                      
                                  }];
         
      
         [view addAction:cancel];
         
         [self presentViewController:view animated:YES completion:nil];

     }else{
    
    Transaction * newRecord = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:context];
    
    
    newRecord.date = self.selectedDate;
    newRecord.reason = self.commentField.text;
   
    newRecord.amount = [NSNumber numberWithDouble:[self.amountField.text doubleValue]];
    newRecord.user = self.user;
    
         self.user.balance = [NSNumber numberWithDouble:[self.user.balance doubleValue] + [newRecord.amount doubleValue] ];
    NSError *error = nil;
    
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self updateBalance];
     }
  }

- (IBAction)endEdit:(UITextField *)sender {
    [sender resignFirstResponder];
}
- (IBAction)asdf:(UITextField *)sender {
        [sender resignFirstResponder];
}

- (void)updateBalance{
    NSManagedObjectContext *context = [self managedObjectContext];
    
   
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    self.selectedDate = [NSDate date];
    
    NSError *error;
    NSArray *result = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    self.user = [result firstObject];
    self.balanceLabel.text = [NSString stringWithFormat:@"$ %.2f", [self.user.balance doubleValue]];
    
    if(self.user == nil){
        User * newRecord = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        
        
        newRecord.balance = 0;
        
    }
    
    self.amountField.text = @"";
    self.commentField.text = @"";
    
}
- (IBAction)minusButton:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    if( [self.amountField.text doubleValue]<0 || self.amountField.text.length == 0){
        
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@"Invalid Amount"
                                     message:@"얼마를 넣을지 알려주셔야져"
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"Ok"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [view dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
        
        
        [view addAction:cancel];
        
        [self presentViewController:view animated:YES completion:nil];
        
    }else{
        
        Transaction * newRecord = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:context];
        
        
        newRecord.date = self.selectedDate;
        newRecord.reason = self.commentField.text;
        
        newRecord.amount = [NSNumber numberWithDouble:-[self.amountField.text doubleValue]];
        newRecord.user = self.user;
        
        NSError *error = nil;
        
          self.user.balance = [NSNumber numberWithDouble:[self.user.balance doubleValue] + [newRecord.amount doubleValue] ];
        
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
  
        [self updateBalance];
    }

    
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


@end
