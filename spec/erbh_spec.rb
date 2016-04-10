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
end
