//
//  FISBlackjackGame.m
//  BlackJack
//
//  Created by Ryan Cohen on 6/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackGame.h"

@implementation FISBlackjackGame

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _deck = [FISCardDeck new];
        _house = [[FISBlackjackPlayer alloc] initWithName:@"House"];
        _player = [[FISBlackjackPlayer alloc] initWithName:@"Player"];
    }
    
    return self;
}

- (void)playBlackjack {
    [self.deck resetDeck];
    [self dealNewRound];
    
    for (NSUInteger i = 1; i <= 3; i++) {
        [self processPlayerTurn];
        [self processHouseTurn];
        
        if (self.player.busted || self.house.busted) {
            break;
        }
    }
    
    [self incrementWinsAndLossesForHouseWins:[self houseWins]];
    
    NSLog(@"%@\n\n%@", self.player.description, self.house.description);
}

- (void)dealNewRound {
    [self dealCardToPlayer];
    [self dealCardToHouse];
    
    [self dealCardToPlayer];
    [self dealCardToHouse];
}

- (void)dealCardToPlayer {
    FISCard *card = [self.deck drawNextCard];
    [self.player acceptCard:card];
}

- (void)dealCardToHouse {
    FISCard *card = [self.deck drawNextCard];
    [self.house acceptCard:card];
}

- (void)processPlayerTurn {
    if ([self.player shouldHit] && !self.player.busted && !self.player.stayed) {
        [self dealCardToPlayer];
    }
    
    return;
}

- (void)processHouseTurn {
    if ([self.house shouldHit] && !self.house.busted && !self.house.stayed) {
        [self dealCardToHouse];
    }
    
    return;
}

- (void)incrementWinsAndLossesForHouseWins:(BOOL)houseWins {
    if (houseWins) {
        self.house.wins++;
        self.player.losses++;
    } else {
        self.player.wins++;
        self.house.losses++;
    }
}

- (BOOL)houseWins {
    if (self.player.busted) {
        return YES;
        
    } else if (self.house.busted) {
        return NO;
    }
    
    if (self.player.blackjack && self.house.blackjack) {
        return NO;
    }
    
    if (self.house.handscore >= self.player.handscore) {
        return YES;
    }
    
    return NO;
}

@end
