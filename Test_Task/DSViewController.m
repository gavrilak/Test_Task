//
//  DSViewController.m
//  TestTAsk
//
//  Created by Dima on 11/2/14.
//  Copyright (c) 2014 Dima Soldatenko. All rights reserved.
//

#import "DSViewController.h"


@interface DSViewController () {
    
    NSMutableArray* colorsDSCells;
}

@end

@implementation DSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = inset;
    self.tableView.scrollIndicatorInsets = inset;
    self.tableView.separatorColor = [UIColor clearColor];
    
    colorsDSCells = [[NSMutableArray alloc]init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"colors" ofType:@"xml"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSXMLParser *xmlParser = [[NSXMLParser alloc]initWithData:data];
    xmlParser.delegate = self;
    [xmlParser parse];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSXMLParserDelegate

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    CGFloat red, green, blue, alpha;
    unsigned  hex;
    if ([elementName isEqualToString:@"color"] ){
        DSCell *currentDSCell = [[DSCell alloc]init];
        currentDSCell.name = [attributeDict objectForKey:@"name"];
        NSString *noHashString =[[attributeDict objectForKey:@"color"]stringByReplacingOccurrencesOfString:@"#" withString:@""];
        NSScanner *scanner = [NSScanner scannerWithString:noHashString];
        if([scanner scanHexInt:&hex]){
            alpha = (hex>>24) & 0xFF;
            red = (hex>>16) & 0xFF;
            green = (hex>>8) & 0xFF;
            blue = (hex) & 0xFF;
            currentDSCell.color = [UIColor colorWithRed:red /255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f];
            [colorsDSCells addObject:currentDSCell];
        }
        
    }
    
}

#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [colorsDSCells count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CALayer *layer = [[CALayer alloc]init];
        [cell setBackgroundView:[[UIView alloc] init]];
        [cell.backgroundView.layer insertSublayer:layer atIndex:0];
        cell.backgroundView.layer.cornerRadius = 10;
    }
    
    DSCell *curentDSCell = (DSCell*)[colorsDSCells objectAtIndex:[indexPath section]];
    cell = [curentDSCell setColorsforCell:cell];
    cell.textLabel.text = curentDSCell.name;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DSCell *curentDSCell = (DSCell*)[colorsDSCells objectAtIndex:[indexPath section]];
    
    if(curentDSCell.isSelected){
        return 160;
    }
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    DSCell *curentDSCell = (DSCell*)[colorsDSCells objectAtIndex:[indexPath section]];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    curentDSCell.isSelected = !curentDSCell.isSelected;
    cell = [curentDSCell setColorsforCell:cell];
    
    [tableView beginUpdates];   
    [tableView endUpdates];
    
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    view.tintColor= [UIColor clearColor];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;

}


@end



