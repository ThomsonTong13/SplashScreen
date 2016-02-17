//
//  LaunchAnimationView.m
//  SplashScreen
//
//  Created by Thomson on 16/2/16.
//  Copyright © 2016年 Thomson. All rights reserved.
//

#import "LaunchAnimationView.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LaunchAnimationView ()

@property (nonatomic, strong) UIImageView *foregroundImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIImageView *tipsImageView;

@end

@implementation LaunchAnimationView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self)
    {
        [self configViews];

        [self setupLayoutConstraints];

        [self addAnimations];
    }

    return self;
}

#pragma mark - Private Methods

- (void)configViews
{
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.foregroundImageView];
    [self addSubview:self.logoImageView];
    [self addSubview:self.tipsImageView];

    self.backgroundColor = [UIColor clearColor];
}

- (void)setupLayoutConstraints
{
    @weakify(self);
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        @strongify(self);
        make.edges.equalTo(self);
    }];

    [self.foregroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        @strongify(self);
        make.edges.equalTo(self);
    }];

    CGFloat coefficient = [UIScreen mainScreen].bounds.size.height / 667.0;

    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        @strongify(self);
        make.centerX.equalTo(self.mas_centerX).with.offset(-1);
        make.top.equalTo(@(156.0 * coefficient));
    }];

    [self.tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        @strongify(self);
        make.centerX.equalTo(self.mas_centerX).with.offset(-2);
        make.bottom.equalTo(@(-37.0 * coefficient));
    }];
}

- (void)addAnimations
{
    @weakify(self);
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{

                         @strongify(self);
                         self.foregroundImageView.alpha = 0;
                     }
                     completion:^(BOOL finished) {

                         @strongify(self);
                         [self.foregroundImageView removeFromSuperview];
                     }];

    [UIView animateWithDuration:2
                          delay:.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{

                         @strongify(self);
                         self.tipsImageView.alpha = .8;
                     }
                     completion:^(BOOL finished) {
                     }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 3.65;

        NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:0];

        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.01, 1.01, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.02, 1.02, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.03, 1.03, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.04, 1.04, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.055, 1.055, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.06, 1.06, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.065, 1.065, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.07, 1.07, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.07, 1.07, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.07, 1.07, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.07, 1.07, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.07, 1.07, 1.0)]];

        @strongify(self);
        animation.values = values;
        [self.backgroundImageView.layer addAnimation:animation forKey:nil];
    });

    [UIView animateWithDuration:.8
                          delay:3.2
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{

                         @strongify(self);
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {

                         @strongify(self);
                         [self.backgroundImageView removeFromSuperview];
                         [self.logoImageView removeFromSuperview];
                         [self.tipsImageView removeFromSuperview];
                         [self removeFromSuperview];
                     }];
}

#pragma mark - Getters & Setters

- (UIImageView *)foregroundImageView
{
    if (!_foregroundImageView)
    {
        _foregroundImageView = [UIImageView new];
        _foregroundImageView.backgroundColor = [UIColor clearColor];
        _foregroundImageView.contentMode = UIViewContentModeCenter;
        _foregroundImageView.image = [UIImage imageNamed:@"launch_foreground"];
    }

    return _foregroundImageView;
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView)
    {
        _backgroundImageView = [UIImageView new];
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        _backgroundImageView.contentMode = UIViewContentModeCenter;
        _backgroundImageView.image = [UIImage imageNamed:@"launch_background"];
    }

    return _backgroundImageView;
}

- (UIImageView *)logoImageView
{
    if (!_logoImageView)
    {
        _logoImageView = [UIImageView new];
        _logoImageView.backgroundColor = [UIColor clearColor];
        _logoImageView.image = [UIImage imageNamed:@"launch_logo"];
    }

    return _logoImageView;
}

- (UIImageView *)tipsImageView
{
    if (!_tipsImageView)
    {
        _tipsImageView = [UIImageView new];
        _tipsImageView.backgroundColor = [UIColor clearColor];
        _tipsImageView.alpha = .6;
        _tipsImageView.image = [UIImage imageNamed:@"launch_tips"];
    }

    return _tipsImageView;
}

@end
