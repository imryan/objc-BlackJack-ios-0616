//
//  FISBlackjackPlayer.m
//  BlackJack
//
//  Created by Ryan Cohen on 6/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackPlayer.h"

@implementation FISBlackjackPlayer

- (instancetype)init {
    return [self initWithName:@""];
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    
    if (self) {
        _name = name;
        _cardsInHand = [NSMutableArray new];
        
        _handscore = 0;
        _wins = 0;
        _losses = 0;
        
        _aceInHand = NO;
        _blackjack = NO;
        _busted = NO;
        _stayed = NO;
    }
    
    return self;
}

- (void)resetForNewGame {
    self.cardsInHand = [NSMutableArray new];
    self.handscore = 0;
    self.aceInHand = NO;
    self.stayed = NO;
    self.blackjack = NO;
    self.busted = NO;
}

- (void)acceptCard:(FISCard *)card {
    self.handscore = 0;
    [self.cardsInHand addObject:card];
    
    for (FISCard *aCard in self.cardsInHand) {
        self.handscore += aCard.cardValue;
        
        if (aCard.cardValue == 1) {
            self.aceInHand = YES;
        }
    }
    
    if (self.aceInHand) {
        for (FISCard *aCard in self.cardsInHand) {
            if (aCard.cardValue == 10) {
                self.blackjack = YES;
            }
        }
        
        if (self.handscore <= 11) {
            self.handscore += 10;
        }
    }
    
    if (self.handscore > 21) {
        self.busted = YES;
    }
}

- (BOOL)shouldHit {
    if (self.handscore > 16) {
        self.stayed = YES;
        
        return NO;
    }
    
    return YES;
}

- (NSString *)description {
    NSString *playerDescription = [NSString stringWithFormat:@"Name: %@\nCards: %@\nHandscore: %lu\nAce in hand: %d\nStayed: %d\nBlackjack: %d\nBusted: %d\nWins: %lu\nLosses: %lu", self.name, self.cardsInHand, self.handscore, self.aceInHand, self.stayed, self.blackjack, self.busted, self.wins, self.losses];
    
    return playerDescription;
}

@end
