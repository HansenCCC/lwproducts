//
//  HVUICollectionViewTitleSupplementaryView.m
//  hvui
//
//  Created by moon on 15/9/15.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import "HVUICollectionViewTitleSupplementaryView.h"
#import "UICollectionReusableView+HVUICollectionViewSupplementaryElementProtocol.h"

@implementation HVUICollectionViewTitleSupplementaryView
- (id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		[self _myInit];
	}
	return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
	if (self=[super initWithCoder:aDecoder]) {
		[self _myInit];
	}
	return self;
}
- (void)_myInit{
	self.textLabel = [[UILabel alloc] init];
	self.textLabel.font = [UIFont systemFontOfSize:15];
	self.textLabel.textColor = [UIColor lightGrayColor];
	self.textLabel.numberOfLines = 0;
	self.textLabel.textAlignment = NSTextAlignmentLeft;
	[self addSubview:self.textLabel];
}
- (void)layoutSubviews{
	[super layoutSubviews];
	CGRect bounds = self.bounds;
	UIEdgeInsets insets = [self.class contentInsets];
	//
	CGRect f1 = UIEdgeInsetsInsetRect(bounds, insets);
	self.textLabel.frame = f1;
}
+ (UIEdgeInsets)contentInsets{
	UIEdgeInsets insets = UIEdgeInsetsMake(5,5,5,5);
	return insets;
}
#pragma mark - protocol:HVUICollectionViewSupplementaryElementProtocol
- (void)setCollectionSectionModel:(HVUICollectionViewSectionModel *)sectionModel forKind:(NSString *)kind{
	[super setCollectionSectionModel:sectionModel forKind:kind];
	if([sectionModel isKindOfClass:[HVUICollectionViewTitleSupplementarySectionModel class]]){
		self.titleSectionModel = (HVUICollectionViewTitleSupplementarySectionModel *)sectionModel;
	}else{
		self.titleSectionModel = nil;
	}
	NSString *text = nil;
	if([kind isEqualToString:UICollectionElementKindSectionHeader]){
		text = self.titleSectionModel.headTitle;
	}else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
		text = self.titleSectionModel.footTitle;
	}
	self.textLabel.text = text;
}
DEF_SINGLETON(HVUICollectionViewTitleSupplementaryView)
+ (CGSize)referenceSizeWithCollectionView:(UICollectionView *)collectionView collectionSectionModel:(HVUICollectionViewSectionModel *)sectionModel forKind:(NSString *)kind{
	CGSize size = [self dynamicReferenceSizeWithCollectionView:collectionView collectionSectionModel:sectionModel forKind:kind viewShareInstance:[self sharedInstance] calBlock:^CGSize(UICollectionView *collectionView, HVUICollectionViewSectionModel *sectionModel, NSString *kind, HVUICollectionViewTitleSupplementaryView *view) {
		CGRect bounds = collectionView.bounds;
		UIEdgeInsets insets = [self.class contentInsets];
		CGSize size = bounds.size;
		UILabel *textLabel = view.textLabel;
		CGRect f1 = textLabel.frame;
		CGSize f1_size = [textLabel sizeThatFits:CGSizeMake(f1.size.width, 9999)];
		if(f1_size.height==0){
			size = CGSizeZero;
		}else{
			size.height = f1_size.height+insets.top+insets.bottom;
		}
		return size;
	}];
	return size;
}
@end
