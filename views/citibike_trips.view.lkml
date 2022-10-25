view: citibike_trips {
  sql_table_name: `bigquery-public-data.new_york_citibike.citibike_trips`;;

  dimension: primary_key {
    primary_key: yes
    sql: CONCAT(${TABLE}.start_station_id, ${TABLE}.bikeid, ${TABLE}.starttime) ;;
  }

  dimension: start_station_id {
    type: number
    sql: ${TABLE}.start_station_id ;;
  }

  dimension: bikeid {
    type: number
    sql: ${TABLE}.bikeid ;;
  }

  dimension: birth_year {
    type: number
    sql: ${TABLE}.birth_year ;;
  }

  dimension: usertype {
    type: string
    sql: ${TABLE}.usertype ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: duration_given_seconds {
    type: number
    sql: ${TABLE}.tripduration ;;
  }

  measure: total_duration {
    label: "Total Duration (seconds)"
    type: sum
    sql: ${duration_given_seconds} ;;
  }

  measure: average_duration {
    label: "Average Duration (seconds)"
    type: average
    sql: ${duration_given_seconds} ;;
  }

  dimension_group: start_time {
    type: time
    timeframes: [raw, date, month, year, hour_of_day, month_name, day_of_week, time_of_day]
    sql: ${TABLE}.starttime;;
  }

  dimension_group: stop_time {
    type: time
    timeframes: [raw, date, month, year, hour_of_day, month_name, day_of_week, time_of_day]
    sql: ${TABLE}.stoptime;;
  }

  dimension_group: duration_calc {
    type: duration
    sql_start: ${start_time_raw};;
    sql_end: ${stop_time_raw};;
    intervals: [second, minute]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      primary_key,
      start_station_id,
    ]
  }
}
