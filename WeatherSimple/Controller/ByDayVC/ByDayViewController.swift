//
//  ByDayViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import UIKit
import Charts

enum CardState {
    case expanded
    case collapsed
}
class ByDayViewController: UIViewController {
   
    @IBOutlet weak var ContainView: UIView!
    
    var cardViewController:CardViewViewController!
    var visualEffectView:UIVisualEffectView!
    
    let cardHeight:CGFloat = 450
    let cardHandleAreaHeight:CGFloat = 64
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    var safe:CGFloat = 0
    
    var bydayData:Next5day?
    var barchart:BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
        barchart = BarChartView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.width-70))
        view.addSubview(barchart!)
        fetchData(locationId: DataManager.shared.newLocationkey)
    }
    
    func fetchData(locationId: String){
        APICaller.shared.getNext5DayWeather(locationid: locationId) { (result) in
            DataManager.shared.next5dData = result
            self.bydayData = result
            self.drawBar(next5daydata: result)
            self.cardViewController.next5dayData = result
            self.cardViewController.changeToDay()
        }
    }
    
    func drawBar(next5daydata: Next5day){
       
        var entry = [BarChartDataEntry]()
        for x in 0..<(bydayData?.DailyForecasts!.count)! {
            let data = bydayData?.DailyForecasts
            let value = data![x].Temperature?.Maximum?.Value
            entry.append(BarChartDataEntry(x: Double(x), y: Double(value ?? 0)))
        }
        var entry2 = [BarChartDataEntry]()
        for x in 0..<(bydayData?.DailyForecasts!.count)!{
            let data = bydayData?.DailyForecasts
            let value = data![x].Temperature?.Minimum?.Value
            entry2.append(BarChartDataEntry(x: Double(x), y: Double(value!)))
        }
        
        let set = BarChartDataSet(entries: entry, label: "Maximum ")
        set.colors = [UIColor.red]
        let set2 = BarChartDataSet(entries: entry2, label: "Minimum")
        set2.colors = [UIColor.blue]
        
        let data = BarChartData(dataSets: [set, set2])
        

        let groupSpace = 0.54
        let barSpace = 0.03
        let barWidth = 0.2
        data.barWidth = barWidth
        
        barchart.xAxis.axisMinimum = Double(0)
        barchart.xAxis.axisMaximum = Double(0) + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * 5
        data.groupBars(fromX: Double(0), groupSpace: groupSpace, barSpace: barSpace)
        
        barchart.data = data
        
        let x_Axis = barchart.xAxis
        x_Axis.centerAxisLabelsEnabled = true
        x_Axis.granularity = 1
        barchart.xAxis.labelPosition = .top
        
        let columnTitles = ["Next 1", "Next 2", "Next 3", "Next 4", "Next 5"]
        let formatter = IndexAxisValueFormatter(values: columnTitles)
        barchart.xAxis.valueFormatter = formatter
        
        barchart.animate(yAxisDuration: 0.8, easingOption: .easeInCubic)
        
    }
    
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = CGRect(x: 0, y: 0, width: view.bounds.height, height: view.bounds.height)
        self.view.addSubview(visualEffectView)
        
        cardViewController = CardViewViewController()
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        
        let value = view.frame.height - (tabBarController?.tabBar.frame.origin.y)! //chie cao cua tabbar o safe area
        safe = (tabBarController?.tabBar.frame.height)! - value
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight - value, width: self.view.bounds.width, height: cardHeight)
        
        cardViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        
        cardViewController.handlerView.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handlerView.addGestureRecognizer(panGestureRecognizer)
        
        
    }

    @objc func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransition(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.cardViewController.handlerView)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
        
    }
    
    func animateTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight - (self.tabBarController?.tabBar.frame.height)!
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.cardViewController.view.layer.cornerRadius = 12
                case .collapsed:
                    self.cardViewController.view.layer.cornerRadius = 0
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
            
        }
    }
    
    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransition(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
}


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    enum CardState {
//        case expanded
//        case collapsed
//    }
//    var cardViewController:CardViewViewController!
//    var visualEffectView: UIVisualEffectView! // hiệu ứng làm mờ
//    //
//
//    let cardHeight:CGFloat = 600 // Chiều cao của card
//    let cardHandleAreaHeight:CGFloat = 128 // chiều cao của vùng điểu khiển
//
//    var cardVisible = false // card cos hiển thị ko
//    var nextState:CardState{
//        return cardVisible ? .expanded : .collapsed
//    }
//    var runningAnimations = [UIViewPropertyAnimator]()
//    var animationProgressWhenInterrupted:CGFloat = 0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupCard()
//    }
//
//    func setupCard() {
//        visualEffectView = UIVisualEffectView()
//        visualEffectView.frame = CGRect(x: 0, y: 0, width: view.frame.width + 100, height: view.frame.height)
//        self.view.addSubview(visualEffectView)
//
//        cardViewController = CardViewViewController()
//        self.addChild(cardViewController)
//        self.view.addSubview(cardViewController.view)
//
//        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight - 50, width: self.view.bounds.width, height: cardHeight)
//
//        cardViewController.view.clipsToBounds = true
//
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognzier:)))
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
//
//        cardViewController.handlerView.addGestureRecognizer(tapGestureRecognizer)
//        cardViewController.handlerView.addGestureRecognizer(panGestureRecognizer)
//    }
//
//    @objc func handleCardTap(recognzier:UITapGestureRecognizer) {
//        switch recognzier.state {
//        case .ended:
//            animateTransiton(state: nextState, duration: 0.9)
//        default:
//            break
//        }
//    }
//    @objc
//    func handleCardPan (recognizer:UIPanGestureRecognizer) {
//        switch recognizer.state {
//        case .began:
//            startInteractiveTransition(state: nextState, duration: 0.9)
//        case .changed:
//            let translation = recognizer.translation(in: self.cardViewController.handlerView)
//            var fractionComplete = translation.y / cardHeight
//            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
//            updateInteractiveTransition(fractionCompleted: fractionComplete)
//        case .ended:
//            continueInteractiveTransition()
//        default:
//            break
//        }
//
//    }
//
//
//
//    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
//        if runningAnimations.isEmpty {
//            animateTransiton(state: state, duration: duration)
//        }
//        for animator in runningAnimations {
//            animator.pauseAnimation()
//            animationProgressWhenInterrupted = animator.fractionComplete
//            //fractionCompletion: laf % hoan thanh cua animation
//        }
//    }
//
//    func updateInteractiveTransition(fractionCompleted:CGFloat) {
//        for animator in runningAnimations {
//            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
//            //Tiep tục cái đang dở, ở đây fractionCompletion ta truyền vào
//        }
//    }
//
//    func continueInteractiveTransition (){
//        for animator in runningAnimations {
//            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
//            //0 nghĩa là chỉ dùng thời gian còn lại lúc đầu đã set, ở đây là 0.9
//        }
//    }
//
//    func animateTransiton (state:CardState, duration:TimeInterval) {
//        if runningAnimations.isEmpty {
//            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
//                switch state {
//                case .expanded:
//                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
//                case .collapsed:
//                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
//                }
//            }
//
//            frameAnimator.addCompletion { _ in
//                self.cardVisible = !self.cardVisible
//                self.runningAnimations.removeAll()
//            }
//
//            frameAnimator.startAnimation()
//            runningAnimations.append(frameAnimator)
//
//
//            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
//                switch state {
//                case .expanded:
//                    self.cardViewController.view.layer.cornerRadius = 12
//                case .collapsed:
//                    self.cardViewController.view.layer.cornerRadius = 0
//                }
//            }
//
//            cornerRadiusAnimator.startAnimation()
//            runningAnimations.append(cornerRadiusAnimator)
//
//            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
//                switch state {
//                case .expanded:
//                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
//                case .collapsed:
//                    self.visualEffectView.effect = nil
//                }
//            }
//
//            blurAnimator.startAnimation()
//            runningAnimations.append(blurAnimator)
//
//        }
//    }
//
//
//}
//
