class Buyer < ActiveRecord::Base
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


  private

  def transpose(matrix)
    m = matrix.size
    n = matrix[0].size

    newmatrix = n.times.map { Array.new(m) }
    m.times do |i|
      n.times do |j|
        newmatrix[j][i] = matrix[i][j]
      end
    end

    newmatrix
  end

  def normalize(vector)
    min_value = vector.min
    range = vector.max - min_value
    vector.map do |v|
      1.0 * (v - min_value) / range
    end
  end

  def cal_distance(a, b)
    n = a.size
    n.times.map { |i| (a[i] - b[i]) ** 2 }.reduce(&:+)
  end

end
