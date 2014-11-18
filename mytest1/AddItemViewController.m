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

- (IBAction)bringContacts:(id)sender;
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

- (IBAction)bringContacts:(id)sender {
    
    if([self check_contacts_permission])
    {
        UIAlertView *waitAlert = [[UIAlertView alloc]initWithTitle: @"going to bring contacts" message:@"please wait" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [waitAlert show];
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);

        NSMutableArray *contactsArray = [[NSMutableArray alloc] init];
        NSArray *allContacts = CFBridgingRelease( ABAddressBookCopyArrayOfAllPeople(addressBookRef) );
        int j = 0;
        NSMutableDictionary *phonesDictionary = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *emailsDictionary = [[NSMutableDictionary alloc] init];
        for (id record in allContacts){
            j++;
            [phonesDictionary removeAllObjects];
            [emailsDictionary removeAllObjects];
            ABRecordRef thisContact = (__bridge ABRecordRef)record;
            NSString* name  = (__bridge_transfer NSString*) ABRecordCopyValue(thisContact, kABPersonFirstNameProperty);
            if(name == nil)
            {
                name=@"";
            }
            NSString* lastName  = (__bridge_transfer NSString*) ABRecordCopyValue(thisContact, kABPersonLastNameProperty);
            if(lastName == nil)
            {
                lastName=@"";
            }
            NSNumber *contactId = [NSNumber numberWithInt: ABRecordGetRecordID ( thisContact )];
            NSLog(@"found person name: %@", name );
            ABMultiValueRef phoneNumbers = ABRecordCopyValue(thisContact, kABPersonPhoneProperty);
            for (int i=0; i < ABMultiValueGetCount(phoneNumbers); i++) {
            
            NSString * originalPhoneLabel = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(phoneNumbers, i);
            NSString * currentPhoneValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, i);
                NSString * currentPhoneLabel = nil;
            NSString * other =[phonesDictionary valueForKey: currentPhoneLabel];
            
            if(other == nil){
                currentPhoneLabel = [NSString stringWithString:originalPhoneLabel ];
            }else{
                currentPhoneLabel = [NSString stringWithFormat:@"%@_%d", originalPhoneLabel, 2];
            }
            [phonesDictionary setObject: currentPhoneValue forKey:currentPhoneLabel];
            
            }
        CFRelease(phoneNumbers);
        
        ABMultiValueRef emailAddresses = ABRecordCopyValue(thisContact, kABPersonEmailProperty);
        for(int i=0; i< ABMultiValueGetCount(emailAddresses); i++){
            //CFStringRef currentEmailLabel = ABMultiValueCopyLabelAtIndex(emailAddresses, i);
            NSString * currentEmailLabel = [NSString stringWithFormat:@"Email%d", i];
            CFStringRef currentEmailValue = ABMultiValueCopyValueAtIndex(emailAddresses, i);
            [emailsDictionary setObject:(__bridge id)(currentEmailValue) forKey:currentEmailLabel];
            
             CFRelease(currentEmailValue);
        }
            	NSDictionary * contactDict = @{@"Id" : contactId,
                                          @"First name" : name,
                                          @"Last name" : lastName,
                                          @"Phones": phonesDictionary,
                                          @"Emails":emailsDictionary};
            
          [contactsArray addObject:contactDict];
            if( j%30 == 0 )
            {
                [self handleContactsArray:contactsArray ];
                [contactsArray removeAllObjects];
            }
        
          }
        if([contactsArray count] > 0)
        {
            [self handleContactsArray:contactsArray ];
            [contactsArray removeAllObjects];
        }
        
    }
}

- (void) handleContactsArray:(NSMutableArray *)contactsArray{
    NSDictionary *dict = @{@"contacts" : contactsArray};
    NSString *result = [self serializeObjectDictionary:dict];
    NSLog(@"JSON:\n%@", result);
}

- (NSString *)serializeObjectDictionary:(NSDictionary *)dict {
    NSError *error = nil;
    NSData *json;
    NSString *jsonString = nil;
    // Dictionary convertable to JSON ?
    if ([NSJSONSerialization isValidJSONObject:dict])
    {
        // Serialize the dictionary
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        
        // If no errors, let's view the JSON
        if (json != nil && error == nil)
        {
            jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
        }
        else{
            jsonString = @"{\"error\": \"invalid object\"}";
        }
    }
    return jsonString;
}


@end
