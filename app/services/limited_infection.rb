require 'set'
class LimitedInfection
  # If not given a range, default to 5% of the total user count.
  DEFAULT_RANGE_PERCENT = 0.05

  def initialize(target:, range:, new_version_number:)
    @target = target
    @range = range || User.count * DEFAULT_RANGE_PERCENT
    @new_version_number = new_version_number
  end

  def call
    partition = partition_users_into_subgraphs
    user_ids = []

    counts = partition.keys
    subsets = subsets(counts)
    options = subsets.map { |subset| subset.inject(&:+) }.compact.sort
    val = options.min_by { |option| (option - @target).abs }
    if val.between?(@target - @range, @target + @range)
      options = subsets.find { |subset| subset.inject(&:+) == val }
      options.each do |option|
        user_ids += partition[option]
      end

      user_ids.each do |user_id|
        user = User.find(user_id)
        user.site_version = @new_version_number
        user.save!
      end

      user_ids
    else
      false
    end
  end

  private

  # Splits the userbase into arrays of connected components. Each array is a
  # list of connected users.
  def partition_users_into_subgraphs
    already_partitioned = Set.new
    partition = []
    # The values are the partitions, the keys are the counts of each partition
    counts_of_partitions_hash = {}
    num_users_partitioned = 0

    until num_users_partitioned == User.count
      users_to_partition = User.all.pluck(:id) - already_partitioned.to_a
      # We have to go through all of them eventually, so it doesn't matter
      # which one we start from
      user_id = users_to_partition.sample
      user_graph = graph_for_user(user_id)
      partition << user_graph
      already_partitioned.merge(user_graph)
      num_users_partitioned = partition.flatten.count
    end

    partition.each { |sg| counts_of_partitions_hash[sg.length] = sg }

    counts_of_partitions_hash
  end

  def graph_for_user(user_id)
    connected_ids = [user_id]
    already_seen = Set.new

    # This is just like a normal BFS, except instead of shifting the element
    # off each time, we just increment the index. This is because we have to
    # keep track of the entire graph
    index = 0
    until already_seen.length == connected_ids.length
      user_id = connected_ids[index]
      user = User.find(user_id)
      connected_users = user.students + user.teachers
      connected_users.each do |connected_user|
        next if already_seen.include?(connected_user.id)
        connected_ids << connected_user.id
      end
      index += 1
      already_seen << user_id
    end

    connected_ids
  end

  def subsets(arr)
    return [[]] if arr.empty?

    val = arr[0]
    rest = subsets(arr.drop(1))

    new_subs = rest.map { |sub| sub + [val] }

    rest + new_subs
  end

end
