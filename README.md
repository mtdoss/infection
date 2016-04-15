<h1><a href="http://dry-taiga-44278.herokuapp.com/">Infection</a></h1>
Check out the site <a href="http://dry-taiga-44278.herokuapp.com/">here!</a>

![Infection image](http://imgur.com/BkD2kmI.jpg "Visualization")

# Overview

The purpose of this project is to simulate a way to roll out A-B testing in a
case where all users within a connected graph need to have the same version of
the site. I implemented the relationships between users by having classrooms. A
classroom can have one teacher and many students. This was my best guess for
how a website like Khan Academy would actually implement these relationships.

The key is to be able to get close to a target number of users infected with
potentially many different subgraphs. I treated this like a knapsack problem,
where each distinct subgraph has a weight of the size of the graph, i.e. the
number of users in that graph. I implement `limited_infection` by partitioning
the graph into all of its distinct subgraphs and then solving the knapsack
problem from there.

Note that this is exponential with respect to the number of distinct subgraphs.
I opted for this approach under the assumption that there probably wouldn't be
too many distinct subraphs; otherwise this will be untenably slow, and another
approach should be taken (perhaps a greedy algorithm). But this means that if,
for instance, your target is 6 and you have a range of 0, and you have
classrooms of size 5, 2, and 4, it will correctly select that classes with size
2 and 4, rather than first selecting the class with size 5 and not being able
to achieve the target.

## Visualizing

I used D3 to visualize the problem. There is some seed data to work with as an
example; feel free to play around! Nodes turn red as they are infected. Hit
"Reset" to turn everything back to uninfected.

## Running the tests

To run the specs, `cd` into the directory, run `bundle install`, and then run
`rspec spec/`. I ran this with Ruby version 2.1.3 and Bundler version 1.7.11,
though I doubt you will need those version numbers.

## If I had more time...

This was a really fun project and there are a lot of things I could do to
improve upon it! One thing is obviously performance. Solving this via subsets
starts to run into big issues with a large number of distinct subgraphs. The
partitioning still would be O(n), so I could partition and then maybe use a
greedy algorithm if there were a lot of distinct sugraphs.

Also, my Javascript code especially could use some refactoring - it's not the
prettiest code :) .
