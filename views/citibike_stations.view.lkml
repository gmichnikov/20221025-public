view: citibike_stations {
  sql_table_name: `bigquery-public-data.new_york_citibike.citibike_stations`;;

  dimension: station_id {
    type: number
    sql: ${TABLE}.station_id ;;
    primary_key: yes
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: latitude  {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude  {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: borough {
    type: string
    sql: CASE WHEN ${latitude} > 1.315450644 * ${longitude} + 138.0400791 THEN "Manhattan" WHEN ${latitude} > 40.73817 THEN "Queens" ELSE "Brooklyn" END ;;
    suggestions: ["Brooklyn", "Manhattan", "Queens"]
  }

  dimension: capacity {
    type: number
    sql: ${TABLE}.capacity ;;
  }

  measure: total_capacity {
    type: sum
    sql: ${capacity} ;;
  }

  measure: average_capacity {
    type: average
    sql: ${capacity} ;;
  }

  dimension: num_bikes_available {
    type: number
    sql: ${TABLE}.num_bikes_available ;;
  }

  dimension: is_installed {
    type: yesno
    sql: ${TABLE}.is_installed ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      station_id,
      name,
      capacity,
      is_installed
    ]
  }
}
