
enum CommonOptions: String {
    
    case Id = "id"
    case Search_id = "search_id"
    case Trip_id = "trip_id"
    case Fares_query_type = "fares_query_type"
    case Trips = "trips"
    case Routes = "routes"
    case Currency_code = "currency_code"
}

enum TicketClassOptions: String {
    
    case Economy = "economy"
    case Business = "business"
    case First = "first"
}

enum TripOptions: String {
    
    case Id = "id"
    case Departure_code = "departure_code"
    case Departure_name = "departure_name"
    case Departure_state_code = "departure_state_code"
    case Departure_country_code = "departure_country_code"
    case Departure_country_name = "departure_country_name"
    case Arrival_code = "arrival_code"
    case Arrival_name = "arrival_name"
    case Arrival_city = "arrival_city"
    case Departure_city = "departure_city"
    case Arrival_country_code = "arrival_country_code"
    case Arrival_country_name = "arrival_country_name"
    case Outbound_date = "outbound_date"
    case Inbound_date = "inbound_date"
    case Trip_type = "trip_type"
}

enum SearchOptions: String {
    
    case Adults_count = "adults_count"
    case Children_count = "children_count"
    case User_country_code = "user_country_code"
    case Country_site_code = "country_site_code"
    case Cabin = "cabin"
}

enum FareOptions: String {
   
    case Fares = "fares"
    case Best_fare = "best_fare"
    case Outbound_segments = "outbound_segments"
    case Inbound_segments = "inbound_segments"
    case Price = "price"
    case Provider_code = "provider_code"
    case Description = "description"
    case Alliance = "alliance"
    case Deeplink = "deeplink"
    case Deeplink_params = "deeplink_params"
    case Route = "route"
    case Placement_type = "placement_type"
    case Fare_id = "fare_id"
    case Marketing_airline_code = "marketing_airline_code"
}

