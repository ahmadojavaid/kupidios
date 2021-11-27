//
//  KTCenterFlowLayout.m
//
//  Created by APPLE on 23/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//
#import "KTCenterFlowLayout.h"

@interface KTCenterFlowLayout ()
@property (nonatomic) NSMutableDictionary *attrCache;
@end

@implementation KTCenterFlowLayout

- (void)prepareLayout
{
    self.attrCache = [NSMutableDictionary new];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *updatedAttributes = [NSMutableArray new];

    NSInteger sections = [self.collectionView numberOfSections];
    NSInteger s = 0;
    while (s < sections)
    {
        NSInteger rows = [self.collectionView numberOfItemsInSection:s];
        NSInteger r = 0;
        while (r < rows)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:r inSection:s];

            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            if (attrs && CGRectIntersectsRect(attrs.frame, rect))
            {
                [updatedAttributes addObject:attrs];
            }

            UICollectionViewLayoutAttributes *headerAttrs =  [super layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                                   atIndexPath:indexPath];

            if (headerAttrs && CGRectIntersectsRect(headerAttrs.frame, rect))
            {
                [updatedAttributes addObject:headerAttrs];
            }

            UICollectionViewLayoutAttributes *footerAttrs =  [super layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                                   atIndexPath:indexPath];

            if (footerAttrs && CGRectIntersectsRect(footerAttrs.frame, rect))
            {
                [updatedAttributes addObject:footerAttrs];
            }

            r++;
        }
        s++;
    }

    return updatedAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.attrCache[indexPath])
    {
        return self.attrCache[indexPath];
    }

    NSMutableArray *rowBuddies = [NSMutableArray new];

    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.bounds) -
        self.collectionView.contentInset.left -
        self.collectionView.contentInset.right;

    CGRect rowTestFrame = [super layoutAttributesForItemAtIndexPath:indexPath].frame;
    rowTestFrame.origin.x = 0;
    rowTestFrame.size.width = collectionViewWidth;

    NSInteger totalRows = [self.collectionView numberOfItemsInSection:indexPath.section];
    NSInteger rowStartIDX = indexPath.row;
    while (true)
    {
        NSInteger prevIDX = rowStartIDX - 1;

        if (prevIDX < 0)
        {
            break;
        }

        NSIndexPath *prevPath = [NSIndexPath indexPathForRow:prevIDX inSection:indexPath.section];
        CGRect prevFrame = [super layoutAttributesForItemAtIndexPath:prevPath].frame;

        
        if (CGRectIntersectsRect(prevFrame, rowTestFrame))
            rowStartIDX = prevIDX;
        else
            
            break;
    }

    NSInteger buddyIDX = rowStartIDX;
    while (true)
    {
        if (buddyIDX > (totalRows-1))
        {
            break;
        }

        NSIndexPath *buddyPath = [NSIndexPath indexPathForRow:buddyIDX inSection:indexPath.section];

        UICollectionViewLayoutAttributes *buddyAttributes = [super layoutAttributesForItemAtIndexPath:buddyPath];

        if (CGRectIntersectsRect(buddyAttributes.frame, rowTestFrame))
        {
            [rowBuddies addObject:[buddyAttributes copy]];
            buddyIDX++;
        }
        else
        {
           break;
        }
    }

    id <UICollectionViewDelegateFlowLayout> flowDelegate = (id<UICollectionViewDelegateFlowLayout>) [[self collectionView] delegate];
    BOOL delegateSupportsInteritemSpacing = [flowDelegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)];

    CGFloat interitemSpacing = [self minimumInteritemSpacing];

    if (delegateSupportsInteritemSpacing && rowBuddies.count > 0)
    {
        interitemSpacing = [flowDelegate collectionView:self.collectionView
                                                 layout:self
               minimumInteritemSpacingForSectionAtIndex:indexPath.section];
    }

    CGFloat aggregateInteritemSpacing = interitemSpacing * (rowBuddies.count -1);

    CGFloat aggregateItemWidths = 0.f;
    for (UICollectionViewLayoutAttributes *itemAttributes in rowBuddies)
        aggregateItemWidths += CGRectGetWidth(itemAttributes.frame);

    CGFloat alignmentWidth = aggregateItemWidths + aggregateInteritemSpacing;
    CGFloat alignmentXOffset = (collectionViewWidth - alignmentWidth) / 2.f;

    CGRect previousFrame = CGRectZero;
    for (UICollectionViewLayoutAttributes *itemAttributes in rowBuddies)
    {
        CGRect itemFrame = itemAttributes.frame;

        if (CGRectEqualToRect(previousFrame, CGRectZero))
            itemFrame.origin.x = alignmentXOffset;
        else
            itemFrame.origin.x = CGRectGetMaxX(previousFrame) + interitemSpacing;

        itemAttributes.frame = itemFrame;
        previousFrame = itemFrame;

        self.attrCache[itemAttributes.indexPath] = itemAttributes;
    }

    return self.attrCache[indexPath];
}

@end
