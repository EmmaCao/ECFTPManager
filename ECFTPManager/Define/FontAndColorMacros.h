//
//  FontAndColorMacros.h
//  ECFTPManager
//
//  Created by Emma on 2019/6/3.
//  Copyright © 2019 Emma. All rights reserved.
//

//字体大小和颜色配置

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

#pragma mark -  间距区
//默认间距
#define KNormalSpace 10.0f
#define KLineSpacing 5.0f
#define KCVInteritemSpace 5.0f

//控件高度
#define KLabelHeight 20.0f

#pragma mark -  颜色区
//主题色 导航栏颜色
#define CRGBColor(color) [UIColor colorWithHexString:color]
#define CPrimaryColor [UIColor colorWithHexString:@"0099FF"]
#define CNavBgColor  [UIColor colorWithHexString:@"0099FF"]
#define CNavBgFontColor  [UIColor colorWithHexString:@"ffffff"]
#define CTabbarFontColor [UIColor colorWithHexString:@"707070"]
//默认页面背景色
#define CViewBgColor [UIColor colorWithHexString:@"f2f2f2"]
//分割线颜色
#define CLineColor [UIColor colorWithHexString:@"EBEBEB"]
//次级字色
#define CFontColor2 [UIColor colorWithHexString:@"5c5c5c"]
//再次级字色
#define CFontColor1 [UIColor colorWithHexString:@"#707070"]

#pragma mark -  字体
#define FFont12 [UIFont systemFontOfSize:12.0f]
#define FFont14 [UIFont systemFontOfSize:14.0f]
#define FFont18 [UIFont systemFontOfSize:18.0f]


#endif /* FontAndColorMacros_h */
