class Util
  def self.classify(str)
    str.gsub!("_", " ")
    str = str.split(" ").map(&:capitalize).join()

    str
  end
end