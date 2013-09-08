//
//  MonoAppDelegate.m
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "MonoAppDelegate.h"
#import "MonoUI.h"

@implementation MonoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DBAccountManager *accountManager = [[DBAccountManager alloc] initWithAppKey:DropboxAppKey
                                                                         secret:DropboxSecret];
    DBAccountManager.sharedManager = accountManager;
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
	DBAccount *account = [[DBAccountManager sharedManager] handleOpenURL:url];
    NSArray* queryList = [url.query componentsSeparatedByString:@"&"];
    NSMutableDictionary* queryDictionary = [NSMutableDictionary new];
    for(NSString* query in queryList) {
        NSArray* dictList = [query componentsSeparatedByString:@"="];
        [queryDictionary setObject:[dictList lastObject] forKey:[dictList objectAtIndex:0]];
    }
    NSString* userToken = queryDictionary[@"oauth_token"];
    NSString* userSecret = queryDictionary[@"oauth_token_secret"];
	if (account) {
		DBFilesystem *fileSystem = [[DBFilesystem alloc] initWithAccount:account];
        UIModelAccessor* modelAccessor = inject(UIModelAccessor);
        [modelAccessor.myProfile updateWithDBUserToken:userToken dbUserSecret:userSecret];
        modelAccessor.dbFileSystem = fileSystem;
	}
	return YES;
}

@end
