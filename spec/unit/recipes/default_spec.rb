#
# Cookbook Name:: telegraf
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'telegraf::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    # it 'adds the influxdata apt repo' do
    #   expect(chef_run).to add_apt_repository('influxdata')
    # end

    it 'installs the telegraf package' do
      expect(chef_run).to install_package('telegraf')
    end

    it 'starts the telegraf service' do
      expect(chef_run).to start_service('telegraf')
    end

    it 'enables the telegraf service' do
      expect(chef_run).to enable_service('telegraf')
    end
  end
end
