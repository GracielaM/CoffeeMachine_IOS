//
//  CoffeeMachineState.m
//  CoffeeX
//
//  Created by System Administrator on 8/13/13.
//  Copyright (c) 2013 System Administrator. All rights reserved.
//

#import "CoffeeMachineState.h"
#import "DrinksContainer.h"
#import "Drink.h"
#import "FileWriter.h"

@implementation CoffeeMachineState
@synthesize currentDrinksAmount;
@synthesize initialDrinksAmount;
@synthesize coins=_coins;

-(id)init:(MoneyAmount*) newCoins : (DrinksContainer*) newDrinks
{
    self = [super init];
    if (self) {
        _coins=newCoins;
        currentDrinksAmount=newDrinks;
        initialDrinksAmount=[[DrinksContainer alloc]init ];
        NSMutableArray* currentDrinks=[[NSMutableArray alloc]initWithArray:[currentDrinksAmount getDrinks]];
        for(int i=0;i<[currentDrinks count];i++){
           // [initialDrinksAmount addDrink:<#(Drink *)#> quantity:<#(NSUInteger)#>:[currentDrinks objectAtIndex:i]];
        }
        [initialDrinksAmount commit];
        
    }
    return self;
}

-(DrinksContainer*)getCurrentDrinks
{
    return currentDrinksAmount;
}
-(DrinksContainer*)getInitialDrinks
{
    return initialDrinksAmount;
}

-(NSMutableDictionary*)getFiltratedDrinks
{
    NSMutableDictionary* currentDrinks=[[NSMutableDictionary alloc]initWithDictionary:currentDrinksAmount.drinks];
       
    for (Drink *storedDrink in [currentDrinks allKeys]) {
        if ([currentDrinks[storedDrink]integerValue] == 0) {
            [currentDrinks removeObjectForKey:storedDrink];
               }
    }

    
    
    return currentDrinks;
}

-(NSMutableArray*)getStateInArray
{
    NSMutableArray* stateArray=[[NSMutableArray alloc]initWithArray:[self.currentDrinksAmount getArrayFromDictsOfDrinksAndAmounts]];
    [stateArray addObject:[self.coins coinsValueAndAmount]];
    return stateArray;
    
}
-(void)saveStateToFile //may be better in FileWriter.m
{
    FileWriter* fileWriter = [[FileWriter alloc]init];
    fileWriter.fileName = @"writedFile.plist";
    [fileWriter saveToPlist:[self getStateInArray]];
    
}


@end
