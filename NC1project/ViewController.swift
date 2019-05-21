
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var cupImageView: UIImageView!
    @IBOutlet weak var manImageView: UIImageView!
    @IBOutlet weak var manShockImageView: UIImageView!
    @IBOutlet weak var manVomitImageView: UIImageView!
    
    @IBOutlet weak var cupEmptyImagerView: UIImageView!
    @IBOutlet weak var waterImageView: UIImageView!

    @IBOutlet weak var water2: UIImageView!
    @IBOutlet weak var water3: UIImageView!
    @IBOutlet weak var water4: UIImageView!
    @IBOutlet weak var water5: UIImageView!
    @IBOutlet weak var water6: UIImageView!
    @IBOutlet weak var water7: UIImageView!
    
    var cupViewOrigin: CGPoint!
    
    var audio : AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cupEmptyImagerView.isHidden = true
        waterImageView.isHidden = true
        manShockImageView.isHidden = true
        manVomitImageView.isHidden = true

        water2.isHidden = true
        water3.isHidden = true
        water4.isHidden = true
        water5.isHidden = true
        water6.isHidden = true
        water7.isHidden = true
 
        
        addPanGesture(view: cupImageView)
        cupViewOrigin = cupImageView.frame.origin
        view.bringSubviewToFront(cupImageView)
 

       
    }
    
    func addPanGesture(view : UIView){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer){
        let cupView = sender.view!
        
        switch sender.state {
        case .began, .changed:
           moveViewWithPan(view: cupView, sender: sender)
            
        case .ended:
            if cupView.frame.intersects(manImageView.frame){
                deleteView(view: cupView)
                cupEmptyImagerView.isHidden = false
                waterImageView.isHidden = false
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    self.playAudioSlurp()
                    
                    self.picAnimate(view: self.waterImageView, viewPlusOne: self.water2)
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        self.picAnimate(view: self.water2, viewPlusOne: self.water3)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                            self.picAnimate(view: self.water3, viewPlusOne: self.water4)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                                self.picAnimate(view: self.water4, viewPlusOne: self.water5)
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                                    self.picAnimate(view: self.water5, viewPlusOne: self.water6)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                                          self.manShockImageView.isHidden = false
                                            self.playAudioshock()
                                        self.picAnimate(view: self.water6, viewPlusOne: self.water7)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                                            self.water7.isHidden = true
                                            self.manImageView.isHidden = true
                                            self.cupEmptyImagerView.isHidden = true
                                            self.manShockImageView.isHidden = true
                                            self.manVomitImageView.isHidden = false
                                            self.playAudioUee()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    }
            }else{
               returnView(view: cupView)
            }
            
        default:
            break
        }
    }
    

    
    func moveViewWithPan(view: UIView, sender : UIPanGestureRecognizer){
        let translation = sender.translation(in: view)
        
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    func returnView(view: UIView){
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin = self.cupViewOrigin
        })
    }
    
    func deleteView(view : UIView){
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.0
        })
    }
    
    func picAnimate(view : UIView, viewPlusOne : UIView){
            view.isHidden = true
            viewPlusOne.isHidden = false
    }
    
    
    func playAudioSlurp(){
        do{
            let audioPath = Bundle.main.path(forResource: "Slurp", ofType: "m4a")
            try audio = AVAudioPlayer (contentsOf: NSURL (fileURLWithPath: audioPath!)as URL)
            audio.play()
        }catch{}
    }
    
    func playAudioUee(){
        do{
            let audioPath = Bundle.main.path(forResource: "vomiting", ofType: "wav")
            try audio = AVAudioPlayer (contentsOf: NSURL (fileURLWithPath: audioPath!)as URL)
            audio.play()
        }catch{}
    }
    
    func playAudioshock(){
        do{
            let audioPath = Bundle.main.path(forResource: "Shocked", ofType: "mp3")
            try audio = AVAudioPlayer (contentsOf: NSURL (fileURLWithPath: audioPath!)as URL)
            audio.play()
        }catch{}
    }

}

