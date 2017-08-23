//
//  MGMenuViewController.h
//  MyGirl
//
//  Created by liguang on 2017/8/23.
//  Copyright © 2017年 Firstlight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CDSideBarController.h"

@interface MGMenuViewController : BaseViewController <CDSideBarControllerDelegate>
{
    CDSideBarController *sideBar;
}



@end
