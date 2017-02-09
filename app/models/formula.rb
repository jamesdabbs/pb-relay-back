class Formula
  TrueId = Value.find_by!(name: "True").id

  def self.parse json
    if sf = json["and"]
      { and: sf.map { |f| parse f }}
    elsif sf = json["or"]
      { or: sf.map { |f| parse f }}
    else
      propId, valId = json.first
      { propertyId: propId, value: valId == TrueId }
    end
  end
end
