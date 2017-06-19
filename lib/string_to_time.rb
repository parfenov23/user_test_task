class StringToTime
  def self.sec(text)
    text.scan(%r{[0-9]+ [a-z]+}).inject(0){|sum,x| sum + eval(x.gsub(" ", ".")).to_i }
  end
end
