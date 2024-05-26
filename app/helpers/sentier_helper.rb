module SentierHelper

  def sentiers_coordinates_json(sentiers)
    sentier_coordinates = sentiers.map do |sentier|
      departure = {
        lat: sentier.starting_point_lat,
        lng: sentier.starting_point_long,
        type: 'departure',
        title: sentier.title,
        color: sentier.color,
        id: sentier.id
      }
      arrival = {
        lat: sentier.arrival_point_lat,
        lng: sentier.arrival_point_long,
        type: 'arrival'
      }
    @roads = sentier.roads.sort_by(&:position)
    @points_coordinates = @roads.map do |road|
        {
          lat: road.point.lat,
          lng: road.point.long,
          type: 'point',
          position: road.position
        }
      end
      [departure, *@points_coordinates, arrival]
    end
    sentier_coordinates.to_json
  end

  def sentier_coordinates_json(sentier)
    sentier_coordinates = []
      departure = {
        lat: sentier.starting_point_lat,
        lng: sentier.starting_point_long,
        type: 'departure',
        title: sentier.title,
        color: sentier.color,
        id: sentier.id
      }
      arrival = {
        lat: sentier.arrival_point_lat,
        lng: sentier.arrival_point_long,
        type: 'arrival'
      }
    @roads = sentier.roads.sort_by(&:position)
    @points_coordinates = @roads.map do |road|
        {
          lat: road.point.lat,
          lng: road.point.long,
          type: 'point',
          position: road.position
        }
      end
    sentier_coordinates << departure
    sentier_coordinates.concat(@points_coordinates)
    sentier_coordinates << arrival
    sentier_coordinates.to_json
  end

end
