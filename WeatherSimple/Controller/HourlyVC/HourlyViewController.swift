//
//  HourlyViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import UIKit

class HourlyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var arrdata = [Next12]()
    
    
    
    var cardViewController:CardViewForHourViewController!
    var visualEffectView:UIVisualEffectView!
    
    let cardHeight:CGFloat = 600
    let cardHandleAreaHeight:CGFloat = 64
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    var safe:CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
        configTableview()
        fetchdata()
    }
    func fetchdata(){
        
        self.arrdata = DataManager.shared.next12hData
        tableView.reloadData()
    }
    
    func configTableview(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HourTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = CGRect(x: 0, y: 0, width: view.bounds.height, height: view.bounds.height - 50)
        self.view.addSubview(visualEffectView)
        
        cardViewController = CardViewForHourViewController()
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


    
    
extension HourlyViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HourTableViewCell
        
        let data = arrdata[indexPath.row]
        
        let dateString = data.DateTime
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatt.date(from: dateString!)
        let stringformat = DateFormatter()
        stringformat.dateFormat = "HH:mm"
        let time = stringformat.string(from: date!)
        
        let feel = String((data.RealFeelTemperature?.Value ?? 0))
        let icon = String(data.WeatherIcon ?? 0)
        let tem = String((data.Temperature?.Value ?? 0))
        cell.configure(time: time, feel: feel, icon: icon, tem: tem)
        return cell
    }
    
    
}
