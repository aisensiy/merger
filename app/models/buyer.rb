class Buyer < ActiveRecord::Base
  include SimilarCalculatable

  has_many :deals
  belongs_to :industry

  def similar_buyers(candidates, attrs, k=5)
    target = self.attributes.select { |k, v| attrs.include? k }.values
    candidate_matrix = candidates.map do |candidate|
      candidate.attributes.select { |k, v| attrs.include? k }.values
    end

    matrix = [target] + candidate_matrix
    normalized_matrix = transpose(transpose(matrix).map { |v| normalize(v) })

    distances = (1..candidates.size).map do |i|
      [cal_distance(normalized_matrix[0], normalized_matrix[i]), candidates[i - 1]]
    end.sort { |a, b| a[0] <=> b[0] }

    distances.map { |d| [d[1], d[0]] }[0...k]
  end

end
