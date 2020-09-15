//
//  InitialViewController.swift
//  ios
//
//  Created by 태로고침 on 2020/08/30.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit
import FirebaseStorage

class InitialViewController: BaseViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var uiStartBtn: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var imgvAvatar: UIImageView!
    
    @IBAction func pressedPresentLoginViewController(_ sender: UIButton) {
        let navigationViewController = self.navigationController
        navigationViewController?.pushViewController(CertificationViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        multipleLineOfTextLabel(infoLabel)
        createDesign()

        self.uiStartBtn.layer.cornerRadius = 7
        print("ISMEMBER: ",ISMEMBER)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func createDesign(){
        imgvAvatar.layer.cornerRadius = 50
        createPulse()
    }
    
    // 파동 만드는 애니메이션 1
    var pulseLayers = [CAShapeLayer]()
    func createPulse() {
        for _ in 0...2 {
            let circularPath = UIBezierPath(arcCenter: .zero, radius: UIScreen.main.bounds.size.width/5.0, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
            let pulseLayer = CAShapeLayer()
            pulseLayer.path = circularPath.cgPath
            pulseLayer.lineWidth = 0
            pulseLayer.fillColor = UIColor.orange.cgColor
            pulseLayer.lineCap = CAShapeLayerLineCap.round
            pulseLayer.position = CGPoint(x: imgvAvatar.frame.size.width/2.0, y: imgvAvatar.frame.size.width/2.0)
            imgvAvatar.layer.addSublayer(pulseLayer)
            pulseLayers.append(pulseLayer)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.animatePulse(index: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.animatePulse(index: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.animatePulse(index: 2)
                }
            }
        }
    }
    
    // 파동 만드는 애니메이션 2
    func animatePulse(index: Int) {
        pulseLayers[index].strokeColor = UIColor.black.cgColor
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 2.0
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 0.9
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(scaleAnimation, forKey: "scale")
        
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.duration = 2.0
        opacityAnimation.fromValue = 0.9
        opacityAnimation.toValue = 0.0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(opacityAnimation, forKey: "opacity")
    }
    
    
}
