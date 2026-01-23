module SentierHelper

  def sentiers_coordinates_json(sentiers)
    sentier_coordinates = sentiers.map do |sentier|
      departure = {
        lat: sentier.starting_point_lat,
        lng: sentier.starting_point_long,
        type: 'departure',
        title: sentier.title,
        color: sentier.color,
        id: sentier.id,
        address: sentier.depart_address
      }
      arrival = {
        lat: sentier.arrival_point_lat,
        lng: sentier.arrival_point_long,
        title: sentier.title,
        address: sentier.arrival_address,
        boucle: sentier.is_boucle,
        type: 'arrival'
      }
      
      # Récupérer les points d'intérêt et les waypoints, les fusionner et trier par position
      @roads = sentier.roads.sort_by(&:position)
      @points_coordinates = @roads.map do |road|
        {
          lat: road.point.lat,
          lng: road.point.long,
          type: 'point',
          position: road.position
        }
      end
      
      @waypoints = sentier.waypoints.sort_by(&:position)
      @waypoints_coordinates = @waypoints.map do |waypoint|
        {
          lat: waypoint.lat.to_f,
          lng: waypoint.lng.to_f,
          type: 'waypoint',
          position: waypoint.position.to_f
        }
      end
      
      # Fusionner et trier tous les points intermédiaires par position
      all_intermediate = (@points_coordinates + @waypoints_coordinates).sort_by { |p| p[:position] }
      
      [departure, *all_intermediate, arrival]
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
        id: sentier.id,
        address: sentier.depart_address
      }
      arrival = {
        lat: sentier.arrival_point_lat,
        lng: sentier.arrival_point_long,
        title: sentier.title,
        address: sentier.arrival_address,
        boucle: sentier.is_boucle,
        type: 'arrival'
      }
    
    # Récupérer les points d'intérêt et les waypoints, les fusionner et trier par position
    @roads = sentier.roads.sort_by(&:position)
    @points_coordinates = @roads.map do |road|
      {
        lat: road.point.lat,
        lng: road.point.long,
        type: 'point',
        position: road.position
      }
    end
    
    @waypoints = sentier.waypoints.sort_by(&:position)
    @waypoints_coordinates = @waypoints.map do |waypoint|
      {
        lat: waypoint.lat.to_f,
        lng: waypoint.lng.to_f,
        type: 'waypoint',
        position: waypoint.position.to_f
      }
    end
    
    # Fusionner et trier tous les points intermédiaires par position
    all_intermediate = (@points_coordinates + @waypoints_coordinates).sort_by { |p| p[:position] }
    
    sentier_coordinates << departure
    sentier_coordinates.concat(all_intermediate)
    sentier_coordinates << arrival
    sentier_coordinates.to_json
  end

end
