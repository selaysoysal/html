//
//  ArticleViewController.swift
//  wired.com
//
//  Created by Selay Soysal on 02/03/2017.
//  Copyright © 2017 Selay Soysal. All rights reserved.
//

import UIKit
import Kanna

class ArticleViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button: UIButton!
    var passedURL: String?
    var passedTitle: String?
    var article: String = ""
    var Html: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getArticles()
        parse()
        self.navigationItem.title = passedTitle
       
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getArticles(){
        
        let url = NSURL(string: passedURL!)
        guard let myURL = url else {
            print("Error: \(url) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL as URL, encoding: .ascii)
            //print("HTML : \(myHTMLString)")
            Html = myHTMLString
        } catch let error {
            print("Error: \(error)")
        }
    }
   
    func parse(){
        if let doc = Kanna.HTML(html: Html!, encoding: .utf8) {
            for link in doc.xpath("/html/body/main/div/section/article/p") {
              //  print("SELAY: \(link.text! as String)")
                article = article+link.text!
            }
        }
        textView.text = article
    }
    
    @IBAction func orderWords(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "WordViewController") as! WordViewController
        myVC.article = article
        navigationController?.pushViewController(myVC, animated: true)
    }
      
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension Dictionary {
    func mergedWith(otherDictionary: [Key: Value]) -> [Key: Value] {
        var mergedDict: [Key: Value] = [:]
        [self, otherDictionary].forEach { dict in
            for (key, value) in dict {
                mergedDict[key] = value
            }
        }
        return mergedDict
    }
}
