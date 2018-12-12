//
//  TestViewController.swift
//  Catstagram-Starter
//
//  Created by Luke Parham on 2/19/17.
//  Copyright © 2017 Luke Parham. All rights reserved.
//

import Foundation

class TestViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "就一个按钮"
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 200))
        button.setTitle("点击检测", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(TestViewController.buttonPressed), for: .touchUpInside)
        button.backgroundColor = .red
        view.addSubview(button)
        
        
    }
    
    
    
    @objc func buttonPressed() {
        let vc = CatFeedViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
