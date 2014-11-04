//
//  ViewController.m
//  mytest1
//
//  Created by Yotam Sher on 10/27/14.
//  Copyright (c) 2014 addresses. All rights reserved.
//

#import "AddItemViewController.h"

@import AddressBook;

@interface AddItemViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

- (IBAction)bringContatcs:(id)sender;
@end

@implementation AddItemViewController
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( sender != self.doneButton) return;
    
    if( self.textField.text.length > 0)
    {
        self.todoItem = [[MyTodoItem alloc] init];
        self.todoItem.itemName = self.textField.text;
        self.todoItem.completed = NO;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.


}

- (BOOL)check_contacts_permission {
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
        NSLog(@"Permission to contacts denied");
        return false;
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        NSLog(@"Authorized");
        return true;
    } else{ //ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
        NSLog(@"Not determined");
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                if (!granted){
                    UIAlertView *cantAddContactAlert = [[UIAlertView alloc] initWithTitle: @"Cannot use Contacts" message: @"You must give the app permission to add the contact first." delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
                    [cantAddContactAlert show];
                    return;
                }
                
                NSLog(@"Just authorized");
            });
        });
        return false;
    }
}

- (IBAction)bringContatcs:(id)sender {
    
    if([self check_contacts_permission])
    {
        UIAlertView *contactExistsAlert = [[UIAlertView alloc]initWithTitle: @"going to bring contacts" message:@"please wait" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [contactExistsAlert show];
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);

        NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
        for (id record in allContacts){
            ABRecordRef thisContact = (__bridge ABRecordRef)record;
            NSString* name  = (__bridge_transfer NSString*) ABRecordCopyValue(thisContact, kABPersonFirstNameProperty);
            
            NSLog(@"found person name: %@", name );
            NSString* phone = nil;
            ABMultiValueRef phoneNumbers = ABRecordCopyValue(thisContact, kABPersonPhoneProperty);
/*            if(ABMultiValueGetCount(phoneNumbers) > 0)
            {
                phone = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
                NSLog([NSString stringWithFormat:@"phone#: %@", phone] );
            }
            else
            {
                NSLog(@"[No Phone number found]");
            }
  */
        for (int i=0; i < ABMultiValueGetCount(phoneNumbers); i++) {
            CFStringRef currentPhoneLabel = ABMultiValueCopyLabelAtIndex(phoneNumbers, i);
            CFStringRef currentPhoneValue = ABMultiValueCopyValueAtIndex(phoneNumbers, i);
            
            NSLog(@"[%@] number: %@", currentPhoneLabel, currentPhoneValue);
            phone = (__bridge NSString *)(currentPhoneValue);
            if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMobileLabel, 0) == kCFCompareEqualTo) {
                //            [contactInfoDict setObject:(__bridge NSString *)currentPhoneValue forKey:@"mobileNumber"];
            }
            
            if (CFStringCompare(currentPhoneLabel, kABHomeLabel, 0) == kCFCompareEqualTo) {
                //            [contactInfoDict setObject:(__bridge NSString *)currentPhoneValue forKey:@"homeNumber"];
            }
            
            CFRelease(currentPhoneLabel);
            CFRelease(currentPhoneValue);
        }
        CFRelease(phoneNumbers);
        
        NSString* eMailAddress = nil;
        ABMultiValueRef emailAddresses = ABRecordCopyValue(thisContact, kABPersonEmailProperty);
        for(int i=0; i< ABMultiValueGetCount(emailAddresses); i++){
            CFStringRef currentEmailLabel = ABMultiValueCopyLabelAtIndex(emailAddresses, i);
            CFStringRef currentEmailValue = ABMultiValueCopyValueAtIndex(emailAddresses, i);
            
            NSLog([NSString stringWithFormat:@"[%@] email: %@", currentEmailLabel, currentEmailValue]);
            eMailAddress = (__bridge NSString *)(currentEmailValue);
            CFRelease(currentEmailLabel);
            CFRelease(currentEmailValue);
        }
        }
        
        }
    
}

@end
