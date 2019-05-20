
import UIKit

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
        
        var loopImage = [waterImageView, water2, water3, water4, water5, water6, water7]
        
        
        switch sender.state {
        case .began, .changed:
           moveViewWithPan(view: cupView, sender: sender)
            
        case .ended:
            if cupView.frame.intersects(manImageView.frame){
                deleteView(view: cupView)
                cupEmptyImagerView.isHidden = false
                waterImageView.isHidden = false
                
                for _ in loopImage{
                    
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    self.waterImageView.isHidden = true
                    self.water2.isHidden = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        self.water2.isHidden = true
                        self.water3.isHidden = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                            self.water3.isHidden = true
                            self.water4.isHidden = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                                self.water4.isHidden = true
                                self.water5.isHidden = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                                    self.water5.isHidden = true
                                    self.water6.isHidden = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                                        self.water6.isHidden = true
                                        self.water7.isHidden = false
                                        self.manShockImageView.isHidden = false
                                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                                            self.water7.isHidden = true
                                            self.manImageView.isHidden = true
                                            self.cupEmptyImagerView.isHidden = true
                                            self.manShockImageView.isHidden = true
                                            self.manVomitImageView.isHidden = false
                                            
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
    

}

