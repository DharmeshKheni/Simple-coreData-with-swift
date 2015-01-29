
import UIKit
import CoreData

class ListTableViewController: UITableViewController {

    var myList : Array<AnyObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let contex : NSManagedObjectContext = appDel.managedObjectContext!
        
        let freq = NSFetchRequest(entityName: "List")
        
        myList = contex.executeFetchRequest(freq, error: nil)!
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myList.count
    }


     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellID : NSString = "Cell"
        var cell :UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID) as UITableViewCell
        
            var data : NSManagedObject = myList[indexPath.row] as NSManagedObject
            cell.textLabel.text = data.valueForKey("iteam") as? String
        
        var qnt = data.valueForKey("quantity") as String
        var inf = data.valueForKey("info") as String
        
        cell.detailTextLabel?.text = "\(qnt) iteam/s - \(inf)"
        
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier? == "update"{
        
            var selectedIteam : NSManagedObject = myList[self.tableView.indexPathForSelectedRow()!.row] as NSManagedObject
            let IVC : IteamViewController = segue.destinationViewController as IteamViewController
            
            IVC.iteam = selectedIteam.valueForKey("iteam") as String
            IVC.info = selectedIteam.valueForKey("info") as String
            IVC.quantity = selectedIteam.valueForKey("quantity") as String
            IVC.existingIteam = selectedIteam
            
         
        }
        
    }

    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
       
        
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let contex : NSManagedObjectContext = appDel.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete{
            
            
                
                contex.deleteObject(myList[indexPath.row] as NSManagedObject)
            myList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
            
        }
        
        var error : NSError? = nil
        if !contex.save(&error){
            abort()
        }
    }
}
