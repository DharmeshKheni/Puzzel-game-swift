import UIKit
import HealthKit

class ViewController: UIViewController {
    
    var allImageViews : [UIImageView] = []
    var allCenters : NSMutableArray = NSMutableArray()
    var randomCenters : NSMutableArray = NSMutableArray()
    var emptySpot : CGPoint = CGPoint()
    var frame : CGPoint = CGPointZero
    var imageDict : NSMutableDictionary = NSMutableDictionary()
    var posStateDict: NSMutableDictionary = NSMutableDictionary()
    var randomImageDict : NSMutableDictionary = NSMutableDictionary()
    var tagVlaue : Int = Int()
    var randomTagValue : Int = Int()

 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagVlaue = 0
        var xCen : CGFloat = 53
        var yCen : CGFloat = 53
        
        for v in 0...2{
            
            for h in 0...2{
                
                let filename = String(format: "Smile_%02i.gif", h+v*3)
                let Image = UIImage(named: filename)
                let myImageView = UIImageView(image: Image)
                var curCenter : CGPoint = CGPointMake(xCen, yCen)
                allCenters.addObject(NSValue(CGPoint : curCenter))
                myImageView.frame = CGRectMake(0, 0, 106, 106)
                myImageView.center = curCenter
                myImageView.tag = tagVlaue
                myImageView.userInteractionEnabled = true
                allImageViews.append(myImageView)
                self.view.addSubview(myImageView)
                frame = CGPointMake(xCen, yCen)
                imageDict.setValue(NSStringFromCGPoint(frame), forKey: NSString(string: "\(tagVlaue)"));
                posStateDict[NSString(format: "%d", tagVlaue)] = "false"
                xCen += 106
                tagVlaue = tagVlaue + 1
            }
            xCen = 53
            yCen += 106
        }
        allImageViews.removeAtIndex(8).removeFromSuperview()
        self.randomizeBlocks()
    }
    
    func randomizeBlocks(){
        

        var centersCopy: NSMutableArray = allCenters.mutableCopy() as NSMutableArray
        
        var randLocInt : Int
        var randLoc : CGPoint
        
    
        for i in allImageViews {
            randLocInt = Int(arc4random()) % centersCopy.count
            randLoc  = centersCopy.objectAtIndex(randLocInt).CGPointValue()
            i.center = randLoc
            i.tag = randomTagValue
            centersCopy.removeObjectAtIndex(randLocInt)
            randomCenters.addObject(NSValue(CGPoint : randLoc))
            randomImageDict.setValue(NSStringFromCGPoint(randLoc), forKey: NSString(string: "\(randomTagValue)"));
            randomTagValue = randomTagValue + 1
        }
        emptySpot = centersCopy.objectAtIndex(0).CGPointValue()
    }
    var leftisEmpty : Bool = Bool()
    var rightisEmpty : Bool = Bool()
    var topisEmpty : Bool = Bool()
    var bottomisEmpty : Bool = Bool()
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        var topCen : CGPoint
        var left : CGPoint
        var right : CGPoint
        var top : CGPoint
        var bottom : CGPoint
        
        let touches = touches.allObjects as [UITouch]
        var myTouch = touches.first
        
        if let myTouch = myTouch{
            
            topCen = myTouch.view.center
            var emptyCenValue : NSValue
            emptyCenValue = NSValue(CGPoint : emptySpot)
            
            left = CGPointMake(topCen.x - 106, topCen.y)
            right = CGPointMake(topCen.x + 106, topCen.y)
            top = CGPointMake(topCen.x, topCen.y+106)
            bottom = CGPointMake(topCen.x, topCen.y-106)
            
            if emptySpot  == left{
                leftisEmpty = true
            }
            if emptySpot  == right{
                rightisEmpty = true
            }
            if emptySpot  == top{
                topisEmpty = true
            }
            if emptySpot  == bottom{
                bottomisEmpty = true
            }
            if leftisEmpty || rightisEmpty || topisEmpty || bottomisEmpty{
                
                UIView.beginAnimations(nil, context:nil)
                UIView.setAnimationDuration(0.5)
                myTouch.view.center = emptySpot
                UIView.commitAnimations()
                emptySpot = topCen
        
                leftisEmpty = false
                rightisEmpty = false
                topisEmpty = false
                bottomisEmpty = false
            }
            
        }
    }
}
