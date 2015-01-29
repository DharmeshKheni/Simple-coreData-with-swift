import UIKit
import CoreData

class IteamViewController: UIViewController {

    @IBOutlet var textFieldIteam: UITextField!
    @IBOutlet var textFieldQuantity: UITextField!
    @IBOutlet var textFieldMoreInfo: UITextField!
    
    var iteam : String = ""
    var quantity : String = ""
    var info : String = ""
    
    var existingIteam : NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (existingIteam != nil){
            
            textFieldIteam.text = iteam
            textFieldQuantity.text = quantity
            textFieldMoreInfo.text = info
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func saveTapped(sender: AnyObject) {
        

        
        //Reference to our app Delegate
        
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        //Reference to mof
        
        let contex : NSManagedObjectContext = appDel.managedObjectContext!
        let en = NSEntityDescription.entityForName("List", inManagedObjectContext: contex)
        
        //If Iteam Exits
        
        if (existingIteam != nil){
            
            existingIteam.setValue(textFieldIteam.text as String, forKey: "iteam")
            existingIteam.setValue(textFieldQuantity.text as String, forKey: "quantity")
            existingIteam.setValue(textFieldMoreInfo.text as String, forKey: "info")
        }else{
            
            //Create Instance of pur data model and initialise
            
            var newIteam = Model(entity: en!, insertIntoManagedObjectContext: contex)
            
            //Map Our Property
            
            newIteam.iteam = textFieldIteam.text
            newIteam.quantity = textFieldQuantity.text
            newIteam.info = textFieldMoreInfo.text
            
            
        }
        
        //Save Our Contex
        
        contex.save(nil)
        
        //Navigate Back to our root viewController
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    @IBAction func cancleTapped(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
