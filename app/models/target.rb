class Target < ActiveRecord::Base
  extend SimilarCalculatable

  has_one :deal
  belongs_to :industry

  def self.similar_targets(targets, candidates, attrs, k=10)
    vectors = targets.map do |target|
      target.attributes.select { |k, v| attrs.include? k }.values
    end

    center = attrs.size.times.map do |i|
      sum = 1.0 * vectors.size.times.map { |j| vectors[j][i] }.reduce(&:+)
      sum / targets.size
    end

    candidate_matrix = candidates.map do |candidate|
      candidate.attributes.select { |k, v| attrs.include? k }.values
    end

    matrix = [center] + candidate_matrix
    normalized_matrix = transpose(transpose(matrix).map { |v| normalize(v) })

    distances = (1..candidates.size).map do |i|
      [cal_distance(normalized_matrix[0], normalized_matrix[i]), candidates[i - 1]]
    end.sort { |a, b| a[0] <=> b[0] }

    distances.map { |d| [d[1], d[0]] }[0...k]
  end

end
