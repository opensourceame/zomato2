module Zomato2

  # Restaurant types
  class Establishment < EntityBase
    attr_reader :city_id, :id, :name

    def initialize(zom_conn, cityid, attributes)
      super(zom_conn)
      @city_id = cityid
      @id  = attributes['id']
      @name = attributes['name']
    end

    def restaurants(start: nil, count: nil)
      q = {category_id: @id, entity_type: 'city', entity_id: @city_id }
      q[:start] = start if start
      q[:count] = count if count
      results = get('search', q)
      results['restaurants'].map { |e| Restaurant.new(@zom_conn, e['restaurant']) }
    end
  end
end

