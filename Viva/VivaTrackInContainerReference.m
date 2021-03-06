//
//  VivaPlayableTrack.m
//  Viva
//
//  Created by Daniel Kennett on 4/14/11.
//  For license information, see LICENSE.markdown
//

/*
 This is a very simple wrapper class that allows every single track in a context to be unique,
 whether they are or not. Needed to assist playback flow when a context has the same track(s)
 in it multiple times, and using indexes is stupid.
 */

#import "VivaTrackInContainerReference.h"

@interface VivaTrackInContainerReference ()

@property (copy, readwrite) NSString *uniqueId;
@property (readwrite, weak) SPTrack *track;
@property (readwrite, weak) id container;

@end

@implementation VivaTrackInContainerReference

-(id)initWithTrack:(SPTrack *)aTrack inContainer:(id)aContainer {
	if ((self = [super init])) {
		self.uniqueId = [[NSProcessInfo processInfo] globallyUniqueString];
		self.track = aTrack;
		self.container = aContainer;
	}
	return self;
}

-(id)initWithTrack:(SPTrack *)aTrack inContainer:(id)aContainer existingId:(NSString *)anId {
	if ((self = [super init])) {
		self.uniqueId = anId;
		self.track = aTrack;
		self.container = aContainer;
	}
	return self;
}


-(id)copyWithZone:(NSZone *)zone {
    return [[[self class] alloc] initWithTrack:self.track inContainer:self.container existingId:self.uniqueId];
}

@synthesize track;
@synthesize container;
@synthesize uniqueId;

-(BOOL)isEqual:(id)object {
	if ([object isKindOfClass:[VivaTrackInContainerReference class]]) {
		return [((VivaTrackInContainerReference *)object).uniqueId isEqualToString:self.uniqueId] && 
		((VivaTrackInContainerReference *)object).container == self.container && 
		((VivaTrackInContainerReference *)object).track == self.track;
	} else {
		return NO;
	}
}

- (void)dealloc {
	self.track = nil;
	self.container = nil;
}

@end
