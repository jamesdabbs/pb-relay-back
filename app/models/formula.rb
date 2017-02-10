class Formula
  def self.parse f
    key, val = f.first
    if key == "and" || key == "or"
      { key => val.map { |sub| parse sub } }
    else
      { propertyId: key, value: val == Universe::TrueId }
    end
  end
end
