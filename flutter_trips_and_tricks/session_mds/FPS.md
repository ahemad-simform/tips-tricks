
  

# About FPS in Flutter: Optimizing Performance for Fluid UI/UX

  

  

## What is FPS?

  

  

-  **Frames Per Second (FPS)** measures how many frames your app renders each second.

  

- Higher FPS leads to smoother user experiences, while lower FPS can cause lag and jank.

  

- Smooth animations and responsive UI typically require **60 FPS**.

  

  

### Common Causes of FPS Drops

  

  

-  **Heavy Build Methods**

  

-  **Overdraw Issues**

  

-  **Expensive Layout Passes**

  

-  **Blocking the Main Thread**

  

-  **Complex Animations**

  

-  **Memory Leaks**

  

  

### Understanding FPS Drops in Flutter's Rendering Pipeline

  

  

Flutter's rendering pipeline consists of the following stages:

  

  

**Widgets → Element → RenderObject → Painting → Compositing → Display**

  

  

### Impact on FPS

  

  

### 1. Widgets

  

Building blocks of a Flutter app's UI.

  

  

-  **Frequent or unnecessary widget rebuilds** can degrade performance, reducing FPS.

  

-  **Complex widget trees** can increase build times, leading to frame drops.

  

  

### 2. Element

  

The Element Tree represents the instantiation of widgets and manages their lifecycle and state.

  

  

-  **Efficient updates** to the element tree ensure smooth UI transitions and animations.

  

-  **A deep or frequently changing element tree** can increase update times, affecting FPS.

  

  

### 3. RenderObject

  

Responsible for layout and painting. It determines the size and position of widgets on the screen.

  

  

-  **Complex or deeply nested layouts** increase computation time during the layout phase, potentially causing frame drops.

  

-  **Efficient layout calculations** are crucial for maintaining high FPS.

  

  

### 4. Painting

  

Converts layout information into visual elements (colors, shapes, text) that are rendered on the screen.

  

  

-  **Overdrawing:** Painting the same pixel multiple times increases rendering time.

  

-  **Complex Visuals:** Shadows, gradients, and transformations can be computationally intensive, reducing FPS.

  

  

### 5. Compositing

  

Assembles all painted layers into a single image that is sent to the GPU for rendering.

  

  

-  **Layer Count:** Excessive layers increase the compositing workload, potentially lowering FPS.

  

-  **Blending Operations:** Complex blending of semi-transparent layers can be GPU-intensive.

  

  

### 5. Display

  

Sends the final composed image to the device's GPU for rendering on the screen.

  

  

-  **Pipeline Bottlenecks:** Delays in previous phases prevent frames from being rendered at the desired FPS, leading to jank.

  

-  **Synchronization:** Ensuring frame rendering aligns with the display's refresh rate is crucial for smooth animations.

  

  

## Fixing FPS Drops: Optimization Techniques

  

  

### Minimizing Widget Depth

  

  

- Before Optimization: Deeply Nested Widgets

  

```dart

Column(

children: [

Row(

children: [

Container(

child: Text('Nested'),

),

],

),

],

);

```

  

  

- After Optimization: Flattened Widget Tree

  

```dart

Container(

child: Text('Flattened'),

);

```

  

  

### Avoiding Unnecessary Updates with Keys

  

  

- Without Keys: Flutter may not efficiently recognize widget changes

  

  

```dart
ListView(
children: items.map((item) => ListTile(title: Text(item))).toList(),
);
```

  

  

- With Keys: Flutter can efficiently manage widget states

  

```dart
ListView(
children: items
.map((item) => ListTile(
key: ValueKey(item.id),
title: Text(item.name),
)
).toList(),
);
```

  

### Efficient State Management

  

  

**Use state management solutions like Provider, Bloc, or Riverpod to manage state efficiently.**

  

**Ensure that only necessary widgets are rebuilt when the state changes.**

  

  

### Efficiently Updating Only Necessary Widgets

  

  

**Identify and update only the widgets that need to change instead of rebuilding the entire widget tree.**

  

  

### Avoiding Over-Nesting

  

  

**Simplify widget trees by reducing unnecessary nesting to improve build performance.**

  

  

### Using RepaintBoundary to Isolate Repaints

  

  

- Without RepaintBoundary: Entire widget tree may repaint

  

  

```dart
Column(
children: [
StaticHeader(),
DynamicContent(),
],
);
```

  
  

- With RepaintBoundary: Only DynamicContent repaints when it changes

  

[https://api.flutter.dev/flutter/widgets/RepaintBoundary-class.html](https://api.flutter.dev/flutter/widgets/RepaintBoundary-class.html)

  

```dart

Column(
children: [
const  StaticHeader(),
RepaintBoundary(
child: DynamicContent(),
),
],
);

```

  

### Avoiding Blocking the Main Thread

  

- Offload heavy computations to isolates or asynchronous operations to keep the main thread responsive.

  

### Image and Asset Optimization

  

- Use optimized image formats and sizes.

- Cache images to reduce loading times and rendering overhead.

  

  

## Measuring FPS in Flutter

  

### Flutter DevTools

  

-  **Performance Overlay:** Visualizes rendering performance, showing frame rendering times.

  

-  **Timeline View:** Provides a detailed view of each phase in the rendering pipeline per frame. *(Open DevTools and navigate to the Timeline tab to inspect frame-by-frame performance.)*

  

-  **Inspector:** Examines the widget tree and identifies unnecessary rebuilds.

  

### Demo: Optimized vs. Unoptimized Screen

  

- Check fps directory in lib.