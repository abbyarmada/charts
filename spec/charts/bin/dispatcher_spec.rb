RSpec.describe Charts::Dispatcher do
  let(:graph) { dispatcher.graph }
  let(:dispatcher) { Charts::Dispatcher.new(options) }
  let(:options) do
    {
      data:   data,
      type:   type,
      style:  style,
      colors: colors
    }
  end
  let(:data) { [5, 2] }
  let(:colors) { ['blue', 'green'] }
  let(:type) { 'svg' }
  let(:style) { 'circle' }

  describe 'type txt' do
    let(:type) { 'txt' }
    it 'selects SymbolCountChart' do
      expect(graph).to be_an_instance_of(Charts::SymbolCountChart)
    end
  end

  describe 'style circle' do
    let(:style) { 'circle' }
    it 'selects CircleCountChart' do
      expect(graph).to be_an_instance_of(Charts::CircleCountChart)
    end
  end

  describe 'style cross' do
    let(:style) { 'cross' }
    it 'selects CrossCountChart' do
      expect(graph).to be_an_instance_of(Charts::CrossCountChart)
    end
  end

  describe 'style manikin' do
    let(:style) { 'manikin' }
    it 'selects ManikinCountChart' do
      expect(graph).to be_an_instance_of(Charts::ManikinCountChart)
    end
  end

  describe 'style bar' do
    let(:data) { [[5, 2]] }
    let(:style) { 'bar' }
    it 'selects BarChart' do
      expect(graph).to be_an_instance_of(Charts::BarChart)
    end
  end

  describe 'graph options' do
    let(:options) do
      {
        data:             data,
        style:            style,
        type:             type,
        filename:         filename,
        colors:           colors,
        columns:          7,
        item_width:       111,
        item_height:      222,
        background_color: 'Silver',
        bogus_option:     '123123'
      }
    end
    let(:filename) { 'some_file.png' }
    it 'sets the graph data' do
      expect(graph.data).to eq(data)
    end
    it 'sets the graph filename' do
      expect(graph.options).to include(filename: filename)
    end
    it 'sets the graph item_width' do
      expect(graph.options).to include(item_width: 111)
    end
    it 'sets the graph item_height' do
      expect(graph.options).to include(item_height: 222)
    end
    it 'sets the graph columns' do
      expect(graph.options).to include(columns: 7)
    end
    it 'sets the graph colors' do
      expect(graph.options).to include(colors: colors)
    end
    it 'sets the graph backgroundcolor' do
      expect(graph.options).to include(background_color: 'Silver')
    end
    it 'does not set unknown options' do
      expect(graph.options).not_to include(bogus_option: '123123')
    end
  end

  describe '#render' do
    it 'calls render on the graph and prints the result' do
      expect_any_instance_of(Charts::CircleCountChart).to receive(:render).and_return('SVG_CONTENT')
      expect($stdout).to receive(:puts).with('SVG_CONTENT')
      dispatcher.render
    end
  end

  describe '#render when a filename is set' do
    let(:options) { { data: data, type: type, style: style, filename: 'file.svg' } }
    it 'calls render on the graph and prints nothing' do
      expect_any_instance_of(Charts::CircleCountChart).to receive(:render)
      expect($stdout).not_to receive(:puts)
      dispatcher.render
    end
  end
end
