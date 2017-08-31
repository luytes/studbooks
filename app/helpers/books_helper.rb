module BooksHelper
  def cutoff_text(string)
    string.length > 121 ? string.first(120) + "..." : string
  end
  def cutoff_text_2(string)
    string.length > 114 ? string.first(103) + "..." : string
  end
end
