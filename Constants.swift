

var searchURL = "http://api.wego.com/flights/api/k/2/searches?api_key=f0dae976919329a5098f&ts_code=67b00" as String

var fareURL = "http://api.wego.com/flights/api/k/2/fares?api_key=f0dae976919329a5098f&ts_code=67b00" as String

let networkManagerObject = NetworkManager.sharedNetwork
let utilityObject = Utility.sharedUtility
let parserObject = Parser.alloc()

var baseJsonDetails:Array<AnyObject>!
var airportDetails:Array<AnyObject>! = Array<AnyObject>()
var hotelDetails:Array<AnyObject>! = Array<AnyObject>()

let kAirportDetailsJsonName = "Airport_Details"
let kAirportType    = "Airport"
let kHotelCityType  = "City"

let kAppJson = "application/json"
let kContentType = "Content-Type"
let kAccept = "Accept"
let kHttpTypePost = "POST"
let kHttpTypeGet = "GET"
let kHttpResponseSuccessCode = 200