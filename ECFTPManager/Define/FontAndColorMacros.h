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
//#define KRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//#define KRGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
//
//#define CPrimaryColor KRGBHex(@"0x0099FF")
//#define CNavBgColor  KRGBHex(@"0099FF")
//#define CNavBgFontColor  KRGBHex(@"ffffff")
//#define CTabbarFontColor KRGBHex(@"707070")
////默认页面背景色
//#define CViewBgColor KRGBHex(@"f2f2f2")
////分割线颜色
//#define CLineColor KRGBHex(@"EBEBEB")
////次级字色
//#define CFontColor2 KRGBHex(@"5c5c5c")
////再次级字色
//#define CFontColor1 KRGBHex(@"707070")

#pragma mark -  字体
#define FFont12 [UIFont systemFontOfSize:12.0f]
#define FFont14 [UIFont systemFontOfSize:14.0f]
#define FFont18 [UIFont systemFontOfSize:18.0f]


#endif /* FontAndColorMacros_h */
