## Default data collection interval for all inputs
property :interval, String, identity: true, default: "10s"
## Rounds collection interval to 'interval'
## ie, if interval="10s" then always collect on :00, :10, :20, etc.
property :round_interval, [TrueClass, FalseClass], identity: true, default: true

## Telegraf will send metrics to outputs in batches of at most
## metric_batch_size metrics.
## This controls the size of writes that Telegraf sends to output plugins.
property :metric_batch_size, Fixnum, identity: true, default: 1000

## For failed writes, telegraf will cache metric_buffer_limit metrics for each
## output, and will flush this buffer on a successful write. Oldest metrics
## are dropped first when this buffer fills.
## This buffer only fills when writes fail to output plugin(s).
property :metric_buffer_limit, Fixnum, identity: true, default: 10000

## Collection jitter is used to jitter the collection by a random amount.
## Each plugin will sleep for a random time within jitter before collecting.
## This can be used to avoid many plugins querying things like sysfs at the
## same time, which can have a measurable effect on the system.
property :collection_jitter, String, identity: true, default: "0s"

## Default flushing interval for all outputs. You shouldn't set this below
## interval. Maximum flush_interval will be flush_interval + flush_jitter
property :flush_interval, String, identity: true, default: "10s"
## Jitter the flush interval by a random amount. This is primarily to avoid
## large write spikes for users running a large number of telegraf instances.
## ie, a jitter of 5s and interval 10s means flushes will happen every 10-15s
property :flush_jitter, String, identity: true, default: "0s"

## By default, precision will be set to the same timestamp order as the
## collection interval, with the maximum being 1s.
## Precision will NOT be used for service inputs, such as logparser and statsd.
## Valid values are "ns", "us" (or "µs"), "ms", "s".
property :precision, String, identity: true, default: ""

## Logging configuration:
## Run telegraf with debug log messages.
property :debug, [TrueClass, FalseClass], identity: true, default: false
## Run telegraf in quiet mode (error log messages only).
property :quiet, [TrueClass, FalseClass], identity: true, default: false
## Specify the log file name. The empty string means to log to stderr.
property :logfile, String, identity: true, default: ""

## Override default hostname, if empty use os.Hostname()
property :hostname, String, identity: true, default: ""
## If set to true, do no set the "host" tag in the telegraf agent.
property :omit_hostname, [TrueClass, FalseClass], identity: true, default: false

default_action :create

action :create do
  template '/tmp/test.config' do
    source 'test.config.erb'
    variables(
    'agent': [{"interval" => new_resource.interval},{"round_interval" => new_resource.round_interval}]
    #'agent': node['telegraf']['config']['agent']
    )
  end
end

action :test do

end
