//
//  ViewController.m
//  Contacts
//
//  Created by Yuriy on 06.06.2020.
//  Copyright © 2020 Yuriy Chizh. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Data.h"
#import "ContactCell.h"
#import "Section.h"
#import "ContactEditController.h"


@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *sections;
@property (strong, nonatomic) NSMutableArray *persons;
@property (weak, nonatomic) IBOutlet UISearchBar *personSearchBar;

@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.persons = @[].mutableCopy;
    
    for (NSInteger index = 0; index < 50; index++) {
        
        Data *data = [Data new];
        Person *person = [Person new];
        
        person.name = [data randomName];
        person.surname = [data randomSurname];
        person.email = [data email];
        person.photo = [data photo];
        
        [self.persons addObject:person];
    }
    [self generateSectionsFromPersons:self.persons withFilter:self.personSearchBar.text];
}

#pragma mark - Additional methods

- (void)generateSectionsFromPersons:(NSArray *)persons withFilter:(NSString *)filter {
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [self.persons sortUsingDescriptors:@[sortDescriptor]];
    
    NSMutableArray *sections = [NSMutableArray array];
    
    Section *section = nil;
    NSString *prev = nil;
    NSString *current = nil;
    
    for (Person *person in persons) {

        if (filter.length > 0 && [person.name rangeOfString:filter].location == NSNotFound &&
                                 [person.surname rangeOfString:filter].location == NSNotFound) {
            continue;
        }
        
        current = [person.name substringToIndex:1];
        
        if ([current isEqualToString:prev]) {
            [section.persons addObject:person];
        }
        else {
            section = [Section new];
            section.name = current;
            section.persons = [NSMutableArray arrayWithObject:person];
            [sections addObject:section];
            prev = current;
        }
    }
    
    self.sections = sections;
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sections.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [self.sections[section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Section *tempSection = self.sections[section];
    return tempSection.persons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *const ContactCellIdentifier = @"ContactCell";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ContactCellIdentifier];
    
    Section *section = self.sections[indexPath.section];
    Person *person = section.persons[indexPath.row];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", person.name, person.surname];
    cell.photoImageView.image = person.photo;
    cell.photoImageView.layer.cornerRadius = cell.photoImageView.frame.size.width / 2.0f;
    
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    NSMutableArray *sectionNames = [NSMutableArray array];
                     
    for (Section *section in self.sections) {
        [sectionNames addObject:section.name];
    }
    
    return sectionNames;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"ContactEdit" sender:indexPath];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    [self generateSectionsFromPersons:self.persons withFilter:self.personSearchBar.text];
    
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ContactEdit"]) {
        
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        Section *section = self.sections[indexPath.section];
        Person *person = section.persons[indexPath.row];
        
        ContactEditController *vc = segue.destinationViewController;
        vc.delegate = self;
        vc.person = person;
        vc.indexPath = indexPath;
    }
}

#pragma mark - ContactEditController

- (void)didChangeContact:(Person *)person withIndexPath:(nonnull NSIndexPath *)indexPath {
    
    Section *section = self.sections[indexPath.section];
    Person *prevPerson = section.persons[indexPath.row];
    NSInteger index = [self.persons indexOfObject:prevPerson];
    
    [self.persons removeObjectAtIndex:index];
    [self.persons addObject:person];
    [self generateSectionsFromPersons:self.persons withFilter:nil];
}

- (void)didDeleteContact:(Person *)person {
    
    [self.persons removeObject:person];
    [self generateSectionsFromPersons:self.persons withFilter:nil];
}

@end
