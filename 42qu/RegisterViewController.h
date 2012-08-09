//
//  RegisterViewController.h
//  42qu
//
//  Created by Alex on 08/08/2012.
//  Copyright (c) 2012 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterViewControllerDelegate <NSObject>

@end

@interface RegisterViewController : UIViewController

@property (nonatomic, assign) id<RegisterViewControllerDelegate> delegate;

@end
