var width = 800;
var height = 600;

requestFromServer();

function requestFromServer() {
  $.ajax({
    type: "GET",
    contentType: "application/json; charset=utf-8",
    url: 'root/service',
    dataType: 'json',
    success: function (data) {
      draw(data);
    },
    error: function (result) {
      error(result);
    }
  });
}

function infectIds(data) {
  data.forEach(function(userId, idx) {
    setTimeout(function() {
      var nodes = $("." + userId).find("circle");
      nodes.each(function(node) {
        $(this).addClass("node-infected");
        $(this).removeClass("node-disinfected");
      })
    }, idx * 100);
  });
}

function reset(data) {
  data.forEach(function(userId, idx) {
    var nodes = $("." + userId).find("circle");
    nodes.each(function(node) {
      $(this).addClass("node-disinfected");
      $(this).removeClass("node-infected");
    })
  });
}

function draw(data) {
  var nodes = [];
  var edges = [];
  var alreadySeen = [];

  data.forEach(function(classroom) {
    var teacher = classroom.teacher;
    if (alreadySeen.includes(teacher.id)){
      return;
    }
    alreadySeen.push(teacher.id);
    // Add the teacher to the list of nodes
    nodes.push({id: teacher.id,
                infected: teacher.site_version != 1,
                name: teacher.name});
    var teacherIndex = nodes.length - 1;

    // Add the edges from the teachers to students
    classroom.students.forEach(function(student) {
      if(alreadySeen.includes(student.id)){
        var studentIndex = nodes.map(function(n) { return n.id; }).indexOf(student.id);
        edges.push({source: teacherIndex, target: studentIndex, value: student.id});
      } else {
        alreadySeen.push(student.id);
        // Add the nodes for students
        nodes.push({id: student.id,
                    infected: student.site_version != 1,
                    name: student.name});
        var studentIndex = nodes.length - 1;
        edges.push({source: teacherIndex, target: studentIndex, value: student.id});
      }
    });
  });
  var svg = d3.select('#graph').attr('width', width).attr('height', height);

  var force = d3.layout.force()
  .size([width, height])
  .nodes(nodes)
  .gravity(0.05)
  .charge(-95)
  .linkDistance(60)
  .links(edges);

  var edge = svg.selectAll('.edge')
  .data(edges)
  .enter().append('line')
  .attr('class', 'edge');

  var gnode = svg.selectAll('g.gnode')
  .data(nodes)
  .enter().append("g")
  .attr("class", "node")
  .attr("class", function(d) { return d.id; })
  .call(force.drag);

  // use gnodes to wrap circles with text
  var node = gnode.append("circle")
  .attr("class", "node")
  .attr("class", "node-disinfected")
  .attr("class", infectedClass)
  .attr("r", 14)
  .call(force.drag);

  function infectedClass(d) {
    return d.infected ? "node-infected" : "node-disinfected";
  };

  var labels = gnode.append("text")
  .text(function(d) { return d.id; });

  force.on("tick", function() {
    // Update the edges
    edge.attr("x1", function(d) { return d.source.x; })
    .attr("y1", function(d) { return d.source.y; })
    .attr("x2", function(d) { return d.target.x; })
    .attr("y2", function(d) { return d.target.y; });

  // Translate the groups
  gnode.attr("transform", function(d) {
    return 'translate(' + [d.x, d.y] + ')';
  });

});
  force.start();
}

function error(result) {
  console.log(result);
}

$(document).ready(function() {
  $('form').submit(function(event) {
    event.preventDefault();
    var formData = $('form').serialize();
    $.ajax({
      url: "root/infect",
      data: formData,
      success: function(data) {
        infectIds(data);
      }
    });
  })

  $("#reset").click(function(){
    $.ajax({
      url: "root/reset",
      success: function(data) {
        reset(data);
      }
    });
  });
});
