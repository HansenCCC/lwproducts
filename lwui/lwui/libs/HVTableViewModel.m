//
//  HVTableViewModel.m
//  hvui
//
//  Created by moon on 14-4-3.
//  Copyright (c) 2014年 heimavista.com. All rights reserved.
//

#import "HVTableViewModel.h"
#import <objc/runtime.h>
#import "UIScrollView+LWUI.h"

@implementation HVTableViewModel
- (void)dealloc{
	
}
- (HVTableViewModel *)init{
	if(self=[super init]){
		self.defaultSectionIndexTitle = TableViewDefaultSectionIndexTitle;
	}
	return self;
}
- (id)initWithTableView:(UITableView *)tableView{
	if (self=[self init]) {
		[self setTableViewDataSourceAndDelegate:tableView];
	}
	return self;
}
- (HVCollectionSectionModel *)createEmptySectionModel{
	HVTableViewSectionModel *section = [[HVTableViewSectionModel alloc] init];
	return section;
}
- (void)addCellModel:(HVCollectionCellModel *)cellModel{
	if(!cellModel)return;
	HVTableViewSectionModel *section = (HVTableViewSectionModel *)[self.sectionModels lastObject];
	if(!section){
		section = (HVTableViewSectionModel *)[self createEmptySectionModel];
		[self addSectionModel:section];
	}
	[section addCellModel:cellModel];
}
- (__kindof HVTableViewCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexpath{
	HVCollectionCellModel *cellModel = [super cellModelAtIndexPath:indexpath];
	if([cellModel isKindOfClass:[HVTableViewCellModel class]]){
		return (HVTableViewCellModel *)cellModel;
	}
	return nil;
}
- (__kindof HVTableViewCellModel *)cellModelForSelectedCellModel{
	HVCollectionCellModel *cellModel = [super cellModelForSelectedCellModel];
	if([cellModel isKindOfClass:[HVTableViewCellModel class]]){
		return (HVTableViewCellModel *)cellModel;
	}
	return nil;
}
- (__kindof HVTableViewSectionModel *)sectionModelAtIndex:(NSInteger)index{
	HVCollectionSectionModel *sectionModel = [super sectionModelAtIndex:index];
	if([sectionModel isKindOfClass:[HVTableViewSectionModel class]]){
		return (HVTableViewSectionModel *)sectionModel;
	}
	return nil;
}
- (HVTableViewSectionModel *)addAutoIndexedCellModel:(HVTableViewCellModel *)cellModel{
	if(!cellModel){
		return nil;
	}
	BOOL useDefaultIndexTitle = cellModel.indexTitle.length==0;
	NSString *indexTitle = useDefaultIndexTitle?self.defaultSectionIndexTitle:cellModel.indexTitle;
	HVTableViewSectionModel *sectionModel = useDefaultIndexTitle?_defaultIndexTitleSectionModel:[self sectionModelWithIndexTitle:indexTitle];
	if(!sectionModel){
		sectionModel = (HVTableViewSectionModel *)[self createEmptySectionModel];
		sectionModel.indexTitle = indexTitle;
		sectionModel.headTitle = indexTitle;
		sectionModel.showHeadView = YES;
		sectionModel.showDefaultHeadView = YES;
		if(useDefaultIndexTitle){
			_defaultIndexTitleSectionModel = sectionModel;
		}
		[self addSectionModel:sectionModel];
	}
	[sectionModel addCellModel:cellModel];
	return sectionModel;
}
/**
 *	根據單元格的索引值,獲取應該被歸類的分組數據
 */
- (HVTableViewSectionModel *)sectionModelWithIndexTitle:(NSString *)indexTitle{
	HVTableViewSectionModel *sectionModel;
	for (HVTableViewSectionModel *m in self.sectionModels) {
		NSString *sectionIndexTitle = m.indexTitle;
		if([sectionIndexTitle isEqual:indexTitle]){
			sectionModel = m;
			break;
		}
	}
	return sectionModel;
}
- (void)sort{
	[self.mutableSectionModels sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		NSString *t1 = [(HVTableViewSectionModel *)obj1 indexTitle];
		NSString *t2 = [(HVTableViewSectionModel *)obj2 indexTitle];
		NSComparisonResult r = [t1 compare:t2];
		if(r!=NSOrderedSame){	//保證使用默認的分組索引值位置排序的最底部
			if(obj1==_defaultIndexTitleSectionModel){
				r = NSOrderedDescending;
			}else if(obj2==_defaultIndexTitleSectionModel){
				r = NSOrderedAscending;
			}
		}
		return r;
	}];
}
- (void)reloadTableViewData{
	[self reloadTableViewDataWithAnimated:NO];
}
- (void)reloadTableViewDataWithAnimated:(BOOL)animated{
	[self.tableView reloadData];
	if(self.allowsSelection){
		@HV_WEAKIFY(self);
		dispatch_async(dispatch_get_main_queue(), ^{
			@HV_NORMALIZEANDNOTNIL(self);
			if(self.allowsMultipleSelection){
				NSArray *indexpaths = [self indexPathsForSelectedCellModels];
				for (NSIndexPath *indexpath in indexpaths) {
					[self.tableView selectRowAtIndexPath:indexpath animated:animated scrollPosition:UITableViewScrollPositionNone];
				}
			}else{
				NSIndexPath *indexpath = [self indexPathForSelectedCellModel];
				[self.tableView selectRowAtIndexPath:indexpath animated:animated scrollPosition:UITableViewScrollPositionNone];
			}
		});
	}
	[self reloadTableViewBackgroundView];
}
- (void)addCellModel:(HVTableViewCellModel *)cellModel animated:(BOOL)animated{
	if(!cellModel)return;
	UITableView *tableView = self.tableView;
	[self addCellModel:cellModel];
	HVCollectionSectionModel *sm = [self.sectionModels lastObject];
	NSIndexPath *indexpath = [NSIndexPath indexPathForItem:[sm numberOfCells]-1 inSection:self.sectionModels.count-1];
	[tableView beginUpdates];
	if([tableView numberOfSections]==0){//添加section
		[tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:animated?UITableViewRowAnimationAutomatic:UITableViewRowAnimationNone];
	}
	[tableView insertRowsAtIndexPaths:@[indexpath] withRowAnimation:animated?UITableViewRowAnimationAutomatic:UITableViewRowAnimationNone];
	[tableView endUpdates];
	[self reloadTableViewBackgroundView];
}
- (void)insertCellModel:(HVTableViewCellModel *)cellModel atIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated{
	if(!cellModel||!indexPath)return;
	UITableView *tableView = self.tableView;
	HVCollectionSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
	if(sectionModel){
		[sectionModel insertCellModel:cellModel atIndex:indexPath.row];
	}else{//section不存在时,不操作
		return;
	}
	[tableView beginUpdates];
	[tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animated?UITableViewRowAnimationAutomatic:UITableViewRowAnimationNone];
	[tableView endUpdates];
	[self reloadTableViewBackgroundView];
}
- (void)insertCellModel:(HVTableViewCellModel *)cellModel afterIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated{
	if(!cellModel)return;
	[self insertCellModels:@[cellModel] afterIndexPath:indexPath animated:animated];
}
- (void)insertCellModels:(NSArray *)cellModels afterIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated{
	if(cellModels.count==0||indexPath==nil)return;
	UITableView *tableView = self.tableView;
	[self insertCellModels:cellModels afterIndexPath:indexPath];
	NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:cellModels.count];
	for (int i=0; i<cellModels.count; i++) {
		NSIndexPath *addIndexpath = [NSIndexPath indexPathForRow:indexPath.row+1+i inSection:indexPath.section];
		[indexPaths addObject:addIndexpath];
	}
	[tableView beginUpdates];
	[tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:animated?UITableViewRowAnimationAutomatic:UITableViewRowAnimationNone];
	[tableView endUpdates];
	[self reloadTableViewBackgroundView];
}
- (void)insertCellModel:(HVTableViewCellModel *)cellModel beforeIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated{
	if(!cellModel)return;
	[self insertCellModels:@[cellModel] beforeIndexPath:indexPath animated:animated];
}
- (void)insertCellModels:(NSArray *)cellModels beforeIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated{
	if(cellModels.count==0||indexPath==nil)return;
	UITableView *tableView = self.tableView;
	[self insertCellModels:cellModels beforeIndexPath:indexPath];
	NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:cellModels.count];
	for (int i=0; i<cellModels.count; i++) {
		NSIndexPath *addIndexpath = [NSIndexPath indexPathForRow:indexPath.row+i inSection:indexPath.section];
		[indexPaths addObject:addIndexpath];
	}
	[tableView beginUpdates];
	[tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:animated?UITableViewRowAnimationAutomatic:UITableViewRowAnimationNone];
	[tableView endUpdates];
	[self reloadTableViewBackgroundView];
}
- (void)insertCellModelsToBottom:(NSArray<HVTableViewCellModel *> *)cellModels scrollToBottom:(BOOL)scrollToBottom{
	if(cellModels.count==0)return;
	HVTableViewSectionModel *sm = (HVTableViewSectionModel *)[[self sectionModels] lastObject];
	if(!sm){
		sm = (HVTableViewSectionModel *)[self createEmptySectionModel];
		[self addSectionModel:sm];
	}
	[sm insertCellModelsToBottom:cellModels];
	[self reloadTableViewData];
	//移动到底部
	if(scrollToBottom){
		[self.tableView scrollToBottomWithAnimated:YES];
	}
}
- (void)insertCellModelsToTop:(NSArray<HVTableViewCellModel *> *)cellModels keepContentOffset:(BOOL)keepContentOffset{
	if(cellModels.count==0)return;
	
	HVTableViewSectionModel *sm = (HVTableViewSectionModel *)[[self sectionModels] firstObject];
	if(!sm){
		sm = (HVTableViewSectionModel *)[self createEmptySectionModel];
		[self addSectionModel:sm];
	}
	[sm insertCellModelsToTop:cellModels];
	UITableView *tableView = self.tableView;
	//	//保持contentOffset不变
	CGPoint contentOffset = tableView.contentOffset;
	CGSize contentSize1 = tableView.contentSize;
	[self reloadTableViewData];
	CGSize contentSize2 = tableView.contentSize;
	contentOffset.y += contentSize2.height-contentSize1.height;
	if(keepContentOffset){
		[tableView setContentOffset:contentOffset animated:NO];
	}
}

- (void)removeCellModel:(HVTableViewCellModel *)cellModel animated:(BOOL)animated{
	if(!cellModel)return;
	NSIndexPath *indexpath = [self indexPathOfCellModel:cellModel];
	if(indexpath){
		[self removeCellModelAtIndexPath:indexpath];
		UITableView *tableView = self.tableView;
		[tableView beginUpdates];
		[tableView deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:animated?UITableViewRowAnimationAutomatic:UITableViewRowAnimationNone];
		[tableView endUpdates];
		[self reloadTableViewBackgroundView];
	}
}
- (void)removeCellModels:(NSArray *)cellModels animated:(BOOL)animated{
	if(cellModels.count==0)return;
	NSArray *indexpaths = [self indexPathsOfCellModels:cellModels];
	[self removeCellModelsAtIndexPaths:indexpaths animated:animated];
}
- (void)removeCellModelsAtIndexPaths:(NSArray *)indexpaths animated:(BOOL)animated{
	if(indexpaths.count==0)return;
	[self removeCellModelsAtIndexPaths:indexpaths];
	UITableView *tableView = self.tableView;
	[tableView beginUpdates];
	[tableView deleteRowsAtIndexPaths:indexpaths withRowAnimation:animated?UITableViewRowAnimationAutomatic:UITableViewRowAnimationNone];
	[tableView endUpdates];
	[self reloadTableViewBackgroundView];
}
- (void)insertSectionModel:(HVTableViewSectionModel *)sectionModel atIndex:(NSInteger)index animated:(BOOL)animated{
	if(!sectionModel)return;
	UITableView *tableView = self.tableView;
	[self insertSectionModel:sectionModel atIndex:index];
	
	NSIndexSet *set = [NSIndexSet indexSetWithIndex:index];
	NSInteger count = sectionModel.numberOfCells;
	NSMutableArray<NSIndexPath *> *indexpaths = [[NSMutableArray alloc] initWithCapacity:count];
	for (int i=0; i<count; i++) {
		NSIndexPath *indexpath = [NSIndexPath indexPathForRow:index inSection:index];
		[indexpaths addObject:indexpath];
	}
	
	[tableView beginUpdates];
	[tableView insertSections:set withRowAnimation:animated?UITableViewRowAnimationAutomatic:UITableViewRowAnimationNone];
	[tableView insertRowsAtIndexPaths:indexpaths withRowAnimation:animated?UITableViewRowAnimationAutomatic:UITableViewRowAnimationNone];
	[tableView endUpdates];
}
- (void)removeSectionModel:(HVTableViewSectionModel *)sectionModel animated:(BOOL)animated{
	UITableView *tableView = self.tableView;
	NSInteger index = sectionModel.indexInModel;
	[self removeSectionModel:sectionModel];
	
	NSIndexSet *set = [NSIndexSet indexSetWithIndex:index];
	NSInteger count = sectionModel.numberOfCells;
	NSMutableArray<NSIndexPath *> *indexpaths = [[NSMutableArray alloc] initWithCapacity:count];
	for (int i=0; i<count; i++) {
		NSIndexPath *indexpath = [NSIndexPath indexPathForRow:index inSection:index];
		[indexpaths addObject:indexpath];
	}
	
	[tableView beginUpdates];
	[tableView deleteSections:set withRowAnimation:animated?UITableViewRowAnimationAutomatic:UITableViewRowAnimationNone];
	[tableView deleteRowsAtIndexPaths:indexpaths withRowAnimation:animated?UITableViewRowAnimationAutomatic:UITableViewRowAnimationNone];
	[tableView endUpdates];
}
#pragma mark - forward
- (HVTableViewModel *)forwardDataSourceTo:(NSObject<UITableViewDataSource> *)dataSource{
	self.forwardDataSource = dataSource;
	return self;
}
- (HVTableViewModel *)forwardDelegateTo:(NSObject<UITableViewDelegate> *)delegate{
	self.forwardDelegate = delegate;
	return self;
}
- (void)setTableViewDataSourceAndDelegate:(UITableView *)tableView{
	self.tableView = tableView;
	tableView.dataSource = self;
	tableView.delegate = self;
}
- (void)setForwardDelegate:(id<UITableViewDelegate>)forwardDelegate{
	_forwardDelegate = forwardDelegate;
	if(self.tableView.delegate==self){
		self.tableView.delegate = nil;
		self.tableView.delegate = self;//重新赋值一次,使得scrollview重新判断scrollViewDidScroll:方法的有无
	}
}
#pragma mark - empty background
- (UIView *)createEmptyBackgroundView{
	Class c = self.emptyBackgroundViewClass;
	UIView *view;
	if(c){
		view = [[c alloc] init];
	}
	return view;
}
- (void)reloadTableViewBackgroundView{
	if(!self.emptyBackgroundViewClass)return;
	if(self.numberOfCells==0){
		if(!self.emptyBackgroundView){
			self.emptyBackgroundView = [self createEmptyBackgroundView];
		}
		self.tableView.backgroundView = self.emptyBackgroundView;
	}else{
		self.tableView.backgroundView = nil;
	}
	if(self.whenReloadBackgroundView) {
		self.whenReloadBackgroundView(self);
	}
}
#pragma mark - Forward Invocations
/**
 *根據指定的Selector返回該類支持的方法簽名,一般用於prototol或者消息轉發forwardInvocation:中NSInvocation參數的methodSignature屬性
 注:系統調用- (void)forwardInvocation:(NSInvocation *)invocation方法前,會先調用此方法獲取NSMethodSignature,然後生成方法所需要的NSInvocation
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
	NSMethodSignature *signature = [super methodSignatureForSelector:selector];
	if (signature == nil) {
		id delegate = self.forwardDelegate;
		if ([delegate respondsToSelector:selector]) {
			signature = [delegate methodSignatureForSelector:selector];
		}else{
			delegate = self.forwardDataSource;
			if ([delegate respondsToSelector:selector]) {
				signature = [delegate methodSignatureForSelector:selector];
			}
		}
	}
	return signature;
}
- (BOOL)respondsToSelector:(SEL)selector {
	if ([super respondsToSelector:selector]) {
		return YES;
	} else {
		if([self.forwardDelegate respondsToSelector:selector]){
			return YES;
		}else if([self.forwardDataSource respondsToSelector:selector]){
			return YES;
		}
	}
	return NO;
}
/**
 *對調用未定義的方法進行消息重定向
 */
- (void)forwardInvocation:(NSInvocation *)invocation {
	BOOL didForward = NO;
	id delegate = self.forwardDelegate;
	if ([delegate respondsToSelector:invocation.selector]) {
		[invocation invokeWithTarget:delegate];
		didForward = YES;
	}
	if(!didForward){
		delegate = self.forwardDataSource;
		if ([delegate respondsToSelector:invocation.selector]) {
			[invocation invokeWithTarget:delegate];
			didForward = YES;
		}
	}
	if (!didForward) {
		[super forwardInvocation:invocation];
	}
}
#pragma mark - delegate:UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	self.tableView = tableView;
	HVTableViewSectionModel *sectionModel = [self sectionModelAtIndex:section];
	NSInteger number = [sectionModel numberOfCells];
	return number;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	HVTableViewCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
	//使用静态单元格
	UITableViewCell<HVTableViewCellProtocol> *staticCell = cellModel.staticTableViewCell;
	if(staticCell){
		[cellModel displayCell:staticCell];
		return staticCell;
	}
	
	NSString *identity = cellModel.reuseIdentity;
	UITableViewCell<HVTableViewCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:identity];
	if(!cell){
		Class cellClass = cellModel.cellClass;
		cell = [[cellClass alloc] initWithStyle:cellModel.cellStyle reuseIdentifier:identity];
	}
	[cellModel displayCell:cell];
	return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	NSInteger sections = [self numberOfSections];
	return sections;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
	BOOL edit = NO;
	HVTableViewCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
	edit = cellModel.canEdit;
	return edit;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
	BOOL move = NO;
	HVTableViewCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
	move = cellModel.canMove;
	return move;
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
	HVTableViewCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
	if(cellModel.whenClickAccessory){
		cellModel.whenClickAccessory(cellModel);
	}
}
- (NSArray*)_sectionIndexTitlesForTableView:(UITableView *)tableView{
	NSMutableArray *sectionIndexTitles = nil;
	if(self.showSectionIndexTitle){
		sectionIndexTitles = [[NSMutableArray alloc] init];
		for (HVTableViewSectionModel *sectionModel in self.sectionModels) {
			NSString *title = sectionModel.indexTitle?:self.defaultSectionIndexTitle;
			if(title){
				[sectionIndexTitles addObject:@{@"title":title,@"model":sectionModel}];
			}
		}
	}
	return sectionIndexTitles;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{ // return list of section titles to display in section index view (e.g. "ABCD...Z#")
	NSMutableArray *sectionIndexTitles = nil;
	if(self.showSectionIndexTitle){
		sectionIndexTitles = [[NSMutableArray alloc] init];
		NSArray *map = [self _sectionIndexTitlesForTableView:tableView];
		for (NSDictionary* info in map) {
			NSString *title = info[@"title"];
			[sectionIndexTitles addObject:title];
		}
	}
	return sectionIndexTitles;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{// tell table which section corresponds to section title/index (e.g. "B",1))
	NSInteger sectionIndex = NSNotFound;
	if(self.showSectionIndexTitle){
		NSArray *map = [self _sectionIndexTitlesForTableView:tableView];
		NSDictionary *info = [map objectAtIndex:index];
		HVTableViewSectionModel *sectionModel = info[@"model"];
		sectionIndex = [self indexOfSectionModel:sectionModel];
	}
	return sectionIndex;
}
// Data manipulation - insert and delete support
// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
	if(editingStyle==UITableViewCellEditingStyleDelete){
		HVTableViewCellModel *cellModel = nil;
		HVTableViewSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
		cellModel = [sectionModel cellModelAtIndex:indexPath.row];
		if(cellModel.whenDelete){
			BOOL nowDelete = cellModel.whenDelete(cellModel);
			if(nowDelete){
				[sectionModel removeCellModel:cellModel];
				[tableView reloadData];
				[self reloadTableViewBackgroundView];
			}
		}
	}
	if([self.forwardDataSource respondsToSelector:_cmd]){
		[self.forwardDataSource tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
	}
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
	HVTableViewCellModel *srcTablecellModel = [self cellModelAtIndexPath:sourceIndexPath];
	HVTableViewCellModel *dstTablecellModel = [self cellModelAtIndexPath:destinationIndexPath];
	BOOL handed = NO;
	HVTableViewCellModelBlockM handler = srcTablecellModel.whenMove?:dstTablecellModel.whenMove;
	if(handler){
		handler(srcTablecellModel,dstTablecellModel);
		handed = YES;
	}
	if([self.forwardDataSource respondsToSelector:_cmd]){
		[self.forwardDataSource tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
		handed = YES;
	}
	if(!handed){
		[self moveCellModelAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	HVTableViewCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
	Class cellClass;
	//使用静态单元格
	UITableViewCell<HVTableViewCellProtocol> *staticCell = cellModel.staticTableViewCell;
	if(staticCell){
		cellClass = staticCell.class;
	}else{
		cellClass = cellModel.cellClass;
	}
	
	CGFloat height = [cellClass heightWithTableView:tableView cellModel:cellModel];
	return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	CGFloat height = 0;
	HVTableViewSectionModel *sectionModel = [self sectionModelAtIndex:section];
	if (sectionModel.showHeadView) {
		if(sectionModel.showDefaultHeadView){
			height = sectionModel.headViewHeight;
		}else{
			height = [sectionModel.headViewClass heightWithTableView:tableView sectionModel:sectionModel kind:HVTableViewSectionViewKindOfHead];
		}
	}
	return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	CGFloat height = 0;
	HVTableViewSectionModel *sectionModel = [self sectionModelAtIndex:section];
	if(sectionModel.showFootView){
		if(sectionModel.showDefaultFootView){
			height = sectionModel.footViewHeight;
		}else{
			height = [sectionModel.footViewClass heightWithTableView:tableView sectionModel:sectionModel kind:HVTableViewSectionViewKindOfFoot
					  ];
		}
	}
	return height;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	HVTableViewSectionModel *sectionModel = [self sectionModelAtIndex:section];
	NSString *title = sectionModel.headTitle;
	return title;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
	HVTableViewSectionModel *sectionModel = [self sectionModelAtIndex:section];
	NSString *title = sectionModel.footTitle;
	return title;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	UIView<HVTableViewSectionViewProtocol> *view = nil;
	HVTableViewSectionModel *sectionModel = [self sectionModelAtIndex:section];
	if(!sectionModel.showDefaultHeadView){
		Class c = sectionModel.headViewClass;
		if(c){
			CGRect f = CGRectMake(0, 0, tableView.bounds.size.width, 40);
			f.size.height = [self tableView:tableView heightForHeaderInSection:section];
			view = [[c alloc] initWithFrame:f];
			[sectionModel displayHeadView:view];
		}
	}
	return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
	UIView<HVTableViewSectionViewProtocol> *view = nil;
	HVTableViewSectionModel *sectionModel = [self sectionModelAtIndex:section];
	if(!sectionModel.showDefaultFootView){
		Class c = sectionModel.footViewClass;
		if(c){
			CGRect f = CGRectMake(0, 0, tableView.bounds.size.width, 40);
			f.size.height = [self tableView:tableView heightForFooterInSection:section];
			view = [[c alloc] initWithFrame:f];
			[sectionModel displayFootView:view];
		}
	}
	return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	if(cell
	   &&[cell conformsToProtocol:@protocol(HVTableViewCellProtocol)]
	   &&[cell respondsToSelector:@selector(tableView:didSelectCell:)]
	   ){
		[cell tableView:tableView didSelectCell:YES];
	}
	HVTableViewCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
	[self selectCellModel:cellModel];
	if(cellModel.whenSelected){
		cellModel.whenSelected(cellModel,YES);
	}
	if(cellModel.whenClick){
		cellModel.whenClick(cellModel);
	}
	if([self.forwardDelegate respondsToSelector:_cmd]){
		[self.forwardDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
	}
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	if(cell
	   &&[cell conformsToProtocol:@protocol(HVTableViewCellProtocol)]
	   &&[cell respondsToSelector:@selector(tableView:didSelectCell:)]
	   ){
		[cell tableView:tableView didSelectCell:NO];
	}
	HVTableViewCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
	[self deselectCellModel:cellModel];
	if(cellModel.whenSelected){
		cellModel.whenSelected(cellModel,NO);
	}
	if([self.forwardDelegate respondsToSelector:_cmd]){
		[self.forwardDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
	}
}
#pragma debug
- (NSString *)description{
	return [NSString stringWithFormat:@"%@:[sectionModels:%@,showSectionIndexTitle:%d,userInfo:%@]",NSStringFromClass(self.class),self.sectionModels,self.showSectionIndexTitle,self.userInfo];
}
@end

@implementation HVTableViewModel(NS_DEPRECATED_IOS)//将要被废弃的接口
- (NSArray *)cellsOfSelected:(BOOL)selected{
	return [self cellModelsOfSelected:selected];
}
- (void)removeEmptySections{
	[self removeEmptySectionModels];
}
- (HVTableViewSectionModel *)sectionModelAtSection:(NSUInteger)section{
	return [self sectionModelAtIndex:section];
}
- (NSIndexPath *)indexPathWithCellModel:(HVTableViewCellModel *)cellModel{
	return [self indexPathOfCellModel:cellModel];
}
- (NSIndexSet *)indexSetWithSectionModel:(HVTableViewSectionModel *)sectionModel{
	return [self indexSetOfSectionModel:sectionModel];
}
- (HVTableViewSectionModel *)addListedCellModel:(HVTableViewCellModel *)cellModel{
	[self addCellModel:cellModel];
	return [self.sectionModels lastObject];
}
- (void)removeAutoIndexedCellModel:(HVTableViewCellModel *)cellModel{
	[self removeCellModel:cellModel];
}
- (NSArray *)cellModelsOfSelected:(BOOL)selected{
	NSArray *allCells = [self allCellModels];
	NSMutableArray *cells = [[NSMutableArray alloc] initWithCapacity:allCells.count];
	for (HVTableViewCellModel *cm1 in allCells) {
		if([cm1 isKindOfClass:[HVTableViewCellModel class]]){
			HVTableViewCellModel *cm = (HVTableViewCellModel *)cm1;
			if (cm.selected==selected) {
				[cells addObject:cm];
			}
		}
	}
	return cells;
}
@end
