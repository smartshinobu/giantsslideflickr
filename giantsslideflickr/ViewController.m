//
//  ViewController.m
//  giantsslideflickr
//
//  Created by 田中忍 on 2015/01/11.
//  Copyright (c) 2015年 tanakashichan. All rights reserved.
//

#import "ViewController.h"
#import "Webreturn.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSDictionary *dic;
    NSString *urlstr;
    NSString *tag;
    NSArray *array;
    NSString *imgurl;
    NSTimer *timer;
    int cnt;
}

- (void)viewDidLoad {
    self.label.hidden = YES;
    tag = @"阿部慎之助";
    NSString *entag = [tag stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    urlstr = @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=f7b9764be72c7fc3effb412aaf949e63&tags=(tag)&format=json&nojsoncallback=1";
    NSString *url = [urlstr stringByReplacingOccurrencesOfString:@"(tag)" withString:entag];
    dic = [Webreturn JSONDictinaryData:url];
    NSLog(@"%@",dic);
    NSDictionary *photodic = [dic objectForKey:@"photos"];
    NSLog(@"%@",photodic);
    array = [photodic objectForKey:@"photo"];
    cnt = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(slide) userInfo:nil repeats:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)slide{
    NSDictionary *imgdic = [array objectAtIndex:cnt];
    //NSLog(@"%@",imgdic);
    imgurl = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@.jpg",[imgdic objectForKey:@"farm"],[imgdic objectForKey:@"server"],[imgdic objectForKey:@"id"],[imgdic objectForKey:@"secret"]];
    self.imageview.image = [Webreturn WebImage:imgurl];
    self.label.text = [imgdic objectForKey:@"title"];
    self.label.hidden = NO;
    if (cnt < [array count]-1) {
        cnt++;
    }else{
        cnt = 0;
    }
}

@end
