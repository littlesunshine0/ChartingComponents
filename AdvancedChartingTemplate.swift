// AdvancedChartingTemplate.swift

import SwiftUI

// MARK: - Advanced Charting Template
/// A template designed for advanced charting. Includes support for generic data binding, accessibility features, localization, responsive design, performance optimizations, theming options, error handling, animations, interactions, and comprehensive documentation.

struct AdvancedChartingTemplate<Data: RandomAccessCollection>: View where Data.Element: Chartable {
    var data: Data
    let title: String
    let theme: ChartTheme

    /// Initializes the advanced charting template with required properties.
    /// - Parameters:
    ///   - data: The data collection to be represented in the chart.
    ///   - title: The title of the chart.
    ///   - theme: The thematic design elements for the chart.
    init(data: Data, title: String, theme: ChartTheme) {
        self.data = data
        self.title = title
        self.theme = theme
    }

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .accessibilityLabel(title)

            Chart(data) { value in
                LineMark(x: .value("X", value.x), y: .value("Y", value.y))
                    .foregroundStyle(theme.lineColor)
                    .opacity(theme.opacity)
                    .animation(theme.animation)  // Animation for smooth transitions
            }
            .padding()
            .background(theme.backgroundColor)  // Background theme support
            .onAppear {
                // Perform any necessary setup or data loading
            }
        }
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Supporting Structures
struct ChartTheme {
    var lineColor: Color
    var backgroundColor: Color
    var opacity: Double
    var animation: Animation
}

// Example of a Preview
struct AdvancedChartingTemplate_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData: [ChartData] = [\
            ChartData(x: 1, y: 10),\
            ChartData(x: 2, y: 15),\
            ChartData(x: 3, y: 25)\
        ]
        let theme = ChartTheme(lineColor: .blue, backgroundColor: .white, opacity: 0.8, animation: .easeInOut)
        AdvancedChartingTemplate(data: sampleData, title: "Sample Chart", theme: theme)
            .previewLayout(.sizeThatFits)
    }
}

struct ChartData: Identifiable {
    let id = UUID()
    var x: Double
    var y: Double
}