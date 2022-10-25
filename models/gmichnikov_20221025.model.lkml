connection: "looker-ryflood-connection"

# include all the views
include: "/views/**/*.view"

datagroup: gmichnikov_20221025_default_datagroup {
  sql_trigger: SELECT EXTRACT(HOUR FROM CURRENT_TIME());;
  max_cache_age: "30 minutes"
}

persist_with: gmichnikov_20221025_default_datagroup

explore: citibike_stations {}

explore: citibike_trips {
  join: citibike_stations {
    sql_on: ${citibike_trips.start_station_id} = ${citibike_stations.station_id} ;;
    relationship: many_to_one
  }
}
