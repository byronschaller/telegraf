# # encoding: utf-8

# Inspec test for recipe telegraf::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

if os.debian?
  describe apt('https://repos.influxdata.com/ubuntu') do
    it { should exist }
    it { should be_enabled }
  end
end

describe package('telegraf') do
  it { should be_installed }
end

describe service('telegraf') do
  it { should be_enabled }
  it { should be_running }
end
