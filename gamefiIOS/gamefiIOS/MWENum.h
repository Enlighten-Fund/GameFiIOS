//
//  MWENum.h
//  NoWait
//
//  Created by smile.zhang on 15/10/13.
//  Copyright © 2015年 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HttpResponseCode) {
    
    /* 操作成功 */
    HttpResponseCodeSuccess                   = 0,  /* 响应成功 */
    
    /* 业务错误码 :自定义*/
    HttpResponseCodeStatusError               = 3,  /* 预订解锁失败:该订单已支付不能删除*/
    HttpResponseCodeSessionTimeOut            = 12, /* token过期 */
    HttpResponseCodeTransactionFailed         = 18, /* 处理失败 */
    HttpResponseCodeMobilePhoneBinded         = 22, /* 手机号码已经绑定 */
    HttpResponseCodeAPIExpire                 = 30, /* 接口过期或者业务不可用 */
    HttpResponseCodeNoData                    = 35, /* 没有数据 */
    
    //取号业务
    HttpResponseCodeQueueFailed               = 95, /* 取号失败 */

    /* 支付业务*/
    HttpResponseCodePriceChange               = 10042, /* 价格变动 */

    /* 网络连接 */
    HttpResponseCodeUnkonwError               = 90000, /* 未知错误码 */
    HttpResponseCodeErrorFailedConnect        = NSURLErrorNotConnectedToInternet,//网络无法连接-1009
};

typedef NS_OPTIONS(NSUInteger, MWShopService) {
    MWShopServiceNone               = 1,    /* 无任何服务 */
    MWShopServiceQueue              = 1 << 1,    /* 排队 */
    MWShopServiceMenu               = 1 << 2,    /* 点菜 */
    MWShopServiceFood               = 1 << 3,    /* 厨房菜单 */
    MWShopServiceWaiter             = 1 << 4,    /* 侍者 */
    MWShopServiceTakeout            = 1 << 5,    /* 外卖 */
    MWShopServiceYuDing             = 1 << 6,    /* 预订 */
    MWShopServiceHidden             = 1 << 7,    /* 埋藏 */
    MWShopServicePay                = 1 << 8,    /* 支付 */
    MWShopServiceScanPrint          = 1 << 9,    /* 扫描打印 */
    MWShopServiceYuDian             = 1 << 10,    /* 预点打单 */
    MWShopServiceLookMenu           = 1 << 11,   /* 菜单查看 */
    MWShopServiceCoupon             = 1 << 12,   /* 卡券 */
    MWShopServicePos                = 1 << 13,   /* pos收款 */
    MWShopServiceDanMu              = 1 << 14,   /* 弹幕 */
    MWShopServiceYuYue              = 1 << 15,   /* 预约 */
    MWShopServiceKuaiCan            = 1 << 16,   /* 快餐 */
    MWShopServiceAppCoupon          = 1 << 18,   /* APP卡券服务 */
    MWShopServiceJieZhang           = 1 << 19,   /* APP优惠结账 */
};

typedef NS_ENUM(NSInteger, NWShopState) {
    NWQueueStateNormalQueue         = 0,    /* 正常排队 */
    NWQueueStateNoBusiness          = 1,    /* 未营业，未到取号时间 */
    NWQueueStateNoQueue             = 2,    /* 联网但无需排队:有桌型 */
    NWQueueStateSceneQueue          = 3,    /* 需现场取号 :B端联网但关闭远程取号*/
    NWQueueStateSceneQueue2         = 4,    /* 需现场取号 :B端联网但云端后台关闭远程取号功能*/
    NWQueueStateShopSysException1   = 5,    /* 未联网根据历史数据预估无需排队:无桌型 */
    NWQueueStateShopSysException2   = 6,    /* 商家排队系统异常，不用排队 */
    NWQueueStateShopDeviceException = 7,    /* 平板状态异常,返回不用排队 */
    NWQueueStateSceneQueue3         = 8,    /* 需现场取号 :B端刚由单机切换到联网但未开启远程取号功能 */
    NWQueueStateNoInternet          = 9     /* 未联网 */
};

typedef NS_ENUM(NSInteger, NWQueueState) {
    NWQueueStateObtailingQueue1      = 0,   /* 排队委托中 */
    NWQueueStateObtailingQueue2      = 1,   /* 取号中 */
    NWQueueStateObtailedQueueSuccess = 2,   /* 取到成功,排队中 */
    NWQueueStateNotificatedQueue     = 3,   /* 就绪(被通知过) */
    NWQueueStateCalledQueue          = 4,   /* 被叫号 */
    NWQueueStateRepastedQueue        = 5,   /* 就餐 --*/
    NWQueueStatePassedQueue          = 6,   /* 过号 --*/
    PassedQueueObtailedQueuFailed2   = 7,   /* 取号失败 --*/
    PassedQueueObtailedQueuFailed1   = 8,   /* 委托失败 --*/
    NWQueueStateCancelingQueue       = 9,   /* 取消中 */
    NWQueueStateCanceledQueue        = 10,  /* 已取消 --*/
    NWQueueStateCancelQueueFailed    = 11,  /* 取消失败 -- */
    NWQueueStateQueuePayFailed       = 12   /* 支付失败 -- */
};

//号单定金状态
typedef NS_ENUM(NSInteger, NWQueuePayDJ) {
    NWQueuePayDJNO        = 0, // 已买单
    NWQueuePayDJYES       = 1, // 未买单
};

//号单定金状态
typedef NS_ENUM(NSInteger, NWQueuePayStatus) {
    NWQueuePayDJPayNO        = 0, // 未支付
    NWQueuePayDJPayYES       = 1, // 已支付
    NWQueuePayDJRefund       = 2, // 已退款
    NWQueuePayDJUsed         = 3, // 已消费
    NWQueuePayDJFailed       = 4, // 作为违约金扣除
};

//商户详情取号支持的付费类型
typedef NS_ENUM(NSInteger, QueueServiceType) {
    QueueServiceTypeFree        = 0, // 免费取号
    QueueServiceTypeFee         = 1, // 服务费取号
    QueueServiceTypeDJ          = 2, // 定金取号
};

//号单付费号单标识
typedef NS_ENUM(NSInteger, NWQueueType) {
    NWQueueFree        = 0, // 免费取号
    NWQueueBuy         = 1, // 购买号单
    NWQueueServiceFee  = 2, // 手机付费取号
    NWQueueDJ          = 3, // 定金号单
    NWQueueDJAndBuy    = 4, // 定金再购买号单
};


// 消息已读未读
typedef NS_ENUM(NSInteger, NWMsgReadState) {
    NWMsgReadStateUnread     = 1, // 未读消息
    NWMsgReadStateReaded     = 2  // 已读消息
};

//APNS消息类型定义
typedef NS_ENUM(NSInteger, ApnMsgType){
    ApnMsgTypeNormal                    = 0,       // 普通文本消息推送
    ApnMsgTypeSystem                    = 1,       /* 系统消息 */
    ApnMsgTypeCoupon                    = 2,       /* 优惠券信息，等位优惠 */
    ApnMsgTypeOperation                 = 3,       /* 运营推广消息,美文推送 */
    ApnMsgTypeQueue                     = 4,       /* 排队提醒 */
    ApnMsgTypeRemindMe                  = 5,       /* 放号提醒消息 */
    ApnMsgTypeSuccess                   = 6,       /* 取号单,成功出号推送，便于区分是否显示 */
    ApnMsgTypeSwap                      = 7,       /* 取号单,交换提醒推送（抢号提醒放一起） */
    ApnMsgTypeActivity                  = 8,       /* 活动推送 */
    ApnMsgTypeComment                   = 9,       /* 点评回复 */
    ApnMsgTypePay                       = 10,      /* 支付结果 */
    ApnMsgTypeShopOperation             = 11,      /* 商户营销推广消息 */
    ApnMsgTypeYuDing                    = 12,      /* 预订 */
    ApnMsgTypeDeal                      = 13,      /* 闪惠或买单 */
    ApnMsgTypeMeiweiActivity            = 14       /* 美味活动 */
};

typedef NS_ENUM(NSInteger, ApnMsgTypeQueueSubType) {
    ApnMsgTypeQueueSubTypeSuccess               = 0, // 取号成功
    ApnMsgTypeQueueSubTypePass                  = 1, // 过号
    ApnMsgTypeQueueSubTypeCanBuy                = 4, // 购买号单
    ApnMsgTypeQueueSubTypeBuyStatus             = 5, // 号单购买状态通知
    ApnMsgTypeQueueSubTypeYuYueDaoDian          = 6, // 预约到店消息通知
    ApnMsgTypeQueueSubTypeSuccessRule           = 7, // 取号成功之后过号规则消息通知
    ApnMsgTypeQueueSubTypeQueueRemaind          = 8, // 排队取号放号提醒我
};

typedef NS_ENUM(NSInteger, ApnMsgTypeMWActivitySubType) {
    ApnMsgTypeMWActivitySubTypeSystem               = 0, // 系统消息
    ApnMsgTypeMWActivitySubTypeAD                   = 5, // 广场广告
    ApnMsgTypeMWActivitySubTypeArticle              = 8, // 美文
};

//本地用户消息类型定义
typedef NS_ENUM(NSInteger, LocalMsgType){
    LocalMsgTypeADSystem       = 0, // 广告系统消息
    LocalMsgTypeSystem         = 1, // 系统消息
    LocalMsgTypeCoupon         = 2, // 优惠券信息
    LocalMsgTypeOperation      = 3, // 运营信息
    LocalMsgTypeQueue          = 4, // 排队信息
    LocalMsgTypeRemindMe       = 5, // 放号提醒我
    LocalMsgTypeYuYue          = 6, // 预约提醒
    LocalMsgTypeShopOperation  = 7, // 商家运营消息
    LocalMsgTypeYuDing         = 8, // 预订消息
    LocalMsgTypeDeal           = 9  // 闪惠消息
};

typedef NS_ENUM (NSInteger, NWMsgSubType){
    NWMsgSubTypeSystem        = 0, // 系统消息
    NWMsgSubTypeHomeAD        = 1, // 首页广告
    NWMsgSubTypeArticle       = 2, // 美文
    
    NWMsgSubTypeShopDetail    = 4, // 商家详情
    NWMsgSubTypeFeedBackReply = 5, // 反馈回复
};

typedef NS_ENUM(NSInteger, NWMsgQueueType){
    NWMsgQueueTypeObtainSuccess        = 0, // 取号成功
    NWMsgQueueTypeAppeal               = 1, // 过号 a
    NWMsgQueueTypeDelay                = 3, // 推迟号单, 现已废弃
    NWMsgQueueTypeDeal                 = 4, // 排队购买, 现已废弃
    NWMsgQueueTypeDealPayStatus        = 5, // 排队号单支付状态 a
    NWMsgQueueTypeFastQueue            = 6, // 预约到店
    NWMsgQueueTypePassNumberRule       = 7, // 过号规则
};

typedef NS_ENUM (NSInteger, NWAdActionType){
    NWAdActionTypeNone           = 0,
    NWAdActionTypeShopDetail     = 1, // 查看商家详情
    NWAdActionTypeShopList       = 2, // 查看商家列表
    NWAdActionTypeShareWeb       = 3, // 点击进入带分享按钮的网页内容
    NWAdActionTypeInApp          = 4, // 应用内活动
    NWAdActionTypeAuthShareWeb   = 5, // 点击进入带分享按钮的网页内容,与3唯一的区别是需要登录SessionID才能进入web视图
    NWAdActionTypeQueueList      = 6, // 排队列表
    NWAdActionTypeYuDingList     = 7, // 预订列表
    NWAdActionTypeOnlineYuyue    = 8, // 在线预约页
};

//预约类型
typedef NS_ENUM(NSUInteger, MWYuYueSlotType) {
    MWYuYueSlotTypeMenu, // 点菜
    MWYuYueSlotTypeNoPay, // 无需支付
    MWYuYueSlotTypeNeedPay, // 需要支付
};

// 预约状态
typedef NS_ENUM(NSInteger, NWYuYueState) {
    NWYuYueStateSuccess                     = 0,    // 预约成功
    NWYuYueStateDianCai                     = 1,    // 需要点菜
    NWQueueAppealJiuCan                     = 2,    // 已经就餐
    NWQueueAppealStateQuXiao                = 3,    // 取消
    NWQueueAppealStateShiXiao               = 4,    // 失效
    NWQueueAppealStateDaizhifu              = 5,    // 待支付的状态
    NWQueueAppealStateSyning                = 404,  // 同步中
};


/*
 {
 AD = "测试";
 ID = 1008;
 MsgID = 244335816;
 ShopID = 0;
 T = "2017-01-09 09:52:21";
 detail =     {
 ADID = 4863;
 Action = 0;
 Description = "";
 ShopID = 0;
 Title = "北京火锅排行榜";
 ViewUrl = "http://mwee.cn/article/?id=4863";
 };
 msgType = 2;
 }
 */
// Xmpp信息类型 +代表目前C端使用的业务
typedef NS_ENUM(NSInteger, NWXmppMessageType) {
    NWXmppMessageTypeConfirmOrder           = 200,  //商家确认订单
    NWXmppMessageTypeConfirmOrderCheck      = 202,  //客户确认支付
    NWXmppMessageTypeChangeTable            = 204,  //客户换桌需求
    NWXmppMessageTypeErrorTable             = 206,  //客户桌号填写错误通知
    NWXmppMessageTypeConfirmPrior           = 208,  //预付费商家确认订单，反馈用户
    NWXmppMessageTypeOrderCanceledB         = 210,  //商家取消订单,反馈用户
    NWXmppMessageTypeOrderScanPrintC        = 211,  //用户扫描打印
    NWXmppMessageTypePaySucess              = 2011, //支付成功通知
    NWXmppMessageTypeYuPaySucess            = 2012, //预约支付成功通知
    NWXmppMessageTypeMeiweiActivity         = 5000, //美味活动
    NWXmppMessageTypeDelayQueue             = 3000, //推迟号单（废除）
    
    /* 以上业务未处理或已废弃*/
    NWXmppMessageTypeSystemAD               = 1000, //系统推送广告    ++
    NWXmppMessageTypeSystemDiscount         = 1001, //系统推送优惠    ++
    NWXmppMessageTypeSystemArticle          = 1008, //运营美文推送    ++
    NWXmppMessageTypeQueueToUser            = 2001, //云端向用户推送的排队消息接口    +++
    NWXmppMessageTypeCouponB                = 2008, //商家推送优惠券消息
    NWXmppMessageTypeQueueBegin             = 2010, //云端放号提醒    ++
    NWXmppMessageTypeQueueCanBuy            = 2013, //可购买号单的消息通知    ++
    NWXmppMessageTypeQueueBuyStatus         = 2014, //号单购买状态通知      ++
    NWXmppMessageTypeQueueFastQueue         = 2015, //预约就餐的消息通知    ++
    NWXmppMessageTypeQueueSucessRule        = 2016, //排队号单取号成功之后的过号规则的消息通知    ++
    NWXmppMessageTypeDealMaidan             = 2100, //买单优惠的消息通知     ++
    NWXmppMessageTypeBeKick                 = 65535,//用户登录重复登录  ++
    NWXmppMessageTypeYuDing                 = 40006,//预订        ++

};

typedef NS_ENUM (NSInteger, NWPayType){
    NWPayTypeNone            = 0,
    NWPayTypeWeChat          = 1,
    NWPayTypeAliPay          = 2
};

typedef NS_ENUM(NSUInteger, MWPayService) {
    MWPayServiceNone        = 0, // 支付渠道均不可用
    MWPayServiceWeChatPay   = 1 << 0, // 微信支付可用
    MWPayServiceAliPay      = 1 << 1, // 支付宝可用
};

typedef NS_ENUM(NSUInteger, MWBillPayCouponType) {
    MWBillPayCouponTypeSubtract = 1, // 满减
    MWBillPayCouponTypeDiscount = 2, // 折扣
    MWBillPayCouponTypeCash     = 3, // 代金券
};

typedef NS_ENUM (NSInteger, NWInviteType){
    NWInviteTypeInit             = 0, // 未注册。应显示邀请
    NWInviteTypeInvited          = 1, // 已邀请
    NWInviteTypeSuccess          = 2, // 邀请成功
    NWInviteTyperegistered       = 3  // 已注册
};

typedef NS_ENUM (NSInteger, MWOrderType){
    MWOrderTypeNone         = 0,
    MWOrderTypeQueue        = 1,//排队号单
    MWOrderTypeMenu         = 2,//预点菜单
    MWOrderTypeYuyue        = 3,//预约号单
    MWOrderTypeYuDing       = 4,//预订号单
    MWOrderTypeMWDeal       = 5,//美味买单
    MWOrderTypeQuickQueue   = 6,//快速排队
    
};
//0：点菜，1：预点单  2：预约，3：快捷点菜，4：外卖
typedef NS_ENUM (NSInteger, MWOrderBizType){
    MWOrderBizTypeNone         = 0, //点菜        eg:B端使用
    MWOrderBizTypePreMenu      = 1, //预点单
    MWOrderBizTypeYuyue        = 2, //预约
    MWOrderBizTypeQuickMenu    = 3, //快捷点菜     eg:B端使用
    MWOrderBizTypeWaimai       = 4, //外卖        eg:B端使用
};

// 菜品类型
typedef NS_ENUM(NSInteger, MWMenuItemModelType) {
    MWMenuItemModelTypeTemplate     = 0,  // 菜单模板
    MWMenuItemModelTypePutong       = 1,  // 普通菜
    MWMenuItemModelTypeTemp         = 2,  // 临时菜:B端使用，C端不做处理
    MWMenuItemModelTypeTaocan       = 3,  // 套餐
};
// 菜品类型:每种选择份数的
typedef NS_ENUM(NSInteger, MWMenuModifierChooseRule) {
    MWMenuModifierChooseRuleNone            = 0,  // 没有规则
    MWMenuModifierChooseRuleAny             = 2,  // 任意选几: N选1
    MWMenuModifierChooseRuleNumChange       = 3,  // 配料数量可变:文件夹
    
};

typedef NS_ENUM(NSInteger, MWMenuModifierSetType) {
    MWMenuModifierSetTypeNone     = 0,  // 配料
    MWMenuModifierSetTypeSet      = 1,  // 套餐
};

typedef NS_ENUM(NSInteger, MWMenuModifierType) {
    MWMenuModifierTypeNone     = 0,  // 类型名称:
    MWMenuModifierTypeSub      = 1,  //具体的配料
};

//订单支付状态
typedef NS_ENUM(NSInteger, MWOrderPayStatus) {
    MWOrderPayStatusNone     = 0,   // 未支付
    MWOrderPayStatusPayed    = 1,   // 已支付
    MWOrderPayStatusRefund   = 2,   // 已退款
};

//订单状态
typedef NS_ENUM(NSInteger, MWOrderStatus) {
    MWOrderStatusNew        = 0,   //新单
    MWOrderStatusConfirm    = 1,   //已确认
    MWOrderStatusGoKitchen  = 2,   //已下单到厨房
    MWOrderStatusFinish     = 3,   //已完成
    MWOrderStatusDelete     = -1,  //已删除
    MWOrderStatusCancel     = -2,  //已取消
};
typedef NS_ENUM(NSUInteger, MWMenuPriceType) {
    MWMenuPriceTypeOriginal    = 0,  // 原价
    MWMenuPriceTypeReal        = 1,  // 实价（当前实际的价格，与时价不同）
};

typedef NS_ENUM(NSInteger, MWYDBoxHall){
    MWYDBoxHallNOAccept    = 0,//包房不接受大厅
    MWYDBoxHallAccept      = 1,//包房接受大厅
};

typedef NS_ENUM(NSInteger, MWYDBoxType){
    MWYDBoxTypeHall              = 10,//大厅
    MWYDBoxTypeBaoFangFirst      = 20,//包房优先
    MWYDBoxTypeBaoFangMust       = 30,//必须包房
};


typedef NS_ENUM(NSInteger, MWMarketType){
    MWMarketTypeNoon        = 10,//午市
    MWMarketTypeNight       = 20,//晚市
};

typedef NS_ENUM(NSInteger, MWYDStatus){
    MWYDStatusYiQueRen      = 10,//已确认
    MWYDStatusWeiQueRen     = 20,//未确认
    MWYDStatusYiJiuCan      = 30,//已就餐 --
    MWYDStatusWeiJiuCan     = 40,//未就餐 --
    MWYDStatusYiQuXiao      = 50,//已取消--
    MWYDStatusDelete        = 60,//删除 --
    MWYDStatusLiuZuo        = 70,//留座
    MWYDStatusJiuCanZhong   = 80,//就餐中
    MWYDStatusJuJue         = 90,//拒绝 --
    MWYDStatusPay           = 120,//定金或代金券待支付

};

// 1：未支付(默认状态) 2超时支付失败 3：代金券已支付 4.代金券已扣款 5代金券已使用 6代金券已退款
typedef NS_ENUM(NSInteger, MWYDPayStatus){
    MWYDPayStatusNone       = 1,//1.未支付(默认状态)
    MWYDPayStatusFail       = 2,//2.超时支付失败
    MWYDPayStatusSuccess    = 3,//3.代金券已支付
    MWYDPayStatusDeduction  = 4,//4.代金券已扣款
    MWYDPayStatusUsed       = 5,//5.代金券已使用
    MWYDPayStatusreFunds    = 6,//6.代金券已退款
};

typedef NS_ENUM(NSInteger, MWWeekday){
    MWWeekdaySunday,      // 周日
    MWWeekdayMonday,      // 周一
    MWWeekdayTuesday,     // 周二
    MWWeekdayWednesday,   // 周三
    MWWeekdayThursday,    // 周四
    MWWeekdayFriday,      // 周五
    MWWeekdaySaturday,    // 周六
    MWWeekdayAllWeek,     // 所有
};

typedef NS_ENUM(NSInteger, AccessShopDetailType){
    AccessShopDetailTypeDefault,          // 默认没锚点
//    AccessShopDetailTypeFastQueue,       // 锚点到快速排队券
    AccessShopDetailTypeYD,              // 锚点到预定
};

typedef NS_ENUM(NSInteger, MWShopBusinessType){
    MWShopBusinessTypeNone   = 1 << 0,      // 无服务
    MWShopBusinessTypeQueue  = 1 << 1,     // 排队商家
    MWShopBusinessTypeYuDing = 1 << 2,     // 预订商家
};

typedef NS_ENUM(NSInteger, AccountAuthType) {
    AccountAuthTypePhone        = 1,
    AccountAuthTypeSinaWeibo    = 2,
    AccountAuthTypeQQWeibo      = 3,
    AccountAuthTypeQQ           = 4,
    AccountAuthTypeWeixin       = 5,
};

//当前账号的绑定状态
typedef NS_ENUM(NSInteger, MWAccountStatus) {
    MWAccountStatusNone         = 0,        /* 无效绑定 */
    MWAccountStatusPhone        = 1 << 1,    /* 手机号绑定 */
    MWAccountStatusSinaWeibo    = 1 << 2,    /* 新浪微博绑定 */
    MWAccountStatusTencentWeibo = 1 << 3,    /* 腾讯微博绑定 */
    MWAccountStatusQQ           = 1 << 4,    /* QQ账号绑定 */
    MWAccountStatusWeChat       = 1 << 5,    /* 微信账号绑定 */
};

typedef NS_ENUM(NSInteger, MWUserGenderType) {
    MWUserGenderTypeNone    = 0,    /* 保密 */
    MWUserGenderTypeFemale  = 1,    /* 女 */
    MWUserGenderTypeMale    = 2,    /* 男 */
};
typedef NS_ENUM(NSUInteger, YDUserGender) {
    YDUserGenderNone    = 0,
    YDUserGenderMan     = 10,
    YDUserGenderWoman   = 20,
};

typedef NS_ENUM(NSInteger, MWRefreshState){
    MWRefreshStatePulling       = 1,
    MWRefreshStateNormal        = 2,
    MWRefreshStateRefreshing    = 3
};

typedef NS_ENUM(NSInteger, YDTimeSkinType){
    YDTimeSkinTypeNormal        = 1,
    YDTimeSkinTypeFast          = 2
};

typedef NS_ENUM(NSInteger, YDHolidayYearType){
    YDHolidayYearTypeNone       = 0,
    YDHolidayYearTypeEvery      = 1, // 每年
    YDHolidayYearTypeCurrent    = 2  // 今年
};

typedef NS_ENUM(NSInteger, YDShopOpenType){
    YDShopOpenTypeYES           = 1,      //开门
    YDShopOpenTypeNO            = 2       //未开门
};

typedef NS_ENUM(NSInteger, YDIdleBoxType){
    YDIdleBoxTypeYes             = 1,      //是包厢
    YDIdleBoxTypeNO              = 2       //否
};

typedef NS_ENUM(NSInteger, YDShopCuiType){
    YDShopCuiTypeNO             = 1,      //没催单
    YDShopCuiTypeYES            = 2       //已催单
};

//美味支付订单状态
typedef NS_ENUM(NSInteger, MWDealOrderState){
    MWDealOrderStateZhiFuFail    = -2, //支付失败 --
    MWDealOrderStateYiTuiKuan    = -1, //已退款 --
    MWDealOrderStateDaiZhiFu     =  0, //待支付
    MWDealOrderStateBuFenZhiFu   =  1,
    MWDealOrderStateZhiFuSuccess =  2, //支付成功
    MWDealOrderStateYiJiuCan     =  3  //已就餐 --
};

typedef NS_ENUM(NSInteger, MWCouponType){
    MWCouponTypeNone            = 0,
    MWCouponTypeManJian         = 1,//满多少减免
    MWCouponTypeDaiJin          = 2,//代金券
    MWCouponTypeZheKou          = 3,//折扣券
    MWCouponTypeOther           = 4,//第三方券
    MWCouponTypeGoupon          = 5,//团购券
    MWCouponTypeLiPin           = 6,//礼品券
    MWCouponTypeYouHui          = 7,//优惠券
};

typedef NS_ENUM(NSInteger, MWCouponStatus){
    MWCouponStatusUnUsed          = 0,//未使用
    MWCouponStatusUsed            = 1,//已使用
    MWCouponStatusTuiKuan         = 2,//退款中/申请退款
    MWCouponStatusYiTuiKuan       = 3,//已退款
    MWCouponStatusExpired         = 4,//作废/过期
};

typedef NS_ENUM(NSInteger, QueueBuyType) {
    QueueBuyTypeNO              = 0, //不可以买号
    QueueBuyTypeYES             = 1, //可以买号
};

typedef NS_ENUM(NSInteger, QueueBuyStatus) {
    QueueBuyStatusNo               = 0, //未购买
    QueueBuyStatusSuccess          = 1, //已支付
    QueueBuyStatusIng              = 2, //支付中
    QueueBuyStatusFail             = 3, //支付失败
    QueueBuyStatusRefundIng        = 4, //退款中
    QueueBuyStatusRefunded         = 5, //已退款
};

// 预约到店定金状态
typedef NS_ENUM(NSUInteger, MWQuickQueueDepositState) {
    MWQuickQueueDepositStateNone                               = 0, // 未支付
    MWQuickQueueDepositStatePayed                              = 1, // 已支付
    MWQuickQueueDepositStateRefund                             = 2, // 已退款(取号失败、抵扣模式买单后未使用定金、就餐退款模式已就餐)
    MWQuickQueueDepositStateDeductWhenDepositShop              = 3, // 已抵扣(抵扣模式下已使用该定金)
    MWQuickQueueDepositStateDeductWhenCancelAndBeyond24Hour    = 4, // 已扣款(已过号超过24小时、取消号单)
    MWQuickQueueDepositStateRefundAndDeduct                    = 5, // 预约到店即退款又扣款
};

typedef NS_ENUM(NSInteger, MWPayResultStatus) {
    MWPayResultStatusNo               = 0, //未支付
    MWPayResultStatusSuccess          = 1, //成功支付
    MWPayResultStatusFail             = 2, //支付失败
    MWPayResultStatusfunded           = 3, //已退款
};

//号单购买的状态
typedef NS_ENUM(NSInteger, QueueOrderBuyType) {
    QueueOrderBuyTypeUpdate    = 0, //号单升级
    QueueOrderBuyTypeNone      = 1, //直接购买号单
};
//预订付费类型
typedef NS_ENUM(NSInteger, YDPayType) {
    YDPayTypeNone                  = 0, //默认
    YDPayTypeDJ                    = 1, //定金
    YDPayTypeDJQ                   = 2, //代金券
};
//预订付费锁定订单结果
typedef NS_ENUM(NSInteger, YDLockResult) {
    YDLockResultFail                  = 0, //锁定失败
    YDLockResultSuccess               = 1, //锁定成功
};

//预订号单类型
typedef NS_ENUM(NSInteger, QueueMobile) {
    QueueMobileNO               = 0, //不显示
    QueueMobileYES              = 1, //显示
};

typedef NS_ENUM(NSInteger, SearchBuyPayResult) {
    SearchBuyPayResultDefault       = 0, //默认
    SearchBuyPayResultFetcQueue     = 1, //取号服务费
    SearchBuyPayResultDJQueue       = 2, //取号定金
    SearchBuyFastQueue              = 3, //取号定金
};

typedef NS_ENUM(NSInteger, MessageType) {
    MessageActivity            = 1, //美味活动
    MessageNotice              = 2, //美味通知
};
//快速排队类型 抵扣 退款
typedef NS_ENUM(NSInteger, FaseQueueType) {
    FaseQueueTypeDK            = 1, //抵扣
    FaseQueueTypeTK            = 2, //退款
};

typedef NS_ENUM(NSUInteger, ShowControllerType) {
    ShowControllerTypePush,
    ShowControllerTypePresent,
};

typedef NS_ENUM(NSUInteger, MWQuickQueueShopDepositType) {
    MWQuickQueueShopDepositTypeDeduction                    = 1, // 定金可抵扣
    MWQuickQueueShopDepositTypeRefundWhenRepasted           = 2, // 定金就餐后退款
    MWQuickQueueShopDepositTypeLimitedTimeDeduction         = 3, // 限时抵扣（又称服务费）模式
};

//是否支持无人排队取号
typedef NS_ENUM(NSInteger, QueueNoAbleType) {
    QueueNoAbleTypeNO            = 0, //不支持
    QueueNoAbleTypeYES           = 1, //支持
};



typedef NS_ENUM(NSInteger, MWBannersPosition) {
    MWBannersPositionQueueList              = 2,    // 排队取号列表
    MWBannersPositionYuDingList             = 3,    // 预约订座列表
    MWBannersPositionQueueAndYuDing         = 4,    // 排队预约列表
};

typedef NS_ENUM(NSInteger, ShopListType) {
    ShopListTypeNone                    = 0, // 不区分
    ShopListTypeQueueAndYuDing          = 1, // 附近餐厅列表
    //    ShopListTypeSearch,
    ShopListTypeQueue                   = 2, // 排队取号列表
    ShopListTypeYuDing                  = 3, // 预约订座列表
    //    ShopListTypeShoppingMall,
};

typedef NS_ENUM(NSInteger, DeskType) {
    DeskTypeNO                          = 0, // 无
    DeskTypeBF                          = 1, //有包房
    DeskTypeZW                          = 2, // 可选桌位
    DeskTypeBFZW                        = 3, // 可选包房桌位
};

typedef NS_ENUM(NSInteger, HasBFType) {
    HasBFTypeNO                          = 0, // 无
    HasBFTypeBF                          = 1, //有包房
};

typedef NS_ENUM(NSInteger, FastQueueType) {
    FastQueueTypeNO                          = 0, // 无
    FastQueueTypeSingle                      = 1, //不展示具体桌数
    FastQueueTypeDouble                      = 2, //展示具体桌数
};

typedef NS_ENUM(NSInteger, PushMsgAlertFlag) {
    PushMsgAlertFlagNO                       = 0, //不展示
    PushMsgAlertFlagQueue                    = 1, //展示 页面为号单详情
    PushMsgAlertFlagYD                       = 2, //展示 页面为预定单详情
};

typedef NS_ENUM(NSInteger, DealDetailType) {
    DealDetailTypeNO                        = 0, //不展示美味买单类型行
    DealDetailTypeDJDK                      = 1, //抵扣买单
    DealDetailTypeDJDD                      = 2, //到店退款
    DealDetailTypeFWF                       = 3,//服务费抵扣
};
