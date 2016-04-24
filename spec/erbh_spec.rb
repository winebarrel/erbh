describe ERBh do
  subject { described_class.erbh(str, variables, options) }

  let(:options) { {} }

  context 'when evaluate' do
    let(:str) { '<%= @foo %>, <%= @bar %>' }
    let(:variables) { {foo: 100, bar: 'zoo'} }

    it { is_expected.to eq '100, zoo' }
  end

  context 'when evaluate with trim_mode' do
    let(:str) do
      <<-EOS
<%- @foo.each do |i| -%>
<%= i %>
<%- end -%>
      EOS
    end

    let(:variables) { {foo: 1..3} }
    let(:options) { {trim_mode: '-'} }

    it { is_expected.to eq "1\n2\n3\n" }
  end

  context 'when define helper methods' do
    before do
      described_class.define_method(:concat) {|a, b| a.to_s + b.to_s }
    end

    let(:str) { '<%= @foo %>, <%= @bar %>, <%= concat @foo, @bar %>' }
    let(:variables) { {foo: 100, bar: 'zoo'} }

    it { is_expected.to eq '100, zoo, 100zoo' }
  end

  context 'when use _erbout' do
    before do
      described_class.define_method(:chomp) do |obj|
        if obj.nil?
          @_erbout.sub!(/,\s*\z/, '')
          ''
        else
          obj
        end
      end
    end

    let(:str) { '100, <%= chomp @foo %>' }
    let(:variables) { {foo: nil} }

    it { is_expected.to eq '100' }
  end
end
