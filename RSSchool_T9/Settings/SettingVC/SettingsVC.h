//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 31.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import <UIKit/UIKit.h>
#import "ColorListTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingsVC : UIViewController 
@property (nonatomic) BOOL turnedTimer;
@property (nonatomic, strong, nullable) ColorListTableVC *listOfColor;

@end

NS_ASSUME_NONNULL_END
