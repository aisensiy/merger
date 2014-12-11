class Bargain < ActiveRecord::Base
  extend SimilarCalculatable

  def self.similar_with_index(candidates, attrs, k=5)
    target = attrs.values.map(&:to_f)
    attr_keys = attrs.keys
    candidate_matrix = candidates.map do |candidate|
      candidate.attributes.select { |k, v| attr_keys.include? k }.values.map do |v|
        v.nil? ? 0 : v.to_f
      end
    end

    matrix = [target] + candidate_matrix
    normalized_matrix = transpose(transpose(matrix).map { |v| normalize(v) })

    distances = (1..candidates.size).map do |i|
      [cal_distance(normalized_matrix[0], normalized_matrix[i]), candidates[i - 1]]
    end.sort { |a, b| a[0] <=> b[0] }

    distances.map { |d| [d[1], d[0]] }[0...k]
  end
end
