//
//  WLSessionViewController.m
//  WLChat
//
//  Created by WangLei on 2018/8/31.
//  Copyright © 2018年 WangLei. All rights reserved.
//

#import "WLSessionViewController.h"
#import "WLSessionTableViewCell.h"

@interface WLSessionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *sessions;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign, getter=isRefreshSession) BOOL refreshSession;

@end

@implementation WLSessionViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"会话";
        self.refreshSession = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadSession];
    [self setRightItem];
    
    [WLChatNotificationManager observerSessionNotification:self sel:@selector(receiveSessionNotification)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isRefreshSession) {
        self.refreshSession = NO;
        [self loadSession];
    }
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
}

- (void)loadSession {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.sessions = [[WLChatDBManager DBManager] sessions];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

//收到刷新session的通知
- (void)receiveSessionNotification {
    self.refreshSession = YES;
}

#pragma mark - 模拟消息免打扰、显示未读未读消息数等
- (void)setRightItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"更改样式" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)rightItemClick {
    static NSInteger type = 1;
    if (type == 4) {
        type = 0;
    }
    for (WLChatSessionModel *session in self.sessions) {
        if (type == 0) {
            session.unreadNum = @"0";
            session.silence = NO;
        }
        else if (type == 1) {
            session.unreadNum = @"18";
            session.silence = NO;
        }
        else if (type == 2) {
            session.unreadNum = @"18";
            session.silence = YES;
        }
        else if (type == 3) {
            session.unreadNum = @"100";
            session.silence = NO;
        }
    }
    [self.tableView reloadData];
    type ++;
}
#pragma mark -

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.sessions.count) {
        WLChatSessionModel *session = [self.sessions objectAtIndex:indexPath.row];
        
        WLChatViewController *chatVC = [[WLChatViewController alloc] initWithSession:session];
        chatVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatVC animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sessions.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WLSessionTableViewCell *cell = (WLSessionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[WLSessionTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    if (indexPath.row < self.sessions.count) {
        WLChatSessionModel *session = [self.sessions objectAtIndex:indexPath.row];
        [cell setConfig:session];
    }
    return cell;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.sessions.count) {
        WLChatSessionModel *session = [self.sessions objectAtIndex:indexPath.row];
        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [self.sessions removeObject:session];
            [self.tableView reloadData];
            [[WLChatDBManager DBManager] deleteSessionModel:session.sid];
            //删除聊天记录
            if (session.isSilence) {
                [[WLChatDBManager DBManager] deleteMessageWithGid:session.sid];
            }
            else {
                [[WLChatDBManager DBManager] deleteMessageWithUid:session.sid];
            }
        }];
        deleteAction.backgroundColor = [UIColor redColor];
        return @[deleteAction];
    }
    return nil;
}

#pragma mark - getter
- (UITableView *)tableView {
    if (_tableView == nil) {
        CGRect rect = self.view.bounds;
        rect.origin.y = CHAT_NAV_BAR_H;
        rect.size.height -= (CHAT_NAV_BAR_H+CHAT_TAB_BAR_H);
        
        _tableView = [[UITableView alloc] initWithFrame:rect];
        _tableView.delegate = self;
        _tableView.dataSource = self;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
#else
        self.automaticallyAdjustsScrollViewInsets = NO;
#endif
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (void)dealloc {
    [WLChatNotificationManager removeObserver:self];
}

@end
