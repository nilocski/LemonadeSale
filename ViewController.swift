//
//  ViewController.swift
//  LemonadeSale
//
//  Created by Colin Mackenzie on 24/09/2014.
//  Copyright (c) 2014 Colin Mackenzie. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    var lemonadeResources:Resources = Resources(resourceMoney: 10, resourceLemons: 1, resourceIceCubes: 1)
    var resourcePrice = ResourcePrice()
    
    var buyingLemons:Int = 0
    var buyingIceCubes:Int = 0
    var mixingLemons:Int = 0
    var mixingIceCubes:Int = 0
    
    var glassesMade:Int = 0
    var glassesSold:Int = 0
    var lemonadeType:Double = 0.3
    
    var customers:Int = 0
    var customerNumber:Int = 0
    
    var timer = NSTimer()
    
    
    // Labels
    
    @IBOutlet weak var resourcesMoneyLabel:     UILabel!
    @IBOutlet weak var resourcesLemonLabel:     UILabel!
    @IBOutlet weak var resourcesIceCubLabel:    UILabel!
    @IBOutlet weak var buyingLemonLabel:        UILabel!
    @IBOutlet weak var buyingIceCubeLabel:      UILabel!
    @IBOutlet weak var lemonPriceLabel:         UILabel!
    @IBOutlet weak var iceCubePriceLabel:       UILabel!
    @IBOutlet weak var lemonMixLabel:           UILabel!
    @IBOutlet weak var iceCubeMixLabel:         UILabel!
    @IBOutlet weak var glassesLemonadeLabel:    UILabel!
    @IBOutlet weak var glassesSoldLabel:        UILabel!
    @IBOutlet weak var customArrivesLabel:      UILabel!
    
    @IBOutlet weak var lemonadeStandImageView:  UIImageView!
    @IBOutlet weak var startMixAndSaleButton:   UIButton!
    @IBOutlet weak var startNewGameButton:      UIButton!
    
    
    
    var weatherArray: [[Int]] = [[1, 2, 3, 4], [5, 8, 10, 9], [22, 25, 27, 23]]
    
    var weatherToday: [Int] = [0, 0, 0, 0]
    
    var weatherImageView: UIImageView = UIImageView (frame: CGRectMake(20, 55, 100, 100))
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        simulateWeatherToday()
        
        self.view.addSubview(weatherImageView)
        
        setupInitialLabelsEtc()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    func setupInitialLabelsEtc()
    {
        setResourceMoneyLabel()
        setResourceLemonLabel()
        setResourceIceCubeLabel()
        lemonPriceLabel.text    = "Lemons for $\(resourcePrice.lemonPrice)"
        iceCubePriceLabel.text  = "Ice Cubes for $\(resourcePrice.iceCubePrice)"
        buyingLemonLabel.text   = "-"
        buyingIceCubeLabel.text = "-"
        lemonMixLabel.text      = "-"
        iceCubeMixLabel.text    = "-"
        
        lemonadeStandImageView.hidden = true
        startMixAndSaleButton.hidden  = false
        glassesLemonadeLabel.hidden   = true
        glassesSoldLabel.hidden       = true
        customArrivesLabel.hidden     = true
        startNewGameButton.hidden     = true
        
        glassesSold = 0

    }
    
    func setLemonMixLabel()
    {
        lemonMixLabel.text = "\(mixingLemons)"
    }
    func setIceCubeMixLabel()
    {
        iceCubeMixLabel.text = "\(mixingIceCubes)"
    }
   
    func setResourceMoneyLabel()
    {
        resourcesMoneyLabel.text = "$ \(lemonadeResources.resourceMoney)"
    }
    func setResourceLemonLabel()
    {
        if lemonadeResources.resourceLemons == 1
        {
            resourcesLemonLabel.text = "\(lemonadeResources.resourceLemons) Lemon"
        }
        else
        {
            resourcesLemonLabel.text = "\(lemonadeResources.resourceLemons) Lemons"
        }
    }
    func setResourceIceCubeLabel()
    {
        if lemonadeResources.resourceIceCubes == 1
        {
            resourcesIceCubLabel.text = "\(lemonadeResources.resourceIceCubes) Ice Cube"
        }
        else
        {
            resourcesIceCubLabel.text = "\(lemonadeResources.resourceIceCubes) Ice Cubes"
        }
    }
    func setBuyingLemonLabel()
    {
        buyingLemonLabel.text = "\(buyingLemons)"
    }
    func setBuyingIceCubeLabel()
    {
        buyingIceCubeLabel.text = "\(buyingIceCubes)"
    }
    func setGlassesLemonadeLabel()
    {
        glassesLemonadeLabel.text = "\(glassesMade) glasses lemonade"
    }
    func setGlassesSoldLabel()
    {
        glassesSoldLabel.text = "\(glassesSold) glasses sold"
    }
    
     // Buttons
    @IBAction func buyLemonButtonPressed(sender: UIButton)
    {
        if lemonadeResources.resourceMoney >= resourcePrice.lemonPrice
        {
            buyingLemons += 1
            lemonadeResources.resourceLemons += 1
            lemonadeResources.resourceMoney -= resourcePrice.lemonPrice
            
            setResourceMoneyLabel()
            setResourceLemonLabel()
            setBuyingLemonLabel()
            
        }
        else
        {
            showAlertWithText(header: "sorry not enough money", message: "you only have $\(lemonadeResources.resourceMoney)")
        }
    }
    
    @IBAction func buyIceCubeButtonPressed(sender: UIButton)
    {
        if lemonadeResources.resourceMoney >= resourcePrice.iceCubePrice
        {
            buyingIceCubes += 1
            lemonadeResources.resourceIceCubes += 1
            lemonadeResources.resourceMoney -= resourcePrice.iceCubePrice
            
            setResourceMoneyLabel()
            setResourceIceCubeLabel()
            setBuyingIceCubeLabel()
            
        }
        else
        {
            showAlertWithText(header: "sorry not enough money", message: "you only have $\(lemonadeResources.resourceMoney)")
        }
    }

    @IBAction func sellLemonButtonPressed(sender: UIButton)
    {
        if buyingLemons > 0 && lemonadeResources.resourceLemons > 0
        {
            buyingLemons -= 1
            lemonadeResources.resourceLemons -= 1
            lemonadeResources.resourceMoney += resourcePrice.lemonPrice
            
            setResourceMoneyLabel()
            setResourceLemonLabel()
            setBuyingLemonLabel()
        }
    }
    
    
    @IBAction func sellIceCubeButtonPressed(sender: UIButton)
    {
        if buyingIceCubes > 0 && lemonadeResources.resourceIceCubes > 0
        {
            buyingIceCubes -= 1
            lemonadeResources.resourceIceCubes -= 1
            lemonadeResources.resourceMoney += resourcePrice.iceCubePrice
            
            setResourceMoneyLabel()
            setResourceIceCubeLabel()
            setBuyingIceCubeLabel()
        }
    }
    
    
    @IBAction func increaseLemonsInMixButtonPressed(sender: UIButton)
    {
        if mixingLemons >= lemonadeResources.resourceLemons
        {
            if lemonadeResources.resourceLemons == 1
            {
                showAlertWithText(header: "sorry no lemons", message: "you only have \(lemonadeResources.resourceLemons) lemon")
            }
            else
            {
                showAlertWithText(header: "sorry no lemons", message: "you only have \(lemonadeResources.resourceLemons) lemons")
            }
        }
        else
        {
            mixingLemons += 1
            
            setLemonMixLabel()
        }
    }
    
    
    @IBAction func increaseIceCubesInMixButtonPressed(sender: UIButton)
    {
        if mixingIceCubes >= lemonadeResources.resourceIceCubes
        {
            if lemonadeResources.resourceIceCubes == 1
            {
                showAlertWithText(header: "sorry no ice cubes", message: "you only have \(lemonadeResources.resourceIceCubes) ice cube")
            }
            else
            {
                showAlertWithText(header: "sorry no ice cubes", message: "you only have \(lemonadeResources.resourceIceCubes) ice cubes")
            }
        }
        else
        {
            mixingIceCubes += 1
            
            setIceCubeMixLabel()
        }

    }
    
    
    @IBAction func decreaseLemonsInMixButtonPressed(sender: UIButton)
    {
        if mixingLemons > 0
        {
            mixingLemons -= 1
            
            setLemonMixLabel()
        }
    }
    
    @IBAction func decreaseIceCubesInMixButtonPressed(sender: UIButton)
    {
        if mixingIceCubes > 0
        {
            mixingIceCubes -= 1
            
            setIceCubeMixLabel()
        }
    }
    
    @IBAction func mixTheLemonadeAndSellButtonPressed(sender: UIButton)
    {
        if mixingIceCubes < 1
        {
            showAlertWithText( message: "need ice cubes for the mix")
            
        }
        else if mixingLemons < 1
        {
            showAlertWithText( message: "need lemons for the mix")
            
        }
        else if mixingLemons > lemonadeResources.resourceLemons
        {
            showAlertWithText( message: "not enough lemons for this mix")
        }
        else if mixingIceCubes > lemonadeResources.resourceIceCubes
        {
            showAlertWithText( message: "not enough ice cubes for this mix")
        }
        else  // new sales day
        {
            simulateWeatherToday()
            
            // making the lemonade mix
            lemonadeResources.resourceLemons -= mixingLemons
            lemonadeResources.resourceIceCubes -= mixingIceCubes
            buyingLemons = 0
            buyingIceCubes = 0
            
            setResourceLemonLabel()
            setResourceIceCubeLabel()
            setBuyingLemonLabel()
            setBuyingIceCubeLabel()
            
            lemonadeStandImageView.hidden = false
            startMixAndSaleButton.hidden  = true
            glassesLemonadeLabel.hidden   = false
            glassesSoldLabel.hidden       = false
            
            let glassesAvailable = (mixingLemons + mixingIceCubes) * 7
            
            glassesMade += glassesAvailable
            lemonadeType = Double( Double(mixingLemons) / Double(mixingIceCubes + 4) )
            
            setGlassesLemonadeLabel()
            setGlassesSoldLabel()
            
            
            var average = findAverage(weatherToday)
            
            //println("\(average)")
            
            customers   = Int(arc4random_uniform(UInt32(average)))  + Int(arc4random_uniform(UInt32(glassesAvailable)))
            
            
            customerNumber = 0
            /*
                use a NSTimer to send customers to our lemonade stand.
            */
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "customerThere", userInfo: nil, repeats: true)
 
            
        }
    }
    
    
    @IBAction func startNewGameButtonPressed(sender: UIButton)
    {
        lemonadeResources.resourceMoney    = 10
        lemonadeResources.resourceLemons   = 1
        lemonadeResources.resourceIceCubes = 1
        
        buyingLemons = 0
        buyingIceCubes = 0
        mixingLemons = 0
        mixingIceCubes = 0
        
        glassesMade = 0
        
        setupInitialLabelsEtc()
        
    }
    
    
    
    
    
    func customerThere()
    {
        println("customer \(customers)")
        
        if customers > 0
        {
            customers -= 1
            customerNumber += 1
            self.customArrivesLabel.hidden = false
            
            let preference = Double(arc4random_uniform(UInt32(100)))/100
            println("pref=\(preference) lemontype=\(self.lemonadeType)")
            if preference > self.lemonadeType
            {
                // no sale
                
                self.customArrivesLabel.text = "Customer number \(customerNumber) rushes by !"
                self.customArrivesLabel.textColor = UIColor.blueColor()
            }
            else
            {
                
                
                self.glassesSold += 1
                self.lemonadeResources.resourceMoney += 1
                self.setGlassesSoldLabel()
                self.setResourceMoneyLabel()
                
                self.customArrivesLabel.text = "Customer number \(customerNumber) buys Lemon"
                self.customArrivesLabel.textColor = UIColor.greenColor()
                
            }
 
        }
        else
        {
            /*
                no more customers, cancel Timer , tidy up.
            */
            customers = 0
            timer.invalidate()
            
            self.setGlassesLemonadeLabel()
            self.setGlassesSoldLabel()
            self.setResourceMoneyLabel()
            self.lemonadeStandImageView.hidden = true
            self.startMixAndSaleButton.hidden  = false
            self.customArrivesLabel.hidden = true
            
            // if player runs out of money, let him replay
            if lemonadeResources.resourceMoney < 3
            {
                startNewGameButton.hidden = false
            }
            else
            {
                startNewGameButton.hidden = true
            }

        }
        
    }

    
    func simulateWeatherToday()
    {
        let index = Int(arc4random_uniform((UInt32(weatherArray.count))))
        weatherToday = weatherArray[index]
        
        switch index
        {
        case 0: weatherImageView.image = UIImage(named: "Cold")
        case 1: weatherImageView.image = UIImage(named: "Mild")
        case 2: weatherImageView.image = UIImage(named: "Warm")
        default: weatherImageView.image = UIImage(named: "Warm")
        }

    }
    
    func findAverage(data:[Int]) -> Int
    {
        var sum = 0
        
        for x in data
        {
            sum += x
        }
        
        var average:Double = Double(sum) / Double(data.count)
        var rounded:Int = Int(ceil(average))
        return rounded
    }

        

    func showAlertWithText (header : String = "ooops", message : String)
    {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

