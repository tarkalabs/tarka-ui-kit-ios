//
//  TUICircularProgressView.swift
//
//
//  Created by Arvindh Sukumar on 01/05/23.
//

import SwiftUI

public enum TUICircularProgressViewStyle: EnvironmentKey {
  case determinate, indeterminate
  
  public static var defaultValue: TUICircularProgressViewStyle = .indeterminate
}

/// A view that displays a circular progress indicator.
///
/// Use a `TUICircularProgressView` to show the progress of a task, such as a download or upload operation.
///
/// You can customize the appearance of the progress view by specifying a style. The `determinate` style shows a progress bar that fills up as the task progresses, while the `indeterminate` style shows a spinning wheel that indicates that the task is in progress but does not show the progress itself.
///
/// You can also provide a label to display alongside the progress view. The label can be any SwiftUI view, such as an image or a text view.
///
/// Example usage:
///
///     TUICircularProgressView(progress: 0.4) {
///         Image(systemName: "checkmark.circle.fill")
///             .resizable()
///             .scaledToFit()
///     }
///
/// - Parameters:
///   - progress: The progress of the task, represented as a value between 0 and 1. Ignored if the style is `indeterminate`.
///   - label: A view to display alongside the progress view.
///
public struct TUICircularProgressView<Label: View>: View {
  /// The progress of the task, represented as a value between 0 and 1. Ignored if the style is `indeterminate`.
  public var progress: Double = 0.0
  
  /// A view to display alongside the progress view.
  public let label: () -> Label
  
  public var backgroundCircleColor = Color.surfaceVariantHover
  
  /// The style of the progress view. The default style is `indeterminate`.
  /// If the style is `determinate`, the progress view shows a progress bar that fills up as the task progresses. If the style is `indeterminate`, the progress view shows a spinning wheel that indicates that the task is in progress but does not show the progress itself.
  var style: TUICircularProgressViewStyle = .indeterminate
  
  private let lineWidth: CGFloat = 4
  
  @State private var rotationDegrees = 0.0
  
  /// Creates a circular progress view with the specified progress and label.
  ///
  /// - Parameters:
  ///   - progress: The progress of the task, represented as a value between 0 and 1. Ignored if the style is `indeterminate`.
  ///   - label: A view to display alongside the progress view.
  ///
  public init(progress: Double, @ViewBuilder labelView: @escaping () -> Label) {
    self.progress = progress
    self.label = labelView
  }
  
  public var body: some View {
    ZStack {
      labelView
      progressCircleView
    }
  }
  
  @ViewBuilder
  var progressCircleView: some View {
    if style == .determinate {
      if progress >= 1.0 {
        circularView
      } else {
        circularView
          .rotationEffect(.degrees(-90))
        // Rotate by -90 degrees. Otherwise, the progression starts on
        // the right side of the circle instead of at the top
          .animation(.easeIn, value: progress)
      }
    } else {
      circularView
        .rotationEffect(.degrees(rotationDegrees))
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(
              .linear(duration: 1)
              .speed(0.5)
              .repeatForever(autoreverses: false)
            ) {
              self.rotationDegrees = 360.0
            }
          }
        }
    }
  }
  
  @ViewBuilder
  private var circularView: some View {
    ZStack {
      backgroundCircleView
      progressBorderView
    }
  }
  
  @ViewBuilder
  private var backgroundCircleView: some View {
    Circle()
      .stroke(
        backgroundCircleColor,
        lineWidth: lineWidth
      )
  }
  
  @ViewBuilder
  private var progressBorderView: some View {
    Circle()
      .trim(from: 0, to: style == .determinate ? progress : 0.25)
      .stroke(
        Color.primaryTUI,
        style: StrokeStyle(
          lineWidth: lineWidth
        )
      )
  }
  
  @ViewBuilder
  private var labelView: some View {
    label()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct CircularProgressView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TUICircularProgressView(progress: 0.4) {
        Image(fluent: .reOrder24Regular)
          .scaledToFit()
          .clipped()
      }
      .circularProgressViewStyle(.determinate)
      .frame(width: 40, height: 40)
      
      TUICircularProgressView(progress: 0.4) {
        Image(fluent: .reOrder24Regular)
          .scaledToFit()
          .clipped()
      }
      .circularProgressViewStyle(.indeterminate)
      .frame(width: 100, height: 100)
    }
  }
}
