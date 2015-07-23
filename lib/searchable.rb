#---
# Excerpted from "Advanced Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/fr_arr for more book information.
#---
module Searchable

  def searchable_by(*column_names)
    default_options = column_names.extract_options!
    default_fields = []
    [column_names].flatten.each do |name|
      default_fields << name
    end

    scope :search, ->(*args) {
      options = args.extract_options!
      query, fields = args

      fields ||= default_fields

      # split the query by commas as well as spaces, just in case
      words = query.split(",").map(&:split).flatten

      binds = {}    # bind symbols
      or_frags = [] # OR fragments
      count = 1     # to keep count on the symbols and OR fragments

      words.each do |word|
        like_frags = [fields].flatten.map { |f| "LOWER(#{f}) LIKE :word#{count}" }
        or_frags << "(#{like_frags.join(" OR ")})"
        binds["word#{count}".to_sym] = "%#{word.to_s.downcase}%"
        count += 1
      end

      where or_frags.join(" AND "), binds, default_options.merge(options)
    }
  end

end
