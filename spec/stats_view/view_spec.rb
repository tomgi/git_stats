require 'spec_helper'

describe GitStats::StatsView::View do
  let(:view) { GitStats::StatsView::View.new(double('view_data'), 'out_path') }

  it 'should find all haml except partials and layout in templates directory' do
    view.all_templates.should =~ %w(files activity/index general authors lines)
  end
end