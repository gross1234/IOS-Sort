# IOS Sort

A SwiftUI iOS application that visualizes different sorting algorithms in real-time.

## Features

- **Interactive Sorting Visualization**: Watch sorting algorithms work in real-time with animated bars
- **Multiple Algorithms**: 
  - Bubble Sort
  - Quick Sort
  - Merge Sort
  - Selection Sort
- **Modern SwiftUI Interface**: Clean, intuitive design following iOS design guidelines
- **MVVM Architecture**: Well-structured codebase with separation of concerns

## Project Structure

```
IOS Sort/
├── Views/                 # SwiftUI Views
│   └── ContentView.swift
├── ViewModels/           # Business Logic
│   └── SortViewModel.swift
├── Models/               # Data Models
│   └── SortModel.swift
├── Extensions/           # Swift Extensions
│   └── Array+Extensions.swift
├── Services/            # Service Layer (future)
├── Utils/               # Utility Functions (future)
└── Resources/           # Assets and Resources
    └── Assets.xcassets/
```

## Requirements

- iOS 18.2+
- Xcode 16.2+
- Swift 5.0+

## Getting Started

1. Clone the repository
2. Open `IOS Sort.xcodeproj` in Xcode
3. Build and run on simulator or device

## Usage

1. **Generate Numbers**: Tap "Generate Numbers" to create a random array
2. **Select Algorithm**: Choose from the segmented control at the top
3. **Sort**: Tap "Sort" to visualize the selected algorithm
4. **Watch**: Observe the sorting process with animated visualization

## Architecture

### MVVM Pattern
- **Model**: `SortModel` - Contains algorithm information and metadata
- **View**: `ContentView` - SwiftUI interface for user interaction
- **ViewModel**: `SortViewModel` - Handles business logic and state management

### Key Components

#### SortViewModel
- Manages the array of numbers to be sorted
- Handles algorithm selection and execution
- Provides real-time updates for visualization
- Uses `@Published` properties for reactive UI updates

#### SortModel
- Defines available sorting algorithms
- Provides algorithm metadata (time complexity, space complexity, descriptions)
- Extensible for adding new algorithms

#### Array Extensions
- Provides utility methods for array manipulation
- Includes shuffling, sorting validation, and swap operations

## Development Guidelines

### Code Style
- Follow SwiftLint configuration (see `.swiftlint.yml`)
- Use meaningful variable and function names
- Add documentation comments for public APIs
- Follow Swift naming conventions

### Git Workflow
- Use descriptive commit messages
- Create feature branches for new functionality
- Keep commits focused and atomic

### Testing
- Write unit tests for ViewModels and Models
- Test edge cases and error conditions
- Maintain high test coverage

## Future Enhancements

- [ ] Add more sorting algorithms (Heap Sort, Radix Sort, etc.)
- [ ] Implement algorithm performance comparison
- [ ] Add sound effects for sorting steps
- [ ] Support for custom array sizes
- [ ] Algorithm explanation tooltips
- [ ] Export sorting animations as videos
- [ ] Dark mode support
- [ ] Accessibility improvements

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run SwiftLint to ensure code quality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- SwiftUI framework for the modern UI
- Apple's Human Interface Guidelines for design inspiration
- Computer Science education resources for algorithm implementations
