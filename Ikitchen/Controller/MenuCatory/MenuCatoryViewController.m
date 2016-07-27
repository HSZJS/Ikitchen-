//
//  MenuCatoryViewController.m
//  Ikitchen
//
//  Created by qianfeng on 15/11/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MenuCatoryViewController.h"
#import "define.h"
@interface MenuCatoryViewController ()<UIWebViewDelegate>
{
    UIWebView * _webView;
  
}
@end

@implementation MenuCatoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    [self createNavigation];
    [self createMenuCatory];
}
-(void)createNavigation
{
    self.title = @"MenuCatory";
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    //设置导航条不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航条标题
    self.navigationItem.title = @"Hot";
    

}
-(void)createMenuCatory
{
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, -55, 375, 653)];
    [self.view addSubview:_webView];
    _webView.delegate = self;
    

    //请求数据
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:MenuCatoryUrl]];
    //加载数据
    [_webView loadRequest:request];
    [self customToolBar];
    
}
-(void)customToolBar
{
    [self.navigationController setToolbarHidden:NO];
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithTitle:@"后退" style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc]initWithTitle:@"前进" style:UIBarButtonItemStyleDone target:self action:@selector(goForward)];
    UIBarButtonItem * flexibleItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    self.toolbarItems = @[item1,flexibleItem,item2];

}
-(void)goBack
{
    BOOL isCanBack = [_webView canGoBack];
    if (isCanBack) {
        [_webView goBack];
        
    }
    else
    {
        NSLog(@"不能返回用户浏览的上一级页面");
    }
    [_webView goBack];
}
-(void)goForward
{
    BOOL isCanForward = [_webView canGoForward];
    if (isCanForward) {
        [_webView goForward];
    }
    else
    {
        NSLog(@"不能前进到用户浏览界面,相对于当前页面来说");
    }
    [_webView goForward];

}
#pragma mark - UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载");
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"结束加载");
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载失败,例如网络错误");
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
