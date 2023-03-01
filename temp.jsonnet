local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local row = grafana.row;
local template = grafana.template;
local graphPanel = grafana.graphPanel;
local singlestat = grafana.singlestat;
local prometheus = grafana.prometheus;
// Define the first object


// Define the first object
local dashboard1 = {
  // ...
};

// Define the second object
local dashboard2 = {
  // ...
};

// Output the first object to a file
std.manifestYamlDoc(
  "dashboard1.json",
  function() dashboard1
)

// Output the second object to a file
std.manifestYamlDoc(
  "dashboard2.json",
  function() dashboard2
)