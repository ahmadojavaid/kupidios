//
//  ProfileDetails.m
//  CupidLove
//
//  Created by APPLE on 19/12/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "ProfileDetails.h"
#import "UIImageView+WebCache.h"

@implementation ProfileDetails {
    
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)loadCards:(UIView*) parentVC : (NSInteger) index :(UIView*) mutualFriend :(UIView*) bgMutualFriend
{

    int i = 0;
    NSInteger temp=appDelegate.cardsLoadedIndex;
    NSInteger temp2=appDelegate.indexAllcards;
    if([appDelegate.allUsersDetails count] > 0) {
        NSInteger numLoadedCardsCap = [appDelegate.allUsersDetails count];
        for ( i = 0; (i+temp2) < [appDelegate.allUsersDetails count] && i<5; i++) {
            ProfileView *newCard = [self createDraggableViewWithDataAtIndex:(i+temp2):parentVC:mutualFriend:bgMutualFriend];
            [appDelegate.allCards addObject:newCard];
            
            if (i<numLoadedCardsCap) {
                // adds a small number of cards to be loaded
               [appDelegate.loadedCards addObject:newCard];
            }
        }
        
        // displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
        // are showing at once and clogging a ton of data
        
        for ( i = 0;( i+temp2) <[appDelegate.allUsersDetails count] && i<5; i++) {
            if ((i+temp)>0) {
               [parentVC insertSubview:[appDelegate.loadedCards objectAtIndex:(i+temp)] belowSubview:[appDelegate.loadedCards objectAtIndex:(i-1+temp)
]];
            } else {
                [parentVC addSubview:[appDelegate.loadedCards objectAtIndex:i+temp]];
            }
           appDelegate.cardsLoadedIndex++; // we loaded a card into loaded cards, so we have to increment
            appDelegate.indexAllcards++;
        }
    }
}


-(ProfileView *)createDraggableViewWithDataAtIndex:(NSInteger)index :(UIView *) parentVC :(UIView*) mutualFriend :(UIView*) bgMutualFriend
{
    ProfileView *profileView = [[ProfileView alloc]initWithFrame:CGRectMake(0, 0, parentVC.frame.size.width, parentVC.frame.size.height)];
 
    profileView.images=[[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"gallary"];
    [profileView updateScrl];
 
    profileView.name.text=[NSString stringWithFormat:@"%@ %@",
                           [[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"FName"], [[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"LName"] ];
    profileView.distance.text=[NSString stringWithFormat:@"%0.2f Miles away from you",[[[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"distance"] floatValue]];
    profileView.education.text=[NSString stringWithFormat:@"%@",[[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"Education"] ];
    profileView.profession.text=[NSString stringWithFormat:@"%@",[[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"Profession"] ];
    profileView.popup=mutualFriend;
    profileView.popup=bgMutualFriend;
    profileView.parent=parentVC;
    
    profileView.friendID=[NSString stringWithFormat:@"%@",[[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"id"] ];
    
    index++;
    return profileView;
}



@end
