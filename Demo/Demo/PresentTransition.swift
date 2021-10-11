//
//  PresentTransition.swift
//  CustomPresentTransition
//
//  Created by xiaoyou on 2021/9/8.
//

import UIKit

let HYScreenWidth = UIScreen.main.bounds.size.width
let HYScreenHeight = UIScreen.main.bounds.size.height
public struct TransitionConfig {
    var duration = 0.35
    var animation: TransitionAnimation = .fromBottom
}

public  enum TransitionAnimation {
    case scale
    case fromLeft
    case fromTop
    case fromRight
    case fromBottom
}

public enum TransitionOperation {
    case present
    case dismiss
}

class PresentTransition: UIPresentationController {
//    override var shouldRemovePresentersView: Bool{
//        return true
//    }
    private var config = TransitionConfig()
    private var transitionOperation: TransitionOperation = .present
    private lazy var bgView: UIView = {
        let o = UIView(frame: containerView?.bounds ?? CGRect.zero)
        o.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapBGAction))
        tap.delegate = self
        o.addGestureRecognizer(tap)
        return o }()
    // 核心方法
    public static func presentWithAnimate(fromVC: UIViewController, toVC: UIViewController, duration: TimeInterval = 0.35, animation: TransitionAnimation = .fromBottom){
        let o = PresentTransition.init(presentedViewController: toVC, presenting: fromVC)
        o.config.duration = duration
        o.config.animation = animation
        toVC.transitioningDelegate = o
        fromVC.present(toVC, animated: true) { }
    }
    @objc func tapBGAction() {
        guard presentedViewController.transitionBGViewEnable else { return }
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
//MARK: - delegate
extension PresentTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch transitionOperation{
        case .present:
            presentTransition(transitionContext: transitionContext)
        case .dismiss:
            dismissTransition(transitionContext: transitionContext)
        }
    }
}
extension PresentTransition: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
}

//MARK: - override
extension PresentTransition {
    override var frameOfPresentedViewInContainerView: CGRect{
        return presentedViewController.transitionPresentedViewFrame
    }
    override func presentationTransitionWillBegin() {
        transitionOperation = .present
        containerView?.addSubview(bgView)
        bgView.addSubview(presentedViewController.view)
        presentingViewController.beginAppearanceTransition(false, animated: true)
        presentedViewController.beginAppearanceTransition(true, animated: true)
    }
    override func presentationTransitionDidEnd(_ completed: Bool) {
        presentedView?.frame = frameOfPresentedViewInContainerView
        presentingViewController.endAppearanceTransition()
        presentedViewController.endAppearanceTransition()
    }
    override func dismissalTransitionWillBegin() {
        transitionOperation = .dismiss
        presentingViewController.beginAppearanceTransition(true, animated: true)
        presentedViewController.beginAppearanceTransition(false, animated: true)
    }
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        bgView.removeFromSuperview()
        presentingViewController.endAppearanceTransition()
        presentedViewController.endAppearanceTransition()
    }
}

//MARK: - animationed
extension PresentTransition {
    
    private func presentTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toView = transitionContext.viewController(forKey: .to)?.view,
              let fromView = transitionContext.viewController(forKey: .from)?.view else { return }
        
        switch config.animation {
        case .scale:
            scalePresent(fromView: fromView,
                         toView: toView,
                         transitionContext: transitionContext)
        case .fromLeft:
            fromLeftPresent(fromView: fromView,
                            toView: toView,
                            transitionContext: transitionContext)
        case .fromTop:
            fromTopPresent(fromView: fromView,
                             toView: toView,
                             transitionContext: transitionContext)
        case .fromRight:
            fromRightPresent(fromView: fromView,
                             toView: toView,
                             transitionContext: transitionContext)
        case .fromBottom:
            fromBottomPresent(fromView: fromView,
                              toView: toView,
                              transitionContext: transitionContext)
        }
    }
    
    private func dismissTransition(transitionContext: UIViewControllerContextTransitioning) {

        guard let toView = transitionContext.viewController(forKey: .to)?.view,
              let fromView = transitionContext.viewController(forKey: .from)?.view else { return }
        
        switch config.animation {
        case .scale:
            scaleDismiss(fromView: fromView,
                         toView: toView,
                         transitionContext: transitionContext)
        case .fromLeft:
            fromLeftDismiss(fromView: fromView,
                            toView: toView,
                            transitionContext: transitionContext)
        case .fromTop:
            fromTopDismiss(fromView: fromView,
                           toView: toView,
                           transitionContext: transitionContext)
        case .fromRight:
            fromRightDismiss(fromView: fromView,
                             toView: toView,
                             transitionContext: transitionContext)
            
        case .fromBottom:
            fromBottomDismiss(fromView: fromView,
                              toView: toView,
                              transitionContext: transitionContext)
        }
        
        
    }
    
    private func scalePresent(fromView: UIView,
                              toView: UIView,
                              transitionContext: UIViewControllerContextTransitioning)
    {
        toView.frame = frameOfPresentedViewInContainerView
        toView.alpha = 0.0
        toView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: config.duration, animations: {
            toView.alpha = 1.0
            toView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    
    private func scaleDismiss(fromView: UIView,
                              toView: UIView,
                              transitionContext: UIViewControllerContextTransitioning)
    {
        
        UIView.animate(withDuration: config.duration, animations: {
            fromView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            fromView.alpha = 0
        }) {(_) in
            transitionContext.completeTransition(true)
        }
    }
    
    private func fromLeftPresent(fromView: UIView,
                                 toView: UIView,
                                 transitionContext: UIViewControllerContextTransitioning)
    {
        let rect = frameOfPresentedViewInContainerView
        let size = rect.size
        toView.frame = CGRect(x: -(size.width), y: rect.origin.y, width: size.width, height: size.height)
        UIView.animate(withDuration: config.duration, animations: {
            toView.frame = rect
        }) { (_) in
            transitionContext.completeTransition(true)
        }
        
    }
    
    private func fromLeftDismiss(fromView: UIView,
                                 toView: UIView,
                                 transitionContext: UIViewControllerContextTransitioning)
    {
        
        UIView.animate(withDuration: config.duration, animations: {
            fromView.transform = CGAffineTransform(translationX: -HYScreenWidth, y: 0)
            fromView.alpha = 0
        }) {(_) in
            transitionContext.completeTransition(true)
        }
    }
    
    private func fromTopPresent(fromView: UIView,
                                toView: UIView,
                                transitionContext: UIViewControllerContextTransitioning)
    {
        let rect = frameOfPresentedViewInContainerView
        let size = rect.size
        toView.frame = CGRect(x: rect.origin.x, y: -(size.height), width: size.width, height: size.height)
        UIView.animate(withDuration: config.duration, animations: {
            toView.frame = rect
        }) { (_) in
            transitionContext.completeTransition(true)
        }
        
    }
    
    private func fromTopDismiss(fromView: UIView,
                                toView: UIView,
                                transitionContext: UIViewControllerContextTransitioning)
    {
        UIView.animate(withDuration: config.duration, animations: {
            fromView.transform = CGAffineTransform(translationX: 0, y: -toView.frame.size.height)
            fromView.alpha = 0
        }) {(_) in
            transitionContext.completeTransition(true)
        }
    }
    
    private func fromRightPresent(fromView: UIView,
                                  toView: UIView,
                                  transitionContext: UIViewControllerContextTransitioning)
    {
        let rect = frameOfPresentedViewInContainerView
        let size = rect.size
        toView.frame = CGRect(x: HYScreenWidth, y: rect.origin.y, width: size.width, height: size.height)
        UIView.animate(withDuration: config.duration, animations: {
            toView.frame = rect
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    
    private func fromRightDismiss(fromView: UIView,
                                  toView: UIView,
                                  transitionContext: UIViewControllerContextTransitioning)
    {
        
        UIView.animate(withDuration: config.duration, animations: {
            fromView.transform = CGAffineTransform(translationX: HYScreenWidth, y: 0)
            fromView.alpha = 0
        }) {(_) in
            transitionContext.completeTransition(true)
        }
    }
    
    private func fromBottomPresent(fromView: UIView,
                                   toView: UIView,
                                   transitionContext: UIViewControllerContextTransitioning)
    {
        let rect = frameOfPresentedViewInContainerView
        let size = rect.size

        toView.frame = CGRect(x: rect.origin.x, y: HYScreenHeight, width: size.width, height: size.height)
        UIView.animate(withDuration: config.duration, animations: {
            toView.frame = rect
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    
    private func fromBottomDismiss(fromView: UIView,
                                   toView: UIView,
                                   transitionContext: UIViewControllerContextTransitioning)
    {
        
        UIView.animate(withDuration: config.duration, animations: {
            fromView.transform = CGAffineTransform(translationX: 0, y: HYScreenHeight)
            fromView.alpha = 0
        }) {(_) in
            transitionContext.completeTransition(true)
        }
    }
}
/// 手势处理
extension PresentTransition: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == bgView
    }
}

extension UIViewController {
    /// 自定义转场是显示的frame， 搭配presentTransition(::)使用
    public var transitionPresentedViewFrame: CGRect {
        set {
            objc_setAssociatedObject(self, &transitionPresentedViewFrameStr, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &transitionPresentedViewFrameStr) as? CGRect ?? UIScreen.main.bounds
        }
    }
    
    /// 点击背景 dismiss VC
    public var transitionBGViewEnable: Bool {
        set {
            objc_setAssociatedObject(self, &transitionEnableStr, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return objc_getAssociatedObject(self, &transitionEnableStr) as? Bool ?? true
        }
    }

    /// 自定义 模态转场 须用此方法
    func presentTransition(_ toVC: UIViewController, animation: TransitionAnimation = .fromBottom, vcFrame: CGRect? = nil) {
        toVC.modalPresentationStyle = .custom
        if let frame = vcFrame {
            toVC.transitionPresentedViewFrame = frame
        }
        PresentTransition.presentWithAnimate(fromVC: self, toVC: toVC, animation: animation)
    }
    /// oc 
    @objc func oc_presentTransition(toVC: UIViewController, vcFrame: CGRect) {
        // , animation: TransitionAnimation = .fromBottom, vcFrame: CGRect? = nil
        toVC.modalPresentationStyle = .custom
        toVC.transitionPresentedViewFrame = vcFrame
        PresentTransition.presentWithAnimate(fromVC: self, toVC: toVC, animation: .fromBottom)
    }
}

var transitionPresentedViewFrameStr = "HYTransitionPresentedViewFrameStr"
var transitionEnableStr = "HYTransitionBGViewEnableStr"

