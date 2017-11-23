//
//  RestClient.h
//  RestClient
//
//  Created by Jensen on 15/9/17.
//
//

#import <Foundation/Foundation.h>

@interface RestClient : NSObject

@property (nonatomic) NSUInteger requestRetryCount; // Default is 1.
@property (nonatomic) NSTimeInterval requestTimeout;//By seconds, default is 15.

-(void)getWithURL:(NSURL*)url headerParam:(NSMutableDictionary*)headerParam responseClass:(Class)respClass completion:(void(^)(id response,NSError* error))completion;
-(void)getWithURL:(NSURL*)url responseClass:(Class)respClass completion:(void(^)(id response,NSError* error))completion;

-(void)postWithURL:(NSURL*)url headerParam:(NSMutableDictionary*)headerParam body:(id)body responseClass:(Class)respClass completion:(void(^)(id response,NSError* error))completion;
-(void)postWithURL:(NSURL*)url body:(id)body responseClass:(Class)respClass completion:(void(^)(id response,NSError* error))completion;

-(void)getStreamDataWithUrl:(NSURL *)url completion:(void(^)(NSData *data,NSError *error))completion;

//
//-(void)postWithURL:(NSURL*)url body:(id)body responseClass:(Class)respClass originalCompletion:(void(^)(id response,NSError* error,NSArray *arry))completion;

@end
