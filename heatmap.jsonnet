local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local template = grafana.template;
local heatmap = grafana.heatmapPanel;

local dashboard_datasource = "example_datasource";

local rows = [
  {
    row_title: 'Avg._Disk_sec/{Write,Read}',
    metrics: [
      {
        name: 'Avg._Disk_sec/Write',
        db_metric_name: 'Avg._Disk_sec/Write_bucket',
        format: 's',
      },
      {
        name: 'Avg._Disk_sec/Read',
        db_metric_name: 'Avg._Disk_sec/Read_bucket',
        format: 's',
      },
    ],
  },
  {
    row_title: 'Disk_{Writes,Reads}_persec',
    metrics: [
      {
        name: 'Disk_Writes_persec',
        db_metric_name: 'Disk_Writes_persec_bucket',
        format: 'wps',
      },
      {
        name: 'Disk_Reads_persec',
        db_metric_name: 'Disk_Reads_persec_bucket',
        format: 'rps',
      },
    ],
  }]

  {"overwrite": true,
 "dahsboard":
    dashboard.new(
      title='Disk I/O heatmap',
      editable=true,
      graphTooltip='shared_crosshair',
      time_from='now - 3d',
      tags=['SQL-DB']
    )
    .addTemplate(
      template.new(
        name='host',
        datasource=dashboard_datasource,
        query=|||
          import "influxdata/influxdb/schema"
          schema.tagValues(
            bucket: v.defaultBucket,
            tag: "host",
            predicate: (r) => true,
            start: v.timeRangeStart
          )
        |||,
        hide='',
        allValues=null,
        current='all',
        refresh='load',
        includeAll=true,
        multi=true,
      )
    )
    .addRows([
      row.new(title=r.row_title)
      .addPanels([
          heatmap.new(
            title=metric.name,
            yBucketBound='upper',
            dataFormat='tsbuckets',
            hideZeroBuckets=true,
            yAxis_format=metric.format,
            yAxis_decimals=0,
            tooltipDecimals=2
          )
          .addTarget(
            grafana.influxdb.target(
              query=""
            )
        ) for metric in r.metrics]
    for r in rows])
}