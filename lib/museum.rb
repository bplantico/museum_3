class Museum
  attr_reader :name,
              :exhibits,
              :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  # If patron_object interests are exhibits in the museum, then recommend the
  # exhibit. Expected return is an array.
  # museum.exhibits and patron.interests are both arrays.
  def recommend_exhibits(patron) #could return to refactor with an enum more
    # suited to the job but this works! :)
    recommended = []
    @exhibits.each do |exhibit|
      recommended << exhibit if patron.interests.include?(exhibit.name)
    end
    recommended
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    exhibit_names = @exhibits.map do |exhibit|
      exhibit.name
    end

    pbei = Hash.new
    exhibits.each do |exhibit|
    pbei[exhibit] = @patrons.find_all { |patron| patron.interests.include?(exhibit.name) }
    end
    pbei
  end

end
