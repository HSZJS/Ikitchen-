//
//  BillboardViewController.m
//  Ikitchen
//
//  Created by qianfeng on 15/11/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BillboardViewController.h"
#import "define.h"
#import "MBProgressHUD+MJ.h"
@interface BillboardViewController ()<UIWebViewDelegate>
{
    UIWebView * _webView;

}
@end

@implementation BillboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    [self createNavigation];
    [self createWebView];
}
//创建导航条
-(void)createNavigation
{
    self.title = @"BillboardViewController";
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    //设置导航条不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航条标题
    self.navigationItem.title = @"Hot";
    

    
}
//创建网页视图
-(void)createWebView
{

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, -54, 375, 654)];
    //设置代理
    _webView.delegate = self;
    [self.view addSubview:_webView];
    //创建请求对象
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:BillBoardUrl]];
    //加载请求
    [_webView loadRequest:request];
    [self customToolBar];


}
//创建toolBar
-(void)customToolBar
{
    [self.navigationController setToolbarHidden:NO];
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithTitle:@"后退" style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    UIBarButtonItem  * item2 = [[UIBarButtonItem alloc]initWithTitle:@"前进" style:UIBarButtonItemStyleDone target:self action:@selector(goFoward)];
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
-(void)goFoward
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
    //[MBProgressHUD showMessage:@"正在加载中..."];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"结束加载");
    //[MBProgressHUD hideHUD];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载失败,例如网络错误");
      //[MBProgressHUD hideHUD];
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
