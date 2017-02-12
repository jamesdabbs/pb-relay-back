module H
  def self.slug str
    str.gsub(/[$\\]/, '').gsub(/\s+/, '-').downcase
  end

  def self.id obj
    prefix = {
      DB::Space    => 'S',
      DB::Property => 'P',
      DB::Theorem  => 'T'
    }.fetch obj.class

    "#{prefix}#{obj.id.to_s.rjust 5, '0'}"
  end
end
