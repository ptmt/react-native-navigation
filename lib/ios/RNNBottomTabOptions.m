#import "RNNBottomTabOptions.h"

@implementation RNNBottomTabOptions

-(instancetype)initWithDict:(NSDictionary *)tabItemDict {
	self = [super init];
	
	[self mergeWith:tabItemDict];
	self.tag = [tabItemDict[@"tag"] integerValue];
	
	return self;
}

- (void)applyOn:(UIViewController *)viewController {
	if (self.title || self.icon) {
		UITabBarItem* tabItem = [[UITabBarItem alloc] initWithTitle:self.title image:[RCTConvert UIImage:self.icon] tag:self.tag];
		tabItem.accessibilityIdentifier = self.testID;
		[viewController.navigationController setTabBarItem:tabItem];
	}
	
	if (self.badge) {
		NSString *badge = nil;
		if (self.badge != nil && ![self.badge isEqual:[NSNull null]]) {
			badge = [RCTConvert NSString:self.badge];
		}
		if (viewController.navigationController) {
			viewController.navigationController.tabBarItem.badgeValue = badge;
		} else {
			viewController.tabBarItem.badgeValue = badge;
		}
	}
	
	if (self.visible) {
		[viewController.tabBarController setSelectedIndex:[viewController.tabBarController.viewControllers indexOfObject:viewController]];
	}
	
	[self resetOptions];
}

-(void)resetOptions {
	self.title = nil;
	self.badge = nil;
	self.visible = nil;
	self.icon = nil;
	self.testID = nil;
}

@end
