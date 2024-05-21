module SentierHelper
  def sentier_coordinates_json(sentiers)
    sentier_coordinates = sentiers.map do |sentier|
      departure = {
        lat: sentier.starting_point_lat,
        lng: sentier.starting_point_long,
        type: 'departure'
      }
      arrival = {
        lat: sentier.arrival_point_lat,
        lng: sentier.arrival_point_long,
        type: 'arrival'
      }
      @points_coordinates = sentier.points.sort_by(&:title).map do |point|
        {
          lat: point.lat,
          lng: point.long,
          type: 'point'
        }
      end
      [departure, *@points_coordinates, arrival]
    end
    sentier_coordinates.to_json
  end
end
