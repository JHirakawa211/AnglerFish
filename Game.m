//
//  Game.m
//  AnglerFish
//
//  Created by John Hirakawa on 6/23/15.
//  Copyright (c) 2015 John Hirakawa. All rights reserved.
//

#import "Game.h"

@interface Game ()

@end

@implementation Game

-(void)Score{
    
    ScoreNumber = ScoreNumber + 1;
    ScoreLabel.text = [NSString stringWithFormat:@"%i",ScoreNumber];
    
}

-(IBAction)StartGame:(id)sender{
    
    TunnelTop.hidden = NO;
    TunnelBottom.hidden = NO;
    
    StartGame.hidden = YES;
    
    FishMovement = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(FishMoving) userInfo:nil repeats:YES];
    
    [self PlaceTunnels]; //run method PlaceTunnels;
    
    TunnelMovement = [NSTimer scheduledTimerWithTimeInterval:0.009 target:self selector:@selector(TunnelMoving) userInfo:nil repeats:YES];
    
}

-(void)PlaceTunnels{
    
    RandomTopTunnelPosition = arc4random() %350;
    RandomTopTunnelPosition = RandomTopTunnelPosition -228;
    RandomBottomTunnelPosition = RandomTopTunnelPosition + 663;
    
    TunnelTop.center = CGPointMake(420, RandomTopTunnelPosition);
    TunnelBottom.center = CGPointMake(420, RandomBottomTunnelPosition);
    
    
    
}

-(void)TunnelMoving{
    
    TunnelTop.center = CGPointMake(TunnelTop.center.x-1, TunnelTop.center.y);
    TunnelBottom.center = CGPointMake(TunnelBottom.center.x-1, TunnelBottom.center.y);
   
    
    if(TunnelTop.center.x < -28){
        [self PlaceTunnels];
    }
    
    if(TunnelTop.center.x == -28){
        [self Score];
        
    }
    
    if(CGRectIntersectsRect(Fish.frame, TunnelTop.frame)){
        [self GameOver];
    }
    if(CGRectIntersectsRect(Fish.frame, TunnelBottom.frame)){
        [self GameOver];
    }
    if(CGRectIntersectsRect(Fish.frame, Top.frame)){
        [self GameOver];
    }
    if(CGRectIntersectsRect(Fish.frame, Bottom.frame)){
        [self GameOver];
    }
    
}

-(void)GameOver{
    
    Black.hidden = YES;
    if(ScoreNumber > HighScoreNumber){
        
        [[NSUserDefaults standardUserDefaults]setInteger:ScoreNumber forKey:@"HighScoreSaved"];
        
    }
    
    [TunnelMovement invalidate];
    [FishMovement invalidate];
    
    if(ScoreNumber < 4){
    Comment.text = [NSString stringWithFormat:@"You Could Do Better! Only %i",ScoreNumber];
    }
    if(ScoreNumber >= 4 && ScoreNumber < 10){
        Comment.text = [NSString stringWithFormat:@"Good Job! %i is amazing!",ScoreNumber];
    }
    if(ScoreNumber >= 10){
        Comment.text = [NSString stringWithFormat:@"You Basically Beat The Game With %i!",ScoreNumber];
    }
    Exit.hidden = NO;
    Comment.hidden = NO;
    TunnelTop.hidden = YES;
    TunnelBottom.hidden = YES;
    Fish.hidden = YES;
    
}



-(void)FishMoving{
    
    Fish.center = CGPointMake(Fish.center.x, Fish.center.y - FishFlight);
    
    FishFlight = FishFlight -5;
    
    if(FishFlight < -15){
        FishFlight = -15;
    }
    
    if(FishFlight > 0) {
        Fish.image = [UIImage imageNamed:@"anglerfish"];
        Black.hidden = YES;
    }
    if(FishFlight < 0) {
        Fish.image = [UIImage imageNamed:@"anglerfishdown"];
        Black.hidden = NO;
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    FishFlight = 30;
}




- (void)viewDidLoad {
    
    TunnelTop.hidden = YES;
    TunnelBottom.hidden = YES;
    Black.hidden = YES;
    Exit.hidden = YES;
    Comment.hidden = YES;
    ScoreNumber = 0;
    
    HighScoreNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"HighScoreSaved"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
